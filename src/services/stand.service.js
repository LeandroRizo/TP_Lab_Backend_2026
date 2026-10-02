import prisma from "../prisma.js";

export const getStands = async (filtros) => {
    const where = {};
    if (filtros.numero) {
        where.numero = filtros.numero;
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [stands, total] = await Promise.all([
        prisma.stand.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.stand.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: stands,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getStandById = async (id) => {
    return await prisma.stand.findUnique({ where: { id_stand: Number(id) } });
};

export const crearStand = async (datos) => {
    return await prisma.stand.create({ data: datos });
};

export const actualizarStand = async (id, datos) => {
    return await prisma.stand.update({ where: { id_stand: Number(id) }, data: datos });
};

export const eliminarStand = async (id) => {
    return await prisma.stand.delete({ where: { id_stand: Number(id) } });
};
