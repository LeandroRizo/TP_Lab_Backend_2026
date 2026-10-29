import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import prisma from "../src/prisma.js";
import { BASE_URL, generarToken, obtenerUsuariosPrueba } from "./testHelper.js";

describe("02. Productos y Propiedad de Artesanos", () => {
    let ctx;
    let usuarioArtesano2;
    let artesano2Token;
    let categoria;
    let productoCreadoId;

    before(async () => {
        ctx = await obtenerUsuariosPrueba();

        // Categoría para pruebas
        categoria = await prisma.categoria.findFirst();
        if (!categoria) {
            categoria = await prisma.categoria.create({
                data: { nombre: "Tejidos Test", descripcion: "Categoría de prueba" }
            });
        }

        // Segundo artesano independiente para probar propiedad cruzada
        let localidad = await prisma.localidad.findFirst();
        let rubro = await prisma.rubro.findFirst();

        usuarioArtesano2 = await prisma.usuario.create({
            data: {
                nombre: "Artesano Dos",
                email: `artesano2_${Date.now()}@poncho.test`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolArtesano.id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Artesano",
                        apellido: "Dos",
                        dni: `DNI_2_${Date.now()}`,
                        id_localidad: localidad.id_localidad,
                        id_rubro: rubro.id_rubro
                    }
                }
            },
            include: { artesano: true }
        });
        artesano2Token = generarToken(usuarioArtesano2.id_usuario);
    });

    it("Consulta pública de productos GET /api/productos devuelve 200 con paginación", async () => {
        const res = await fetch(`${BASE_URL}/api/productos`);
        assert.equal(res.status, 200);
        const json = await res.json();
        assert.ok(Array.isArray(json.data));
        assert.ok(json.meta);
        assert.ok(json.meta.page);
    });

    it("Solo ARTESANO puede crear productos; no-artesano recibe HTTP 403", async () => {
        // Admin intentando crear producto
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

    it("Artesano crea producto propio; id_artesano proviene del contexto autenticado", async () => {
        const res = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Manta de Alpaca Test",
                descripcion: "Manta tejida a mano artesanal",
                precio: 45000,
                id_categoria: categoria.id_categoria,
                id_artesano: 999999 // Debe ser ignorado por el backend
            })
        });

        assert.equal(res.status, 201);
        const prod = await res.json();
        assert.ok(prod.id_producto);
        assert.equal(prod.id_artesano, ctx.usuarioArtesano.artesano.id_artesano);
        productoCreadoId = prod.id_producto;
    });

    it("Artesano lista sus propios productos en GET /api/productos/mis-productos", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/mis-productos`, {
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });

        assert.equal(res.status, 200);
        const lista = await res.json();
        assert.ok(Array.isArray(lista));
        assert.ok(lista.some(p => p.id_producto === productoCreadoId));
    });

    it("Artesano modifica su propio producto exitosamente", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoCreadoId}`, {
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

    it("Artesano intentando modificar producto ajeno recibe HTTP 404 'Producto no encontrado'", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoCreadoId}`, {
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

        assert.equal(res.status, 404);
        const data = await res.json();
        assert.equal(data.mensaje, "Producto no encontrado");
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

    it("Artesano intentando eliminar producto ajeno recibe HTTP 404 'Producto no encontrado'", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoCreadoId}`, {
            method: "DELETE",
            headers: { Authorization: `Bearer ${artesano2Token}` }
        });

        assert.equal(res.status, 404);
        const data = await res.json();
        assert.equal(data.mensaje, "Producto no encontrado");
    });

    it("Artesano elimina su propio producto con HTTP 204", async () => {
        const res = await fetch(`${BASE_URL}/api/productos/${productoCreadoId}`, {
            method: "DELETE",
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });

        assert.equal(res.status, 204);

        // Confirmar eliminación
        const getRes = await fetch(`${BASE_URL}/api/productos/${productoCreadoId}`);
        assert.equal(getRes.status, 404);
    });
});
