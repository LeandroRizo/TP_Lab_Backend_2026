import bcrypt from "bcrypt";
import prisma from "../prisma.js";
import { obtenerOCrearRolPostulante, obtenerOCrearRolAdministrador } from "./rol.service.js";

const BCRYPT_SALT_ROUNDS = 10;

const USUARIO_PUBLICO_SELECT = {
    id_usuario: true,
    nombre: true,
    email: true,
    id_rol: true,
    activo: true,
    created_at: true,
    updated_at: true,
    rol: true
};

export const getUsuarios = async (filtros) => {
    const where = {};
    if (filtros.email) {
        where.email = { contains: filtros.email, mode: "insensitive" };
    }
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: "insensitive" };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [usuarios, total] = await Promise.all([
        prisma.usuario.findMany({
            where,
            select: USUARIO_PUBLICO_SELECT,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.usuario.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: usuarios,
        meta: {
            page: filtros.page,
            limit: filtros.limit,
            total,
            totalPages,
            hasNextPage: filtros.page < totalPages,
            hasPreviousPage: filtros.page > 1
        }
    };
};

export const getUsuarioById = async (id) => {
    return await prisma.usuario.findUnique({
        where: { id_usuario: id },
        select: {
            ...USUARIO_PUBLICO_SELECT,
            artesano: true
        }
    });
};

export const crearUsuario = async (datos) => {
    const emailExistente = await prisma.usuario.findUnique({
        where: { email: datos.email }
    });
    if (emailExistente) {
        const error = new Error("El email ya se encuentra registrado");
        error.statusCode = 409;
        throw error;
    }

    const passwordHash = await bcrypt.hash(datos.password, BCRYPT_SALT_ROUNDS);

    let idRol = datos.id_rol;
    if (!idRol) {
        const rolPostulante = await obtenerOCrearRolPostulante(prisma);
        idRol = rolPostulante.id_rol;
    }

    return await prisma.usuario.create({
        data: {
            nombre: datos.nombre,
            email: datos.email,
            passwordHash,
            id_rol: Number(idRol),
            activo: datos.activo !== undefined ? Boolean(datos.activo) : true
        },
        select: USUARIO_PUBLICO_SELECT
    });
};

export const actualizarUsuario = async (id, datos) => {
    const dataAActualizar = {};
    if (datos.nombre !== undefined) dataAActualizar.nombre = datos.nombre;
    if (datos.email !== undefined) dataAActualizar.email = datos.email;
    if (datos.id_rol !== undefined) dataAActualizar.id_rol = Number(datos.id_rol);
    if (datos.activo !== undefined) dataAActualizar.activo = Boolean(datos.activo);
    if (datos.password !== undefined) {
        dataAActualizar.passwordHash = await bcrypt.hash(datos.password, BCRYPT_SALT_ROUNDS);
    }

    return await prisma.usuario.update({
        where: { id_usuario: id },
        data: dataAActualizar,
        select: USUARIO_PUBLICO_SELECT
    });
};

export const eliminarUsuario = async (id) => {
    return await prisma.usuario.delete({
        where: { id_usuario: id },
        select: { id_usuario: true }
    });
};

// Criterio 7: Endpoints solo para admin - Crear administradores
export const crearAdministrador = async ({ nombre, email, password }) => {
    const emailExistente = await prisma.usuario.findUnique({
        where: { email }
    });

    if (emailExistente) {
        const error = new Error("El email ya se encuentra registrado");
        error.statusCode = 409;
        throw error;
    }

    const passwordHash = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);

    return await prisma.$transaction(async (tx) => {
        const rolAdmin = await obtenerOCrearRolAdministrador(tx);

        const nuevoAdmin = await tx.usuario.create({
            data: {
                nombre,
                email,
                passwordHash,
                id_rol: rolAdmin.id_rol,
                activo: true
            },
            select: USUARIO_PUBLICO_SELECT
        });

        return nuevoAdmin;
    });
};

// Criterio 7: Activar o desactivar cuentas (activo booleano validado)
// Desactivar al último administrador activo → 409
export const cambiarEstadoCuenta = async (id_usuario, activo) => {
    return await prisma.$transaction(async (tx) => {
        const usuario = await tx.usuario.findUnique({
            where: { id_usuario },
            include: { rol: true }
        });

        if (!usuario) {
            const error = new Error("Usuario no encontrado");
            error.statusCode = 404;
            throw error;
        }

        // Criterio 7: Desactivar al último administrador activo → 409
        if (activo === false) {
            const esAdmin = usuario.rol && usuario.rol.nombre.toLowerCase() === "administrador";

            if (esAdmin && usuario.activo === true) {
                const adminsActivos = await tx.usuario.count({
                    where: {
                        rol: { nombre: { equals: "Administrador", mode: "insensitive" } },
                        activo: true
                    }
                });

                if (adminsActivos <= 1) {
                    const error = new Error("No se puede desactivar al último administrador activo");
                    error.statusCode = 409;
                    throw error;
                }
            }
        }

        const usuarioActualizado = await tx.usuario.update({
            where: { id_usuario },
            data: { activo },
            select: USUARIO_PUBLICO_SELECT
        });

        return usuarioActualizado;
    });
};
