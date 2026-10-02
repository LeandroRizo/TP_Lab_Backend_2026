import prisma from "../prisma.js";

export const getPabellons = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [pabellons, total] = await Promise.all([
        prisma.pabellon.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.pabellon.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: pabellons,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getPabellonById = async (id) => {
    return await prisma.pabellon.findUnique({ where: { id_pabellon: Number(id) } });
};

export const crearPabellon = async (datos) => {
    return await prisma.pabellon.create({ data: datos });
};

export const actualizarPabellon = async (id, datos) => {
    return await prisma.pabellon.update({ where: { id_pabellon: Number(id) }, data: datos });
};

export const eliminarPabellon = async (id) => {
    return await prisma.pabellon.delete({ where: { id_pabellon: Number(id) } });
};
