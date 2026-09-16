import prisma from "../prisma.js";

export const getArtesanos = async () => {
    return await prisma.artesano.findMany();
};

export const getArtesanoById = async (id) => {
    return await prisma.artesano.findUnique({
        where: { id: Number(id) }
    });
};

export const crearArtesano = async (datos) => {
    return await prisma.artesano.create({
        data: datos
    });
};

export const actualizarArtesano = async (id, datos) => {
    return await prisma.artesano.update({
        where: { id: Number(id) },
        data: datos
    });
};

export const eliminarArtesano = async (id) => {
    return await prisma.artesano.delete({
        where: { id: Number(id) }
    });
};