import jwt from "jsonwebtoken";
import config from "../src/config/env.js";
import prisma from "../src/prisma.js";

export const BASE_URL = process.env.TEST_BASE_URL || "http://localhost:3000";

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
                email: `artesano_${Date.now()}@poncho.test`,
                passwordHash: "$2b$10$abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ012",
                id_rol: rolArtesano.id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Artesano",
                        apellido: "Test Uno",
                        dni: `DNI_${Date.now()}`,
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
