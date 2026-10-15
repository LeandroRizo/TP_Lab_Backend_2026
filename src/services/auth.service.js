import crypto from "crypto";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import prisma from "../prisma.js";
import config from "../config/env.js";
import { usuarioPublicoDTO } from "../dtos/auth.dto.js";

// Criterio 1.3: Almacenamiento de la contraseña con bcrypt.hash (costo >= 10)
const BCRYPT_SALT_ROUNDS = 10;

export const registrarUsuario = async ({ nombre, email, password }) => {
    // Criterio 1.5: Email repetido -> 409
    const usuarioExistente = await prisma.usuario.findUnique({
        where: { email }
    });

    if (usuarioExistente) {
        const error = new Error("El email ya se encuentra registrado");
        error.statusCode = 409;
        throw error;
    }

    // Hasheo con costo >= 10 (genera hash $2b$...)
    const passwordHash = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);

    // Criterio 1.5: No se permite fijar rol desde el body, se asigna rol predeterminado (2: Artesano/Usuario)
    const nuevoUsuario = await prisma.usuario.create({
        data: {
            nombre,
            email,
            passwordHash,
            id_rol: 2
        },
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            created_at: true,
            updated_at: true
        }
    });

    // Criterio 1.4: Respuestas sin datos sensibles (solo campos públicos)
    return usuarioPublicoDTO(nuevoUsuario);
};

export const autenticarUsuario = async ({ email, password }) => {
    // Buscar usuario por email
    const usuario = await prisma.usuario.findUnique({
        where: { email },
        include: {
            rol: true
        }
    });

    // Criterio 1.6: Email inexistente y contraseña incorrecta devuelven 401 con el MISMO mensaje
    const MENSAJE_ERROR_CREDENCIALES = "Credenciales inválidas";

    if (!usuario) {
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
    // - jwt.sign en un servicio
    // - Algoritmo HS256
    // - sub = id como texto (string)
    // - expiresIn definido
    // - jti único
    // - Payload SIN email, contraseña, hash ni secretos
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

    // Criterio 1.4: Respuesta sin datos sensibles
    return {
        token,
        usuario: usuarioPublicoDTO(usuario)
    };
};

export const obtenerUsuarioPorId = async (id_usuario) => {
    // Criterio 2.5: 401 si la cuenta ya no existe
    const usuario = await prisma.usuario.findUnique({
        where: { id_usuario },
        include: {
            rol: true
        }
    });

    if (!usuario) {
        const error = new Error("La cuenta de usuario no existe o fue eliminada");
        error.statusCode = 401;
        throw error;
    }

    return usuarioPublicoDTO(usuario);
};

// Criterio 2.6: Cierre de sesión y revocación de token por jti
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

// Criterio 2.7: Tarea que borra solo los registros con venceEn <= ahora
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
