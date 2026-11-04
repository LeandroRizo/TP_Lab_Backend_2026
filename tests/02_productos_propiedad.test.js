import { describe, it, beforeEach, after } from "node:test";
import assert from "node:assert/strict";

// Criterio 2.4: Aserciones de NODE_ENV y del nombre de la base antes de importar la app
assert.equal(process.env.NODE_ENV, "test", "NODE_ENV debe ser 'test'");
assert.match(process.env.DATABASE_URL || "", /_test(\?|$)/i, "DATABASE_URL debe ser una base *_test");

const {
    BASE_URL,
    prisma,
    generarToken,
    obtenerUsuariosPrueba,
    limpiarBaseDeDatos,
    cerrarEntornoPrueba
} = await import("./testHelper.js");

describe("02. Productos, Persistencia en Base y Propiedad de Artesanos (Criterios 2.4 y 2.5)", () => {
    let ctx;
    let usuarioArtesano2;
    let artesano2Token;
    let categoria;
    let productoInicial;

    beforeEach(async () => {
        // Criterio 2.4: Limpieza en beforeEach en orden de dependencias
        await limpiarBaseDeDatos();
        ctx = await obtenerUsuariosPrueba();

        categoria = await prisma.categoria.create({
            data: { nombre: "Tejidos Test", descripcion: "Categoría de prueba" }
        });

        const localidad = await prisma.localidad.findFirst();
        const rubro = await prisma.rubro.findFirst();

        usuarioArtesano2 = await prisma.usuario.create({
            data: {
                nombre: "Artesano Dos",
                email: `artesano2_${Date.now()}_${Math.floor(Math.random() * 1000)}@poncho.test`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolArtesano.id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Artesano",
                        apellido: "Dos",
                        dni: `DNI_2_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
                        id_localidad: localidad.id_localidad,
                        id_rubro: rubro.id_rubro
                    }
                }
            },
            include: { artesano: true }
        });
        artesano2Token = generarToken(usuarioArtesano2.id_usuario);

        productoInicial = await prisma.producto.create({
            data: {
                nombre: "Manta de Alpaca Original",
                descripcion: "Manta tejida a mano artesanal",
                precio: 45000,
                id_categoria: categoria.id_categoria,
                id_artesano: ctx.usuarioArtesano.artesano.id_artesano
            }
        });
    });

    after(async () => {
        // Criterio 2.4: Desconexión en after
        await cerrarEntornoPrueba(); // Cierra servidor efímero y ejecuta prisma.$disconnect()
    });

    it("Consulta pública de productos GET /api/productos devuelve 200 con paginación", async () => {
        const res = await fetch(`${BASE_URL}/api/productos`);
        assert.equal(res.status, 200);
        const json = await res.json();
        assert.ok(Array.isArray(json.data));
        assert.ok(json.meta);
        assert.equal(json.meta.page, 1);
    });

    it("Solo ARTESANO puede crear productos; no-artesano recibe HTTP 403", async () => {
        const resAdmin = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Producto Admin Hack",
                precio: 1000,
                id_categoria: categoria.id_categoria
            })
        });
        assert.equal(resAdmin.status, 403);
    });

    it("Criterio 2.5: Alta correcta de producto verificada directamente en la base de datos (pertenece a la cuenta autenticada)", async () => {
        const res = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Poncho de Vicuña Imperial",
                descripcion: "Tejido fino en telar catamarqueño",
                precio: 290000,
                id_categoria: categoria.id_categoria
            })
        });

        assert.equal(res.status, 201);
        const prod = await res.json();
        assert.ok(prod.id_producto);
        assert.equal(prod.id_artesano, ctx.usuarioArtesano.artesano.id_artesano);

        // Verificación directa en la base de datos PostgreSQL (*_test)
        const enBase = await prisma.producto.findUnique({
            where: { id_producto: prod.id_producto }
        });
        assert.ok(enBase, "El producto debe estar persistido en la base de datos");
        assert.equal(enBase.nombre, "Poncho de Vicuña Imperial");
        assert.equal(enBase.id_artesano, ctx.usuarioArtesano.artesano.id_artesano);
    });

    it("Criterio 1.6 y 2.3: Alta de producto con campo prohibido artesanoId o id_artesano en el body es rechazada con HTTP 400", async () => {
        const res = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Poncho Con Campo Extra",
                precio: 50000,
                id_categoria: categoria.id_categoria,
                artesanoId: usuarioArtesano2.artesano.id_artesano
            })
        });
        assert.equal(res.status, 400);
    });

    it("Artesano lista sus propios productos en GET /api/productos/mis-productos", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/mis-productos`, {
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });

        assert.equal(res.status, 200);
        const lista = await res.json();
        assert.ok(Array.isArray(lista));
        assert.ok(lista.some(p => p.id_producto === productoInicial.id_producto));
    });

    it("Artesano modifica su propio producto exitosamente", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoInicial.id_producto}`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Manta de Alpaca Test Modificada",
                precio: 48000
            })
        });

        assert.equal(res.status, 200);
        const prod = await res.json();
        assert.equal(prod.nombre, "Manta de Alpaca Test Modificada");
        assert.equal(Number(prod.precio), 48000);
    });

    it("Criterio 2.5: Acceso a un recurso ajeno (PUT y DELETE) devuelve HTTP 404 comprobando en la base que el registro sigue existiendo y no cambió de dueño", async () => {
        // 1. Intento de modificación por Artesano 2 -> 404
        const resPut = await fetch(`${BASE_URL}/api/productos/${productoInicial.id_producto}`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${artesano2Token}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Intento Hack",
                precio: 100
            })
        });

        assert.equal(resPut.status, 404);
        const dataPut = await resPut.json();
        assert.equal(dataPut.mensaje, "Producto no encontrado");

        // 2. Intento de eliminación por Artesano 2 -> 404
        const resDel = await fetch(`${BASE_URL}/api/productos/${productoInicial.id_producto}`, {
            method: "DELETE",
            headers: { Authorization: `Bearer ${artesano2Token}` }
        });

        assert.equal(resDel.status, 404);
        const dataDel = await resDel.json();
        assert.equal(dataDel.mensaje, "Producto no encontrado");

        // 3. Comprobar directamente en la base de datos que el registro sigue existiendo intacto y no cambió de dueño
        const registroEnBase = await prisma.producto.findUnique({
            where: { id_producto: productoInicial.id_producto }
        });
        assert.ok(registroEnBase, "El producto debe seguir existiendo en la base de datos");
        assert.equal(registroEnBase.nombre, "Manta de Alpaca Original");
        assert.equal(Number(registroEnBase.precio), 45000);
        assert.equal(
            registroEnBase.id_artesano,
            ctx.usuarioArtesano.artesano.id_artesano,
            "El producto NO debe haber cambiado de dueño"
        );
    });

    it("Artesano intentando modificar producto inexistente recibe idéntico HTTP 404", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/99999999`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Inexistente",
                precio: 100
            })
        });

        assert.equal(res.status, 404);
        const data = await res.json();
        assert.equal(data.mensaje, "Producto no encontrado");
    });

    it("Artesano elimina su propio producto con HTTP 204", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoInicial.id_producto}`, {
            method: "DELETE",
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });

        assert.equal(res.status, 204);

        const enBase = await prisma.producto.findUnique({
            where: { id_producto: productoInicial.id_producto }
        });
        assert.equal(enBase, null);
    });
});
