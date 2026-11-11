import prisma from "../prisma.js";
import { normalizarTexto } from "../utils/normalizarTexto.js";

export const getLocalidads = async (filtros = {}) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: "insensitive" };
    }
    if (filtros.provincia) {
        where.provincia = { contains: filtros.provincia, mode: "insensitive" };
    }
    if (filtros.departamento) {
        where.departamento = { contains: filtros.departamento, mode: "insensitive" };
    }

    const page = filtros.page || 1;
    const limit = filtros.limit || 10;
    const sortBy = filtros.sortBy || "nombre";
    const order = filtros.order || "asc";
    const skip = (page - 1) * limit;

    const [localidads, total] = await Promise.all([
        prisma.localidad.findMany({
            where,
            orderBy: { [sortBy]: order },
            skip,
            take: limit
        }),
        prisma.localidad.count({ where })
    ]);

    const totalPages = Math.ceil(total / limit);
    return {
        data: localidads,
        meta: {
            page,
            limit,
            total,
            totalPages,
            hasNextPage: page < totalPages,
            hasPreviousPage: page > 1
        }
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

/**
 * Resuelve una localidad a partir del nombre de la localidad y de la provincia
 * aplicando normalización insensible a mayúsculas/minúsculas, tildes y espacios.
 *
 * @param {string} nombreLocalidad Nombre de la localidad (ej. "bElEn")
 * @param {string} nombreProvincia Nombre de la provincia (ej. "cAtAmArCa")
 * @returns {Promise<object>} Objeto Localidad encontrado con su id_localidad
 * @throws {Error} Error 400 si no existe o si hay ambigüedad
 */
export const resolverLocalidadPorNombreYProvincia = async (nombreLocalidad, nombreProvincia) => {
    if (!nombreLocalidad || typeof nombreLocalidad !== "string" || !nombreLocalidad.trim()) {
        const error = new Error("El nombre de la localidad es obligatorio");
        error.statusCode = 400;
        throw error;
    }
    if (!nombreProvincia || typeof nombreProvincia !== "string" || !nombreProvincia.trim()) {
        const error = new Error("El nombre de la provincia es obligatorio");
        error.statusCode = 400;
        throw error;
    }

    const normLocalidad = normalizarTexto(nombreLocalidad);
    const normProvincia = normalizarTexto(nombreProvincia);

    // Consultamos las localidades almacenadas en la base de datos
    const localidades = await prisma.localidad.findMany({
        select: {
            id_localidad: true,
            id_georef: true,
            nombre: true,
            departamento: true,
            provincia: true,
            latitud: true,
            longitud: true
        }
    });

    // Comparación exacta normalizada (sin tildes, en minúscula y sin espacios redundantes)
    const coincidencias = localidades.filter((l) => {
        const lNorm = normalizarTexto(l.nombre);
        const pNorm = normalizarTexto(l.provincia);
        return lNorm === normLocalidad && pNorm === normProvincia;
    });

    if (coincidencias.length === 0) {
        const error = new Error(
            `No se encontró ninguna localidad con el nombre '${nombreLocalidad.trim()}' en la provincia '${nombreProvincia.trim()}'. Verifique la ortografía.`
        );
        error.statusCode = 400;
        throw error;
    }

    if (coincidencias.length > 1) {
        const departamentos = coincidencias.map((c) => c.departamento || "Sin departamento").join(", ");
        const error = new Error(
            `Existe ambigüedad para la localidad '${nombreLocalidad.trim()}' en la provincia '${nombreProvincia.trim()}'. Se encontraron ${coincidencias.length} registros en distintos departamentos (${departamentos}).`
        );
        error.statusCode = 400;
        throw error;
    }

    return coincidencias[0];
};
