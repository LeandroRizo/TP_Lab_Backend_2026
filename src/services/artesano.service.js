import prisma from "../prisma.js";
import { artesanoPublicoDTO } from "../dtos/artesano.dto.js";
import { invalidarCache } from "../utils/cache.js";

export const getArtesanos = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
    }
    if (filtros.apellido) {
        where.apellido = { contains: filtros.apellido, mode: 'insensitive' };
    }
    if (filtros.dni) {
        where.dni = { contains: filtros.dni, mode: 'insensitive' };
    }
    if (filtros.id_localidad) {
        where.id_localidad = Number(filtros.id_localidad);
    }
    if (filtros.id_rubro) {
        where.id_rubro = Number(filtros.id_rubro);
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [artesanos, total] = await Promise.all([
        prisma.artesano.findMany({
            where,
            include: {
                localidad: true,
                rubro: true
            },
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.artesano.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: artesanos.map(artesanoPublicoDTO),
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getArtesanoById = async (id) => {
    const artesano = await prisma.artesano.findUnique({
        where: { id_artesano: Number(id) },
        include: {
            localidad: true,
            rubro: true,
            productos: true
        }
    });
    return artesanoPublicoDTO(artesano);
};

export const crearArtesano = async (datos) => {
    const creado = await prisma.artesano.create({ data: datos });
    invalidarCache("reportes:general", "reportes:artesanos-localidad", "reportes:artesanos-rubro", "reportes:productos-artesano");
    return creado;
};

export const actualizarArtesano = async (id, datos) => {
    const actualizado = await prisma.artesano.update({ where: { id_artesano: Number(id) }, data: datos });
    invalidarCache("reportes:general", "reportes:artesanos-localidad", "reportes:artesanos-rubro", "reportes:productos-artesano");
    return actualizado;
};

export const eliminarArtesano = async (id) => {
    const eliminado = await prisma.artesano.delete({ where: { id_artesano: Number(id) } });
    invalidarCache("reportes:general", "reportes:artesanos-localidad", "reportes:artesanos-rubro", "reportes:productos-artesano");
    return eliminado;
};
