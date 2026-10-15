import prisma from "../prisma.js";

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
            created_at: true,
            updated_at: true,
            rol: true
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
            created_at: true,
            updated_at: true
        }
    });
};

export const eliminarUsuario = async (id) => {
    return await prisma.usuario.delete({ where: { id_usuario: id } });
};
