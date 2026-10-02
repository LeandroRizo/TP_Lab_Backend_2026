import prisma from "../prisma.js";

export const getLocalidads = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [localidads, total] = await Promise.all([
        prisma.localidad.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.localidad.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: localidads,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getLocalidadById = async (id) => {
    return await prisma.localidad.findUnique({ where: { id_localidad: Number(id) } });
};

export const crearLocalidad = async (datos) => {
    return await prisma.localidad.create({ data: datos });
};

export const actualizarLocalidad = async (id, datos) => {
    return await prisma.localidad.update({ where: { id_localidad: Number(id) }, data: datos });
};

export const eliminarLocalidad = async (id) => {
    return await prisma.localidad.delete({ where: { id_localidad: Number(id) } });
};
