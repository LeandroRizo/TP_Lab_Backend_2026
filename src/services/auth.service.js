import crypto from "crypto";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import prisma from "../prisma.js";
import config from "../config/env.js";
import { usuarioPublicoDTO } from "../dtos/auth.dto.js";
import { obtenerOCrearRolPostulante } from "./rol.service.js";
import { resolverLocalidadPorNombreYProvincia } from "./localidad.service.js";
import { resolverRubroPorNombre } from "./rubro.service.js";

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
    const rolPostulante = await obtenerOCrearRolPostulante(prisma);

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
// Admite indicar localidad y provincia por nombre normalizado o por id_localidad numérico
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
        localidad,
        provincia,
        id_rubro,
        rubro,
        observaciones
    } = datos;

    // 1. Resolver localidad (por nombre + provincia, o validar id_localidad)
    let idLocalidadResuelto = id_localidad ? Number(id_localidad) : null;

    if (localidad && provincia) {
        const locEncontrada = await resolverLocalidadPorNombreYProvincia(localidad, provincia);
        idLocalidadResuelto = locEncontrada.id_localidad;
    } else if (idLocalidadResuelto) {
        const existeLoc = await prisma.localidad.findUnique({
            where: { id_localidad: idLocalidadResuelto }
        });
        if (!existeLoc) {
            const error = new Error(`La localidad con ID ${idLocalidadResuelto} no existe`);
            error.statusCode = 400;
            throw error;
        }
    } else {
        const error = new Error("Debe indicar la localidad (por nombre y provincia o id_localidad)");
        error.statusCode = 400;
        throw error;
    }

    // 2. Resolver rubro (por nombre normalizado o validar id_rubro numérico)
    let idRubroResuelto = id_rubro ? Number(id_rubro) : null;

    if (rubro) {
        const rubroEncontrado = await resolverRubroPorNombre(rubro);
        idRubroResuelto = rubroEncontrado.id_rubro;
    } else if (idRubroResuelto) {
        const existeRub = await prisma.rubro.findUnique({
            where: { id_rubro: idRubroResuelto }
        });
        if (!existeRub) {
            const error = new Error(`El rubro con ID ${idRubroResuelto} no existe`);
            error.statusCode = 400;
            throw error;
        }
    } else {
        const error = new Error("Debe indicar el rubro (por nombre o id_rubro)");
        error.statusCode = 400;
        throw error;
    }

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
    const rolPostulante = await obtenerOCrearRolPostulante(prisma);

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
                id_localidad: idLocalidadResuelto,
                id_rubro: idRubroResuelto
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

    if (!usuario.activo) {
        const error = new Error("Cuenta desactivada");
        error.statusCode = 403;
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
