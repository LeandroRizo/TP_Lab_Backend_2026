import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import prisma from "../src/prisma.js";
import { BASE_URL, generarToken, obtenerUsuariosPrueba } from "./testHelper.js";

describe("04. Gestión de Cuentas y Protección de Administradores", () => {
    let ctx;
    let cuentaPrueba;

    before(async () => {
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

        // Limpiar admin creado
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

    it("Reactivar cuenta devuelve activo a true", async () => {
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

        // Limpieza
        await prisma.usuario.delete({ where: { id_usuario: cuentaPrueba.id_usuario } });
    });

    it("Impedir desactivar al último administrador activo devuelve HTTP 409", async () => {
        // Asegurar que solo haya 1 admin activo
        const adminsActivos = await prisma.usuario.findMany({
            where: {
                rol: { nombre: { equals: "Administrador", mode: "insensitive" } },
                activo: true
            }
        });

        // Desactivar temporalmente los demás administradores si hubiera más de 1
        const adminsSecundarios = adminsActivos.slice(1);
        for (const a of adminsSecundarios) {
            await prisma.usuario.update({
                where: { id_usuario: a.id_usuario },
                data: { activo: false }
            });
        }

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

        // Restaurar estado de los administradores secundarios
        for (const a of adminsSecundarios) {
            await prisma.usuario.update({
                where: { id_usuario: a.id_usuario },
                data: { activo: true }
            });
        }
    });
});
