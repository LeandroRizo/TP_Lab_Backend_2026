import prisma from "../prisma.js";

// Consultas GET públicas (Criterio 4)
export const getProductos = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }
    if (filtros.id_categoria) {
        where.id_categoria = Number(filtros.id_categoria);
    }
    if (filtros.id_artesano) {
        where.id_artesano = Number(filtros.id_artesano);
    }
    if (filtros.precioMin !== undefined || filtros.precioMax !== undefined) {
        where.precio = {};
        if (filtros.precioMin !== undefined) where.precio.gte = Number(filtros.precioMin);
        if (filtros.precioMax !== undefined) where.precio.lte = Number(filtros.precioMax);
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [productos, total] = await Promise.all([
        prisma.producto.findMany({
            where,
            include: {
                artesano: true,
                categoria: true
            },
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
    return await prisma.producto.findUnique({
        where: { id_producto: Number(id) },
        include: {
            artesano: true,
            categoria: true
        }
    });
};

// Criterio 5: Alta con id_artesano proveniente de la cuenta autenticada
export const crearProducto = async (datos) => {
    return await prisma.producto.create({
        data: {
            nombre: datos.nombre,
            descripcion: datos.descripcion,
            precio: datos.precio,
            id_categoria: Number(datos.id_categoria),
            id_artesano: Number(datos.id_artesano)
        },
        include: {
            categoria: true
        }
    });
};

// Criterio 5: Modificar filtra por id y por el propietario en la misma consulta del servicio.
// Producto ajeno o inexistente → 404 con el mismo mensaje.
export const actualizarProductoPropio = async (id, id_artesano, datos) => {
    const dataAActualizar = {};
    if (datos.nombre !== undefined) dataAActualizar.nombre = datos.nombre;
    if (datos.descripcion !== undefined) dataAActualizar.descripcion = datos.descripcion;
    if (datos.precio !== undefined) dataAActualizar.precio = datos.precio;
    if (datos.id_categoria !== undefined) dataAActualizar.id_categoria = Number(datos.id_categoria);

    const resultado = await prisma.producto.updateMany({
        where: {
            id_producto: Number(id),
            id_artesano: Number(id_artesano)
        },
        data: dataAActualizar
    });

    if (resultado.count === 0) {
        const error = new Error("Producto no encontrado");
        error.statusCode = 404;
        throw error;
    }

    return await prisma.producto.findUnique({
        where: { id_producto: Number(id) },
        include: { categoria: true }
    });
};

// Criterio 5: Eliminar filtra por id y por el propietario en la misma consulta del servicio.
// Producto ajeno o inexistente → 404 con el mismo mensaje.
export const eliminarProductoPropio = async (id, id_artesano) => {
    const resultado = await prisma.producto.deleteMany({
        where: {
            id_producto: Number(id),
            id_artesano: Number(id_artesano)
        }
    });

    if (resultado.count === 0) {
        const error = new Error("Producto no encontrado");
        error.statusCode = 404;
        throw error;
    }
};

// Criterio 5: Listado propio sin parámetros del cliente
export const getMisProductos = async (id_artesano) => {
    return await prisma.producto.findMany({
        where: {
            id_artesano: Number(id_artesano)
        },
        include: {
            categoria: true
        }
    });
};
