import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import prisma from "../src/prisma.js";
import { BASE_URL, generarToken, obtenerUsuariosPrueba } from "./testHelper.js";

describe("01. Autenticación, Seguridad y Contexto de Cuenta", () => {
    let ctx;

    before(async () => {
        ctx = await obtenerUsuariosPrueba();
    });

    it("Registro público exitoso con HTTP 201", async () => {
        const email = `registro_${Date.now()}@test.com`;
        const res = await fetch(`${BASE_URL}/api/auth/register`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Usuario Registro Test",
                email,
                password: "ClaveSegura123!"
            })
        });

        assert.equal(res.status, 201);
        const data = await res.json();
        assert.ok(data.id_usuario);
        assert.equal(data.email, email);
        assert.equal(data.passwordHash, undefined); // No debe exponer contraseña

        // Limpieza aislada
        await prisma.usuario.delete({ where: { id_usuario: data.id_usuario } });
    });

    it("Registro con email repetido devuelve HTTP 409", async () => {
        const res = await fetch(`${BASE_URL}/api/auth/register`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Admin Duplicate",
                email: ctx.admin.email,
                password: "ClaveSegura123!"
            })
        });

        assert.equal(res.status, 409);
    });

    it("Login con credenciales incorrectas devuelve HTTP 401 con mensaje genérico", async () => {
        const res = await fetch(`${BASE_URL}/api/auth/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: ctx.admin.email,
                password: "PasswordCompletamenteIncorrecto"
            })
        });

        assert.equal(res.status, 401);
        const data = await res.json();
        assert.equal(data.mensaje, "Credenciales inválidas");
    });

    it("Login de cuenta desactivada devuelve HTTP 401 con mensaje genérico", async () => {
        // Crear cuenta inactiva
        const emailInactivo = `inactivo_${Date.now()}@test.com`;
        const usuarioInactivo = await prisma.usuario.create({
            data: {
                nombre: "Inactivo User",
                email: emailInactivo,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolPostulante.id_rol,
                activo: false
            }
        });

        const res = await fetch(`${BASE_URL}/api/auth/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: emailInactivo,
                password: "CualquierPassword123"
            })
        });

        assert.equal(res.status, 401);
        const data = await res.json();
        assert.equal(data.mensaje, "Credenciales inválidas");

        // Limpiar
        await prisma.usuario.delete({ where: { id_usuario: usuarioInactivo.id_usuario } });
    });

    it("GET /me con cuenta desactivada y token previo devuelve HTTP 403 'Cuenta desactivada'", async () => {
        const usuarioTemp = await prisma.usuario.create({
            data: {
                nombre: "Temp Inactivo",
                email: `temp_inactivo_${Date.now()}@test.com`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: ctx.rolPostulante.id_rol,
                activo: false
            }
        });

        const token = generarToken(usuarioTemp.id_usuario);
        const res = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${token}` }
        });

        assert.equal(res.status, 403);
        const data = await res.json();
        assert.equal(data.mensaje, "Cuenta desactivada");

        await prisma.usuario.delete({ where: { id_usuario: usuarioTemp.id_usuario } });
    });

    it("Acceso anónimo a rutas de escritura protegidas devuelve HTTP 401", async () => {
        const endpoints = [
            { path: "/api/roles", method: "POST" },
            { path: "/api/artesanos", method: "POST" },
            { path: "/api/stands", method: "POST" },
            { path: "/api/categorias", method: "POST" },
            { path: "/api/localidades", method: "POST" },
            { path: "/api/rubros", method: "POST" },
            { path: "/api/pabellones", method: "POST" },
            { path: "/api/zonas", method: "POST" }
        ];

        for (const ep of endpoints) {
            const res = await fetch(`${BASE_URL}${ep.path}`, {
                method: ep.method,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ test: "data" })
            });
            assert.equal(res.status, 401, `Falló endpoint anónimo ${ep.method} ${ep.path}`);
        }
    });

    it("Usuario con rol incorrecto intentando acciones de administrador devuelve HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/roles`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ nombre: "Rol Hack" })
        });

        assert.equal(res.status, 403);
    });

    it("Logout revoca selectivamente el token (reutilización devuelve 401)", async () => {
        const tokenPrueba = generarToken(ctx.admin.id_usuario);

        // 1. Funciona antes del logout
        const meAntes = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(meAntes.status, 200);

        // 2. Hacer logout
        const logoutRes = await fetch(`${BASE_URL}/api/auth/logout`, {
            method: "POST",
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(logoutRes.status, 204);

        // 3. Reutilizar el mismo token debe ser rechazado
        const meDespues = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(meDespues.status, 401);
    });
});
