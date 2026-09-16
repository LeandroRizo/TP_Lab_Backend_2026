import prisma from "../prisma.js";

export const getProductos = async () => {
    return await prisma.producto.findMany();
};

export const getProductoById = async (id) => {
    return await prisma.producto.findUnique({
        where: { id: Number(id) }
    });
};

export const crearProducto = async (datos) => {
    return await prisma.producto.create({
        data: datos
    });
};

export const actualizarProducto = async (id, datos) => {
    return await prisma.producto.update({
        where: { id: Number(id) },
        data: datos
    });
};

export const eliminarProducto = async (id) => {
    return await prisma.producto.delete({
        where: { id: Number(id) }
    });
};