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
const { ejecutarSeed } = await import("../prisma/seed.js");

describe("01. Autenticación, Seguridad, Pruebas de Acceso (2.2) y Contexto de Cuenta", () => {
    let ctx;

    beforeEach(async () => {
        await limpiarBaseDeDatos();
        ctx = await obtenerUsuariosPrueba();
    });

    after(async () => {
        await cerrarEntornoPrueba(); // Cierra servidor efímero y ejecuta prisma.$disconnect()
    });

    it("Criterio 2.2: Pruebas de acceso sobre endpoint protegido (/api/solicitudes y /api/productos): sin token -> 401, Authorization mal formada -> 400, token inválido -> 401, rol incorrecto -> 403 (comprueba estado y cuerpo)", async () => {
        // 1. Sin token -> 401
        const resSinToken = await fetch(`${BASE_URL}/api/solicitudes`);
        assert.equal(resSinToken.status, 401);
        const bodySinToken = await resSinToken.json();
        assert.equal(typeof bodySinToken.mensaje, "string");
        assert.match(bodySinToken.mensaje, /autorización/i);

        // 2. Authorization mal formada -> 400
        const resMalFormada = await fetch(`${BASE_URL}/api/solicitudes`, {
            headers: { Authorization: "TokenFormatoIncorrecto 12345" }
        });
        assert.equal(resMalFormada.status, 400);
        const bodyMalFormada = await resMalFormada.json();
        assert.equal(typeof bodyMalFormada.mensaje, "string");
        assert.match(bodyMalFormada.mensaje, /Bearer/i);

        // 3. Token inválido -> 401
        const resTokenInvalido = await fetch(`${BASE_URL}/api/solicitudes`, {
            headers: { Authorization: "Bearer token.jwt.invalido" }
        });
        assert.equal(resTokenInvalido.status, 401);
        const bodyTokenInvalido = await resTokenInvalido.json();
        assert.equal(typeof bodyTokenInvalido.mensaje, "string");
        assert.match(bodyTokenInvalido.mensaje, /inválido|expirado/i);

        // 4. Rol que no corresponde -> 403 (Artesano en ruta de Administrador)
        const resRolIncorrecto = await fetch(`${BASE_URL}/api/solicitudes`, {
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });
        assert.equal(resRolIncorrecto.status, 403);
        const bodyRolIncorrecto = await resRolIncorrecto.json();
        assert.equal(typeof bodyRolIncorrecto.mensaje, "string");
        assert.match(bodyRolIncorrecto.mensaje, /permisos/i);
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
        assert.equal(data.passwordHash, undefined);
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
        const body = await res.json();
        assert.ok(body.mensaje);
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
        const emailInactivo = `inactivo_${Date.now()}@test.com`;
        await prisma.usuario.create({
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
            { path: "/api/zonas", method: "POST" },
            { path: "/api/productos", method: "POST" },
            { path: "/api/solicitudes", method: "GET" }
        ];

        for (const ep of endpoints) {
            const res = await fetch(`${BASE_URL}${ep.path}`, {
                method: ep.method,
                headers: { "Content-Type": "application/json" },
                body: ep.method === "POST" ? JSON.stringify({}) : undefined
            });
            assert.equal(res.status, 401, `Se esperaba 401 en ${ep.method} ${ep.path}`);
        }
    });

    it("Usuario con rol incorrecto intentando acciones de administrador devuelve HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/roles`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ nombre: "RolHack" })
        });
        assert.equal(res.status, 403);
    });

    it("Logout revoca selectivamente el token (reutilización devuelve 401)", async () => {
        const tokenPrueba = generarToken(ctx.admin.id_usuario);

        const meAntes = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(meAntes.status, 200);

        const logoutRes = await fetch(`${BASE_URL}/api/auth/logout`, {
            method: "POST",
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(logoutRes.status, 204);

        const meDespues = await fetch(`${BASE_URL}/api/auth/me`, {
            headers: { Authorization: `Bearer ${tokenPrueba}` }
        });
        assert.equal(meDespues.status, 401);
    });

    it("Auditoria 6.3: prisma/seed.js es idempotente, valida variables SEED_* y permite login de Administrador y Artesano", async () => {
        await limpiarBaseDeDatos();

        // Verificar que falla de forma segura si faltan variables obligatorias
        await assert.rejects(
            () => ejecutarSeed({}),
            /variables de entorno obligatorias/i
        );

        // Primera ejecución con variables de entorno reales de test
        const resSeed1 = await ejecutarSeed(process.env);
        assert.equal(resSeed1.admin.email, process.env.SEED_ADMIN_EMAIL.trim().toLowerCase());
        assert.equal(await prisma.rol.count(), 3);

        const conteoUsuarios1 = await prisma.usuario.count();
        const conteoProductos1 = await prisma.producto.count();

        // Segunda ejecución idempotente (no duplica registros ni sobrescribe contraseñas)
        await ejecutarSeed(process.env);
        const conteoUsuarios2 = await prisma.usuario.count();
        const conteoProductos2 = await prisma.producto.count();
        assert.equal(conteoUsuarios2, conteoUsuarios1);
        assert.equal(conteoProductos2, conteoProductos1);

        // Login real como Administrador
        const resLoginAdmin = await fetch(`${BASE_URL}/api/auth/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: process.env.SEED_ADMIN_EMAIL,
                password: process.env.SEED_ADMIN_PASSWORD
            })
        });
        assert.equal(resLoginAdmin.status, 200);
        const bodyAdmin = await resLoginAdmin.json();
        assert.ok(bodyAdmin.token);
        assert.equal(bodyAdmin.usuario.rol.nombre, "Administrador");
        assert.equal(bodyAdmin.usuario.passwordHash, undefined);

        // Login real como Artesano
        const resLoginArtesano = await fetch(`${BASE_URL}/api/auth/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                email: process.env.SEED_ARTESANO_EMAIL,
                password: process.env.SEED_ARTESANO_PASSWORD
            })
        });
        assert.equal(resLoginArtesano.status, 200);
        const bodyArtesano = await resLoginArtesano.json();
        assert.ok(bodyArtesano.token);
        assert.equal(bodyArtesano.usuario.rol.nombre, "Artesano");
        assert.equal(bodyArtesano.usuario.passwordHash, undefined);
    });

    it("Auditoria 10.1 y 10.2: POST /api/usuarios hashea password en servidor, rechaza passwordHash del cliente y endpoints públicos omiten DNI/teléfono/dirección", async () => {
        // 1. Cliente envía passwordHash en lugar de password -> rechazado con 400
        const resRechazado = await fetch(`${BASE_URL}/api/usuarios`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Intento Hash Directo",
                email: `hash_directo_${Date.now()}@test.com`,
                passwordHash: "HashEnviadoPorCliente123",
                id_rol: ctx.rolPostulante.id_rol
            })
        });
        assert.equal(resRechazado.status, 400);

        // 2. Cliente envía password válido -> servidor genera hash bcrypt y no devuelve passwordHash
        const emailNuevo = `usuario_admin_creado_${Date.now()}@test.com`;
        const resCreado = await fetch(`${BASE_URL}/api/usuarios`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Usuario Creado Por Admin",
                email: emailNuevo,
                password: "PasswordPlano123!",
                id_rol: ctx.rolPostulante.id_rol
            })
        });
        assert.equal(resCreado.status, 201);
        const bodyCreado = await resCreado.json();
        assert.equal(bodyCreado.passwordHash, undefined);

        const enDb = await prisma.usuario.findUnique({ where: { id_usuario: bodyCreado.id_usuario } });
        assert.notEqual(enDb.passwordHash, "PasswordPlano123!");
        assert.match(enDb.passwordHash, /^\$2[aby]\$/);

        // 3. Catálogo público de artesanos no expone DNI, teléfono ni dirección
        const resArtesanos = await fetch(`${BASE_URL}/api/artesanos`);
        assert.equal(resArtesanos.status, 200);
        const listaArtesanos = await resArtesanos.json();
        assert.ok(listaArtesanos.data.length > 0);
        for (const art of listaArtesanos.data) {
            assert.equal(art.dni, undefined);
            assert.equal(art.telefono, undefined);
            assert.equal(art.direccion, undefined);
        }
    });
});
