import prisma from "../prisma.js";

export const getArtesanos = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }
    if (filtros.apellido) {
        where.apellido = { contains: filtros.apellido, mode: 'insensitive' };
    }
    if (filtros.dni) {
        where.dni = { contains: filtros.dni, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [artesanos, total] = await Promise.all([
        prisma.artesano.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.artesano.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: artesanos,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getArtesanoById = async (id) => {
    return await prisma.artesano.findUnique({ where: { id_artesano: Number(id) } });
};

export const crearArtesano = async (datos) => {
    return await prisma.artesano.create({ data: datos });
};

export const actualizarArtesano = async (id, datos) => {
    return await prisma.artesano.update({ where: { id_artesano: Number(id) }, data: datos });
};

export const eliminarArtesano = async (id) => {
    return await prisma.artesano.delete({ where: { id_artesano: Number(id) } });
};
