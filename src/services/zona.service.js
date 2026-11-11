import prisma from "../prisma.js";

export const getZonas = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [zonas, total] = await Promise.all([
        prisma.zona.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.zona.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: zonas,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getZonaById = async (id) => {
    return await prisma.zona.findUnique({ where: { id_zona: Number(id) } });
};

export const crearZona = async (datos) => {
    return await prisma.zona.create({ data: datos });
};

export const actualizarZona = async (id, datos) => {
    return await prisma.zona.update({ where: { id_zona: Number(id) }, data: datos });
};

export const eliminarZona = async (id) => {
    return await prisma.zona.delete({ where: { id_zona: Number(id) } });
};
