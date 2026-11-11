import assert from "node:assert/strict";
import crypto from "node:crypto";
import jwt from "jsonwebtoken";

// Criterio 2.4 (Nivel 2): Aserciones obligatorias de NODE_ENV y base *_test ANTES de importar la app
assert.equal(
    process.env.NODE_ENV,
    "test",
    "SEGURIDAD DE TESTS: NODE_ENV debe ser 'test' antes de importar la aplicación"
);
assert.match(
    process.env.DATABASE_URL || "",
    /_test(\?|$)/i,
    "SEGURIDAD DE TESTS: DATABASE_URL debe apuntar a una base de datos aislada terminada en _test"
);

// Importar aplicación y Prisma recién después de validar el aislamiento del entorno
const { app } = await import("../src/app.js");
const { default: config } = await import("../src/config/env.js");
const { default: prisma } = await import("../src/prisma.js");

// Criterio 2.1 (Nivel 2): Iniciar servidor efímero en memoria para no requerir `npm run dev`
const servidor = await new Promise((resolve) => {
    const srv = app.listen(0, "127.0.0.1", () => resolve(srv));
});
// unref() garantiza que el proceso de Node termine solo al concluir los tests
servidor.unref();

const { port } = servidor.address();
export const BASE_URL = `http://127.0.0.1:${port}`;
export { app, prisma };

export const cerrarEntornoPrueba = async () => {
    await new Promise((resolve) => {
        if (servidor && servidor.listening) {
            servidor.close(() => resolve());
        } else {
            resolve();
        }
    });
    await prisma.$disconnect();
};

// Criterio 2.4 (Nivel 2): Limpieza en orden estricto de dependencias de claves foráneas
export const limpiarBaseDeDatos = async () => {
    await prisma.tokenRevocado.deleteMany();
    await prisma.inscripcion.deleteMany();
    await prisma.solicitud.deleteMany();
    await prisma.producto.deleteMany();
    await prisma.stand.deleteMany();
    await prisma.zona.deleteMany();
    await prisma.pabellon.deleteMany();
    await prisma.categoria.deleteMany();
    await prisma.artesano.deleteMany();
    await prisma.localidad.deleteMany();
    await prisma.rubro.deleteMany();
    await prisma.usuario.deleteMany();
    await prisma.rol.deleteMany();
};

// Generar token JWT firmado válido directamente para tests
export const generarToken = (id_usuario) => {
    return jwt.sign(
        {
            sub: String(id_usuario),
            jti: crypto.randomUUID()
        },
        config.jwtSecret,
        {
            algorithm: "HS256",
            expiresIn: "1h"
        }
    );
};

// Obtener o crear usuarios de prueba con roles correctos
export const obtenerUsuariosPrueba = async () => {
    // 1. Rol Administrador
    let rolAdmin = await prisma.rol.findFirst({
        where: { nombre: { equals: "Administrador", mode: "insensitive" } }
    });
    if (!rolAdmin) {
        rolAdmin = await prisma.rol.create({
            data: { nombre: "Administrador", descripcion: "Rol Administrador" }
        });
    }

    // 2. Rol Artesano
    let rolArtesano = await prisma.rol.findFirst({
        where: { nombre: { equals: "Artesano", mode: "insensitive" } }
    });
    if (!rolArtesano) {
        rolArtesano = await prisma.rol.create({
            data: { nombre: "Artesano", descripcion: "Rol Artesano" }
        });
    }

    // 3. Rol Postulante
    let rolPostulante = await prisma.rol.findFirst({
        where: { nombre: { equals: "Postulante", mode: "insensitive" } }
    });
    if (!rolPostulante) {
        rolPostulante = await prisma.rol.create({
            data: { nombre: "Postulante", descripcion: "Rol Postulante" }
        });
    }

    // Admin de prueba
    let admin = await prisma.usuario.findFirst({
        where: { id_rol: rolAdmin.id_rol, activo: true }
    });
    if (!admin) {
        admin = await prisma.usuario.create({
            data: {
                nombre: "Admin Test",
                email: "admin_test_auto@poncho.test",
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: rolAdmin.id_rol,
                activo: true
            }
        });
    }

    // Artesano de prueba
    let usuarioArtesano = await prisma.usuario.findFirst({
        where: { id_rol: rolArtesano.id_rol, activo: true },
        include: { artesano: true }
    });
    if (!usuarioArtesano || !usuarioArtesano.artesano) {
        let localidad = await prisma.localidad.findFirst();
        if (!localidad) localidad = await prisma.localidad.create({ data: { nombre: "San Fernando del Valle" } });

        let rubro = await prisma.rubro.findFirst();
        if (!rubro) rubro = await prisma.rubro.create({ data: { nombre: "Textil", descripcion: "Tejidos" } });

        usuarioArtesano = await prisma.usuario.create({
            data: {
                nombre: "Artesano Test 1",
                email: `artesano_${Date.now()}_${Math.floor(Math.random() * 1000)}@poncho.test`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: rolArtesano.id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Artesano",
                        apellido: "Test Uno",
                        dni: `DNI_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
                        id_localidad: localidad.id_localidad,
                        id_rubro: rubro.id_rubro
                    }
                }
            },
            include: { artesano: true }
        });
    }

    return {
        admin,
        usuarioArtesano,
        rolAdmin,
        rolArtesano,
        rolPostulante,
        adminToken: generarToken(admin.id_usuario),
        artesanoToken: generarToken(usuarioArtesano.id_usuario)
    };
};
