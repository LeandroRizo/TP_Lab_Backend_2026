import crypto from "crypto";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import prisma from "../prisma.js";
import config from "../config/env.js";
import { usuarioPublicoDTO } from "../dtos/auth.dto.js";

const BCRYPT_SALT_ROUNDS = 10;

// Criterio 1.5: Registro simple
export const registrarUsuario = async ({ nombre, email, password }) => {
    const usuarioExistente = await prisma.usuario.findUnique({
        where: { email }
    });

    if (usuarioExistente) {
        const error = new Error("El email ya se encuentra registrado");
        error.statusCode = 409;
        throw error;
    }

    const passwordHash = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);

    // Rol no-artesano por defecto para registros públicos normales
    let rolPostulante = await prisma.rol.findFirst({
        where: { nombre: { in: ["Postulante", "Usuario"], mode: "insensitive" } }
    });
    if (!rolPostulante) {
        rolPostulante = await prisma.rol.create({
            data: { nombre: "Postulante", descripcion: "Usuario registrado o postulante pendiente de aprobacion" }
        });
    }

    const nuevoUsuario = await prisma.usuario.create({
        data: {
            nombre,
            email,
            passwordHash,
            id_rol: rolPostulante.id_rol,
            activo: true
        },
        include: { rol: true }
    });

    return usuarioPublicoDTO(nuevoUsuario);
};

// Criterio 6: Postulación pública - crea cuenta, Artesano y solicitud PENDIENTE en una sola transacción
export const postularArtesano = async (datos) => {
    const {
        nombre,
        apellido,
        email,
        password,
        dni,
        telefono,
        direccion,
        descripcion,
        instagram,
        id_localidad,
        id_rubro,
        observaciones
    } = datos;

    // Verificar email repetido -> 409
    const emailExistente = await prisma.usuario.findUnique({
        where: { email }
    });
    if (emailExistente) {
        const error = new Error("El email ya se encuentra registrado");
        error.statusCode = 409;
        throw error;
    }

    // Verificar DNI repetido -> 409
    const dniExistente = await prisma.artesano.findUnique({
        where: { dni }
    });
    if (dniExistente) {
        const error = new Error("El DNI ya se encuentra registrado para otro artesano");
        error.statusCode = 409;
        throw error;
    }

    const passwordHash = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);

    let rolPostulante = await prisma.rol.findFirst({
        where: { nombre: { in: ["Postulante", "Usuario"], mode: "insensitive" } }
    });
    if (!rolPostulante) {
        rolPostulante = await prisma.rol.create({
            data: { nombre: "Postulante", descripcion: "Usuario registrado o postulante pendiente de aprobacion" }
        });
    }

    // Una sola operación transaccional
    const resultado = await prisma.$transaction(async (tx) => {
        const usuario = await tx.usuario.create({
            data: {
                nombre,
                email,
                passwordHash,
                id_rol: rolPostulante.id_rol,
                activo: true
            },
            include: { rol: true }
        });

        const artesano = await tx.artesano.create({
            data: {
                id_usuario: usuario.id_usuario,
                nombre,
                apellido,
                dni,
                telefono,
                direccion,
                descripcion,
                instagram,
                id_localidad: Number(id_localidad),
                id_rubro: Number(id_rubro)
            }
        });

        const solicitud = await tx.solicitud.create({
            data: {
                id_artesano: artesano.id_artesano,
                estado: "PENDIENTE",
                observaciones
            }
        });

        return { usuario, artesano, solicitud };
    });

    return {
        usuario: usuarioPublicoDTO(resultado.usuario),
        artesano: resultado.artesano,
        solicitud: resultado.solicitud
    };
};

// Criterio 2: Login - cuenta inactiva → 401 con mensaje genérico ("Credenciales inválidas")
export const autenticarUsuario = async ({ email, password }) => {
    const usuario = await prisma.usuario.findUnique({
        where: { email },
        include: { rol: true, artesano: true }
    });

    const MENSAJE_ERROR_CREDENCIALES = "Credenciales inválidas";

    if (!usuario) {
        const error = new Error(MENSAJE_ERROR_CREDENCIALES);
        error.statusCode = 401;
        throw error;
    }

    // Criterio 2: El login de una cuenta inactiva → 401 con el mensaje genérico
    if (!usuario.activo) {
        const error = new Error(MENSAJE_ERROR_CREDENCIALES);
        error.statusCode = 401;
        throw error;
    }

    const contraseniaValida = await bcrypt.compare(password, usuario.passwordHash);

    if (!contraseniaValida) {
        const error = new Error(MENSAJE_ERROR_CREDENCIALES);
        error.statusCode = 401;
        throw error;
    }

    // Criterio 2.2: Emisión del token
    const jti = crypto.randomUUID();
    const token = jwt.sign(
        {
            sub: String(usuario.id_usuario),
            jti
        },
        config.jwtSecret,
        {
            algorithm: "HS256",
            expiresIn: "24h"
        }
    );

    return {
        token,
        usuario: usuarioPublicoDTO(usuario)
    };
};

export const obtenerUsuarioPorId = async (id_usuario) => {
    const usuario = await prisma.usuario.findUnique({
        where: { id_usuario },
        include: { rol: true, artesano: true }
    });

    if (!usuario) {
        const error = new Error("La cuenta de usuario no existe o fue eliminada");
        error.statusCode = 401;
        throw error;
    }

    return usuarioPublicoDTO(usuario);
};

export const revocarToken = async (jti, exp) => {
    const venceEn = exp ? new Date(exp * 1000) : new Date(Date.now() + 24 * 60 * 60 * 1000);

    return await prisma.tokenRevocado.create({
        data: {
            jti,
            venceEn
        }
    });
};

export const esTokenRevocado = async (jti) => {
    if (!jti) return true;
    const revocado = await prisma.tokenRevocado.findUnique({
        where: { jti }
    });
    return Boolean(revocado);
};

export const limpiarTokensRevocados = async () => {
    const ahora = new Date();
    return await prisma.tokenRevocado.deleteMany({
        where: {
            venceEn: {
                lte: ahora
            }
        }
    });
};
