import prisma from "../prisma.js";

export const getRols = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [rols, total] = await Promise.all([
        prisma.rol.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.rol.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: rols,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getRolById = async (id) => {
    return await prisma.rol.findUnique({ where: { id_rol: Number(id) } });
};

export const crearRol = async (datos) => {
    return await prisma.rol.create({ data: datos });
};

export const actualizarRol = async (id, datos) => {
    return await prisma.rol.update({ where: { id_rol: Number(id) }, data: datos });
};

export const eliminarRol = async (id) => {
    return await prisma.rol.delete({ where: { id_rol: Number(id) } });
};
