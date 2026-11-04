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
const { invalidarCache } = await import("../src/utils/cache.js");

describe("06. Reportes, Caché, Tendencias de Búsqueda y Documentación Swagger (/docs)", () => {
    let ctx;

    before(async () => {
        await limpiarBaseDeDatos();
        ctx = await obtenerUsuariosPrueba();
    });

    after(async () => {
        await cerrarEntornoPrueba();
    });

    it("Solo ADMINISTRADOR puede acceder a reportes; usuario no admin recibe HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });
        assert.equal(res.status, 403);
    });

    it("Admin obtiene reporte general consolidado en GET /api/reportes (HTTP 200)", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });

        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(data.resumen);
        assert.equal(typeof data.resumen.total_artesanos, "number");
        assert.ok(Array.isArray(data.artesanos_por_localidad));
        assert.ok(Array.isArray(data.artesanos_por_rubro));
        assert.ok(data.stands);
        assert.equal(typeof data.stands.ocupados, "number");
        assert.equal(typeof data.stands.disponibles, "number");
        assert.ok(Array.isArray(data.productos_por_artesano));
    });

    it("Caché en memoria de reportes responde X-Cache MISS en primera consulta, HIT en segunda, no invalida ante fallos y se invalida automáticamente tras escritura exitosa", async () => {
        invalidarCache();

        // 1. Primera consulta -> X-Cache: MISS
        const resMiss = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });
        assert.equal(resMiss.status, 200);
        assert.equal(resMiss.headers.get("x-cache"), "MISS");
        const dataAntes = await resMiss.json();
        const totalProductosAntes = dataAntes.resumen.total_productos;

        // 2. Segunda consulta sin cambios -> X-Cache: HIT
        const resHit = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });
        assert.equal(resHit.status, 200);
        assert.equal(resHit.headers.get("x-cache"), "HIT");

        // 3. Operación de escritura fallida (400 Datos inválidos) -> NO invalida caché
        const resFallida = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "   ",
                precio: -10
            })
        });
        assert.equal(resFallida.status, 400);

        const resHitTrasFallo = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });
        assert.equal(resHitTrasFallo.status, 200);
        assert.equal(resHitTrasFallo.headers.get("x-cache"), "HIT");

        // 4. Operación de escritura real exitosa (crear producto) -> Invalida caché automáticamente
        let categoria = await prisma.categoria.findFirst();
        if (!categoria) {
            categoria = await prisma.categoria.create({ data: { nombre: "Tejidos Cache", descripcion: "Cat test" } });
        }

        const resCrearProd = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id_categoria: categoria.id_categoria,
                nombre: "Poncho Invalidador de Cache",
                precio: 95000
            })
        });
        assert.equal(resCrearProd.status, 201);

        // 5. Nueva consulta al reporte -> X-Cache: MISS y datos actualizados
        const resMissPostEscritura = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });
        assert.equal(resMissPostEscritura.status, 200);
        assert.equal(resMissPostEscritura.headers.get("x-cache"), "MISS");
        const dataDespues = await resMissPostEscritura.json();
        assert.equal(dataDespues.resumen.total_productos, totalProductosAntes + 1);
    });

    it("Admin accede a reporte específico de ocupación de stands", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes/stands-ocupacion`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });

        assert.equal(res.status, 200);
        const data = await res.json();
        assert.equal(typeof data.total_stands, "number");
        assert.equal(typeof data.porcentaje_ocupacion, "number");
    });

    it("Middleware registra consulta de visitante al buscar productos", async () => {
        const terminoUnico = `busqueda_poncho_${Date.now()}`;
        const resBusqueda = await fetch(`${BASE_URL}/api/productos?nombre=${terminoUnico}`);
        assert.equal(resBusqueda.status, 200);

        const resStats = await fetch(`${BASE_URL}/api/estadisticas/tendencias`);
        assert.equal(resStats.status, 200);
        const stats = await resStats.json();

        assert.ok(stats.total_consultas_registradas > 0);
        assert.ok(stats.terminos_populares.some(t => t.termino === terminoUnico));
    });

    it("Criterio 1.1: Documentación Swagger UI responde HTTP 200 en /docs y /api-docs antes del manejador 404", async () => {
        const resDocs = await fetch(`${BASE_URL}/docs`);
        assert.equal(resDocs.status, 200);
        const htmlDocs = await resDocs.text();
        assert.ok(htmlDocs.includes("SwaggerUIBundle"));
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
});
