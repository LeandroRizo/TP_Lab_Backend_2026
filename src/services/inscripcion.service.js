import prisma from "../prisma.js";

export const getInscripcions = async (filtros) => {
    const where = {};
    if (filtros.estado) {
        where.estado = { contains: filtros.estado, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [inscripcions, total] = await Promise.all([
        prisma.inscripcion.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.inscripcion.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: inscripcions,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getInscripcionById = async (id) => {
    return await prisma.inscripcion.findUnique({ where: { id_inscripcion: Number(id) } });
};

export const crearInscripcion = async (datos) => {
    return await prisma.inscripcion.create({ data: datos });
};

export const actualizarInscripcion = async (id, datos) => {
    return await prisma.inscripcion.update({ where: { id_inscripcion: Number(id) }, data: datos });
};

export const eliminarInscripcion = async (id) => {
    return await prisma.inscripcion.delete({ where: { id_inscripcion: Number(id) } });
};
