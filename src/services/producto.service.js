import prisma from "../prisma.js";

export const getProductos = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [productos, total] = await Promise.all([
        prisma.producto.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.producto.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: productos,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getProductoById = async (id) => {
    return await prisma.producto.findUnique({ where: { id_producto: Number(id) } });
};

export const crearProducto = async (datos) => {
    return await prisma.producto.create({ data: datos });
};

export const actualizarProducto = async (id, datos) => {
    return await prisma.producto.update({ where: { id_producto: Number(id) }, data: datos });
};

export const eliminarProducto = async (id) => {
    return await prisma.producto.delete({ where: { id_producto: Number(id) } });
};
