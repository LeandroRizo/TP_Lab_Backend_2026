import prisma from "../prisma.js";
import { artesanoPublicoDTO } from "../dtos/artesano.dto.js";
import { resolverLocalidadPorNombreYProvincia } from "./localidad.service.js";
import { resolverRubroPorNombre } from "./rubro.service.js";

export const getArtesanos = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: "insensitive" };
    }
    if (filtros.apellido) {
        where.apellido = { contains: filtros.apellido, mode: "insensitive" };
    }
    if (filtros.dni) {
        where.dni = { contains: filtros.dni, mode: "insensitive" };
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
        meta: {
            page: filtros.page,
            limit: filtros.limit,
            total,
            totalPages,
            hasNextPage: filtros.page < totalPages,
            hasPreviousPage: filtros.page > 1
        }
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
    let id_localidad = datos.id_localidad ? Number(datos.id_localidad) : null;
    if (datos.localidad && datos.provincia) {
        const loc = await resolverLocalidadPorNombreYProvincia(datos.localidad, datos.provincia);
        id_localidad = loc.id_localidad;
    } else if (id_localidad) {
        const existeLoc = await prisma.localidad.findUnique({ where: { id_localidad } });
        if (!existeLoc) {
            const error = new Error(`La localidad con ID ${id_localidad} no existe`);
            error.statusCode = 400;
            throw error;
        }
    }

    let id_rubro = datos.id_rubro ? Number(datos.id_rubro) : null;
    if (datos.rubro) {
        const rub = await resolverRubroPorNombre(datos.rubro);
        id_rubro = rub.id_rubro;
    } else if (id_rubro) {
        const existeRub = await prisma.rubro.findUnique({ where: { id_rubro } });
        if (!existeRub) {
            const error = new Error(`El rubro con ID ${id_rubro} no existe`);
            error.statusCode = 400;
            throw error;
        }
    }

    const { localidad, provincia, rubro, ...resto } = datos;
    return await prisma.artesano.create({
        data: {
            ...resto,
            id_localidad,
            id_rubro
        }
    });
};

export const actualizarArtesano = async (id, datos) => {
    let id_localidad = datos.id_localidad !== undefined ? Number(datos.id_localidad) : undefined;
    if (datos.localidad && datos.provincia) {
        const loc = await resolverLocalidadPorNombreYProvincia(datos.localidad, datos.provincia);
        id_localidad = loc.id_localidad;
    } else if (id_localidad !== undefined) {
        const existeLoc = await prisma.localidad.findUnique({ where: { id_localidad } });
        if (!existeLoc) {
            const error = new Error(`La localidad con ID ${id_localidad} no existe`);
            error.statusCode = 400;
            throw error;
        }
    }

    let id_rubro = datos.id_rubro !== undefined ? Number(datos.id_rubro) : undefined;
    if (datos.rubro) {
        const rub = await resolverRubroPorNombre(datos.rubro);
        id_rubro = rub.id_rubro;
    } else if (id_rubro !== undefined) {
        const existeRub = await prisma.rubro.findUnique({ where: { id_rubro } });
        if (!existeRub) {
            const error = new Error(`El rubro con ID ${id_rubro} no existe`);
            error.statusCode = 400;
            throw error;
        }
    }

    const { localidad, provincia, rubro, ...resto } = datos;
    const datosUpdate = { ...resto };
    if (id_localidad !== undefined) datosUpdate.id_localidad = id_localidad;
    if (id_rubro !== undefined) datosUpdate.id_rubro = id_rubro;

    return await prisma.artesano.update({
        where: { id_artesano: Number(id) },
        data: datosUpdate
    });
};

export const eliminarArtesano = async (id) => {
    return await prisma.artesano.delete({ where: { id_artesano: Number(id) } });
};
