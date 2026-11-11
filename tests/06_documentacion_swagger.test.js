import { describe, it, before, after } from "node:test";
import assert from "node:assert/strict";

// Criterio 2.4: Aserciones de NODE_ENV y del nombre de la base antes de importar la app
assert.equal(process.env.NODE_ENV, "test", "NODE_ENV debe ser 'test'");
assert.match(process.env.DATABASE_URL || "", /_test(\?|$)/i, "DATABASE_URL debe ser una base *_test");

const {
    BASE_URL,
    prisma,
    obtenerUsuariosPrueba,
    limpiarBaseDeDatos,
    cerrarEntornoPrueba
} = await import("./testHelper.js");

describe("06. Documentación Swagger (/docs) y Consultas Paginadas de Catálogos (Entregas 3 y 5)", () => {
    let ctx;

    before(async () => {
        await limpiarBaseDeDatos();
        ctx = await obtenerUsuariosPrueba();
    });

    after(async () => {
        await cerrarEntornoPrueba();
    });

    it("Criterio 1.1: Documentación Swagger UI responde HTTP 200 en /docs y /api-docs antes del manejador 404 usando swagger-ui-express local", async () => {
        const resDocs = await fetch(`${BASE_URL}/docs`);
        assert.equal(resDocs.status, 200);
        const htmlDocs = await resDocs.text();
        assert.ok(htmlDocs.includes("Swagger UI"));
        assert.equal(htmlDocs.includes("unpkg.com"), false, "Swagger UI debe servirse localmente sin depender de CDN externo");

        const resJsLocal = await fetch(`${BASE_URL}/docs/swagger-ui-bundle.js`);
        assert.equal(resJsLocal.status, 200);

        const resUi = await fetch(`${BASE_URL}/api-docs`);
        assert.equal(resUi.status, 200);

        const resJson = await fetch(`${BASE_URL}/docs/swagger.json`);
        assert.equal(resJson.status, 200);
        const spec = await resJson.json();
        assert.equal(spec.openapi, "3.0.0");
        assert.ok(spec.components?.securitySchemes?.bearerAuth);
        assert.ok(spec.paths["/api/auth/login"]);

        // Comprobar manejador 404 posterior a /docs
        const res404 = await fetch(`${BASE_URL}/api/ruta-que-no-existe`);
        assert.equal(res404.status, 404);
    });

    it("Criterio 1.4: El contrato OpenAPI documenta las operaciones de las Entregas 1 a 5 (auth, solicitudes, usuarios, artesanos, productos, stands y catálogos)", async () => {
        const resJson = await fetch(`${BASE_URL}/docs/swagger.json`);
        assert.equal(resJson.status, 200);
        const spec = await resJson.json();

        const rutasObligatorias = [
            "/api/auth/register",
            "/api/auth/login",
            "/api/auth/me",
            "/api/auth/logout",
            "/api/postulacion",
            "/api/solicitudes/",
            "/api/solicitudes/{id}",
            "/api/solicitudes/{id}/resolver",
            "/api/usuarios/",
            "/api/usuarios/administrador",
            "/api/artesanos/",
            "/api/productos/",
            "/api/productos/mis-productos",
            "/api/stands/",
            "/api/stands/ubicacion"
        ];

        for (const ruta of rutasObligatorias) {
            assert.ok(spec.paths[ruta], `La ruta ${ruta} debe estar documentada en el contrato OpenAPI`);
        }

        // Verificar que no queden rutas de entregas posteriores (reportes o estadísticas)
        assert.equal(spec.paths["/api/reportes/"], undefined);
        assert.equal(spec.paths["/api/estadisticas/tendencias"], undefined);
    });

    it("Entrega 3: Consultas de catálogos auxiliares soportan filtros, ordenamiento y metadatos de paginación", async () => {
        await prisma.categoria.createMany({
            data: [
                { nombre: "Alfarería Norteña", descripcion: "Cerámica" },
                { nombre: "Tejidos de Llama", descripcion: "Textiles" }
            ]
        });

        const res = await fetch(`${BASE_URL}/api/categorias?nombre=Tejidos&page=1&limit=5&sortBy=nombre&order=asc`);
        assert.equal(res.status, 200);
        const body = await res.json();
        assert.ok(Array.isArray(body.data));
        assert.equal(body.data.length, 1);
        assert.equal(body.data[0].nombre, "Tejidos de Llama");
        assert.equal(body.meta.page, 1);
        assert.equal(body.meta.limit, 5);
        assert.equal(body.meta.total, 1);
        assert.equal(typeof body.meta.totalPages, "number");
        assert.equal(typeof body.meta.hasNextPage, "boolean");
        assert.equal(typeof body.meta.hasPreviousPage, "boolean");
    });

    it("Entrega 3: GET /api/productos filtra correctamente por rango de precios (precioMin y precioMax)", async () => {
        const categoria = await prisma.categoria.create({
            data: { nombre: "Categoría Rango Precios", descripcion: "Prueba de precios" }
        });
        const idArtesano = ctx.usuarioArtesano.artesano.id_artesano;

        await prisma.producto.createMany({
            data: [
                { nombre: "Bufanda Económica", precio: 15000, id_categoria: categoria.id_categoria, id_artesano: idArtesano },
                { nombre: "Poncho Precio Medio", precio: 45000, id_categoria: categoria.id_categoria, id_artesano: idArtesano },
                { nombre: "Poncho Vicuña Premium", precio: 120000, id_categoria: categoria.id_categoria, id_artesano: idArtesano }
            ]
        });

        const res = await fetch(`${BASE_URL}/api/productos?precioMin=30000&precioMax=60000`);
        assert.equal(res.status, 200);
        const body = await res.json();
        assert.ok(Array.isArray(body.data));
        assert.equal(body.data.length, 1);
        assert.equal(body.data[0].nombre, "Poncho Precio Medio");
        assert.equal(Number(body.data[0].precio), 45000);
    });

    it("Entrega 3: GET /api/artesanos filtra correctamente por localidad (id_localidad) y rubro (id_rubro)", async () => {
        const localidadFiltro = await prisma.localidad.create({
            data: { nombre: "Santa María Filtro" }
        });
        const rubroFiltro = await prisma.rubro.create({
            data: { nombre: "Orfebrería Filtro", descripcion: "Platería tradicional" }
        });

        await prisma.usuario.create({
            data: {
                nombre: "Lucía Orfebre",
                email: `lucia_orfebre_${Date.now()}@poncho.test`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolArtesano.id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Lucía",
                        apellido: "Orfebre",
                        dni: `DNI_LUCIA_${Date.now()}`,
                        id_localidad: localidadFiltro.id_localidad,
                        id_rubro: rubroFiltro.id_rubro
                    }
                }
            }
        });

        const res = await fetch(
            `${BASE_URL}/api/artesanos?id_localidad=${localidadFiltro.id_localidad}&id_rubro=${rubroFiltro.id_rubro}`
        );
        assert.equal(res.status, 200);
        const body = await res.json();
        assert.ok(Array.isArray(body.data));
        assert.equal(body.data.length, 1);
        assert.equal(body.data[0].nombre, "Lucía");
        assert.equal(body.data[0].apellido, "Orfebre");
        assert.equal(body.data[0].id_localidad, localidadFiltro.id_localidad);
        assert.equal(body.data[0].id_rubro, rubroFiltro.id_rubro);
    });
});
