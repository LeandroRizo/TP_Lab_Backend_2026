import bcrypt from "bcrypt";
import prisma from "../prisma.js";

const BCRYPT_SALT_ROUNDS = 10;

export const getUsuarios = async (filtros) => {
    const where = {};
    if (filtros.email) {
        where.email = { contains: filtros.email, mode: 'insensitive' };
    }
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [usuarios, total] = await Promise.all([
        prisma.usuario.findMany({
            where,
            select: {
                id_usuario: true,
                nombre: true,
                email: true,
                id_rol: true,
                activo: true,
                created_at: true,
                updated_at: true,
                rol: true
            },
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.usuario.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: usuarios,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getUsuarioById = async (id) => {
    return await prisma.usuario.findUnique({
        where: { id_usuario: id },
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            activo: true,
            created_at: true,
            updated_at: true,
            rol: true,
            artesano: true
        }
    });
};

export const crearUsuario = async (datos) => {
    return await prisma.usuario.create({
        data: datos,
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            activo: true,
            created_at: true,
            updated_at: true
        }
    });
};

export const actualizarUsuario = async (id, datos) => {
    return await prisma.usuario.update({
        where: { id_usuario: id },
        data: datos,
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            activo: true,
            created_at: true,
            updated_at: true
        }
    });
};

export const eliminarUsuario = async (id) => {
    return await prisma.usuario.delete({ where: { id_usuario: id } });
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
        let rolAdmin = await tx.rol.findFirst({
        where: { nombre: { equals: "Administrador", mode: "insensitive" } }
    });
    if (!rolAdmin) {
        rolAdmin = await tx.rol.create({
            data: { nombre: "Administrador", descripcion: "Rol de Administrador del sistema" }
        });
    }

    const nuevoAdmin = await tx.usuario.create({
        data: {
            nombre,
            email,
            passwordHash,
            id_rol: rolAdmin.id_rol,
            activo: true
        },
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            activo: true,
            created_at: true,
            updated_at: true,
            rol: true
        }
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
        const esAdmin = usuario.rol?.nombre?.toLowerCase() === "administrador";

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
        select: {
            id_usuario: true,
            nombre: true,
            email: true,
            id_rol: true,
            activo: true,
            created_at: true,
            updated_at: true,
            rol: true
        }
    });

        return usuarioActualizado;
    });
};
