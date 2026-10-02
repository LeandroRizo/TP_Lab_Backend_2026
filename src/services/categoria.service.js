import prisma from "../prisma.js";

export const getCategorias = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [categorias, total] = await Promise.all([
        prisma.categoria.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.categoria.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: categorias,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getCategoriaById = async (id) => {
    return await prisma.categoria.findUnique({ where: { id_categoria: Number(id) } });
};

export const crearCategoria = async (datos) => {
    return await prisma.categoria.create({ data: datos });
};

export const actualizarCategoria = async (id, datos) => {
    return await prisma.categoria.update({ where: { id_categoria: Number(id) }, data: datos });
};

export const eliminarCategoria = async (id) => {
    return await prisma.categoria.delete({ where: { id_categoria: Number(id) } });
};
