import { describe, it, before, after } from "node:test";
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

describe("04. Gestión de Cuentas y Protección de Administradores", () => {
    let ctx;
    let cuentaPrueba;

    before(async () => {
        await limpiarBaseDeDatos();
        ctx = await obtenerUsuariosPrueba();

        cuentaPrueba = await prisma.usuario.create({
            data: {
                nombre: "Cuenta Prueba Gestion",
                email: `gestion_${Date.now()}@test.com`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolPostulante.id_rol,
                activo: true
            }
        });
    });

    after(async () => {
        await cerrarEntornoPrueba(); // Cierra servidor efímero y ejecuta prisma.$disconnect()
    });

    it("Solo ADMINISTRADOR puede crear administradores (HTTP 201)", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/usuarios/administrador`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Nuevo Admin Test",
                email: `nuevo_admin_${timestamp}@poncho.test`,
                password: "ClaveSeguraAdmin2026!"
            })
        });

        assert.equal(res.status, 201);
        const data = await res.json();
        assert.ok(data.id_usuario);
        assert.equal(data.rol.nombre.toLowerCase(), "administrador");

        await prisma.usuario.delete({ where: { id_usuario: data.id_usuario } });
    });

    it("No-administrador intentando crear administrador devuelve HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/usuarios/administrador`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Admin Hack",
                email: "hack@admin.com",
                password: "ClaveSegura123!"
            })
        });

        assert.equal(res.status, 403);
    });

    it("Desactivar cuenta cambia activo a false", async () => {
        const res = await fetch(`${BASE_URL}/api/usuarios/${cuentaPrueba.id_usuario}/estado`, {
            method: "PATCH",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ activo: false })
        });

        assert.equal(res.status, 200);
        const u = await res.json();
        assert.equal(u.activo, false);
    });

    it("Cuenta desactivada es rechazada con HTTP 403 en /me con token previo", async () => {
        const tokenInactivo = generarToken(cuentaPrueba.id_usuario);
        const res = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenInactivo}` }
        });

        assert.equal(res.status, 403);
        const err = await res.json();
        assert.equal(err.mensaje, "Cuenta desactivada");
    });

    it("Validación: intentar cambiar estado con valor no booleano devuelve HTTP 400", async () => {
        const res = await fetch(`${BASE_URL}/api/usuarios/${cuentaPrueba.id_usuario}/estado`, {
            method: "PATCH",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ activo: "falso_texto" })
        });

        assert.equal(res.status, 400);
    });

    it("Reactivar cuenta devuelve activo a true y vuelve a operar", async () => {
        const res = await fetch(`${BASE_URL}/api/usuarios/${cuentaPrueba.id_usuario}/estado`, {
            method: "PATCH",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ activo: true })
        });

        assert.equal(res.status, 200);
        const u = await res.json();
        assert.equal(u.activo, true);

        const tokenReactivado = generarToken(cuentaPrueba.id_usuario);
        const resMe = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenReactivado}` }
        });
        assert.equal(resMe.status, 200);
    });

    it("Impedir desactivar al último administrador activo devuelve HTTP 409", async () => {
        const adminsActivos = await prisma.usuario.findMany({
            where: {
                rol: { nombre: { equals: "Administrador", mode: "insensitive" } },
                activo: true
            }
        });

        const unicoAdmin = adminsActivos[0];
        const res = await fetch(`${BASE_URL}/api/usuarios/${unicoAdmin.id_usuario}/estado`, {
            method: "PATCH",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ activo: false })
        });

        assert.equal(res.status, 409);
        const json = await res.json();
        assert.equal(json.mensaje, "No se puede desactivar al último administrador activo");
    });
});
