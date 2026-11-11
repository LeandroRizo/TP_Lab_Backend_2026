import prisma from "../prisma.js";
import { normalizarTexto } from "../utils/normalizarTexto.js";

export const getRubros = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: "insensitive" };
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [rubros, total] = await Promise.all([
        prisma.rubro.findMany({
            where,
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.rubro.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: rubros,
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

export const getRubroById = async (id) => {
    return await prisma.rubro.findUnique({ where: { id_rubro: Number(id) } });
};

export const crearRubro = async (datos) => {
    return await prisma.rubro.create({ data: datos });
};

export const actualizarRubro = async (id, datos) => {
    return await prisma.rubro.update({ where: { id_rubro: Number(id) }, data: datos });
};

export const eliminarRubro = async (id) => {
    return await prisma.rubro.delete({ where: { id_rubro: Number(id) } });
};

/**
 * Resuelve un rubro a partir de su nombre aplicando normalización insensible
 * a mayúsculas/minúsculas, tildes y espacios.
 *
 * @param {string} nombreRubro Nombre del rubro (ej. "Textil", "TEXTIL", " Téxtil ", "Cerámica", "Orfebrería", "Cuero")
 * @returns {Promise<object>} Objeto Rubro encontrado con su id_rubro
 * @throws {Error} Error 400 si no existe
 */
export const resolverRubroPorNombre = async (nombreRubro) => {
    if (!nombreRubro || typeof nombreRubro !== "string" || !nombreRubro.trim()) {
        const error = new Error("El nombre del rubro es obligatorio");
        error.statusCode = 400;
        throw error;
    }

    const normRubro = normalizarTexto(nombreRubro);

    // Consultamos los rubros almacenados en la base de datos
    const rubros = await prisma.rubro.findMany();

    // 1. Coincidencia exacta tras normalización
    let coincidencia = rubros.find((r) => normalizarTexto(r.nombre) === normRubro);

    // 2. Coincidencia por componentes/términos principales (ej: "Orfebrería" -> "Orfebrería y Platería", "Cuero" -> "Cuero y Talabartería", "Cestería" -> "Cestería y Fibra Vegetal")
    if (!coincidencia) {
        coincidencia = rubros.find((r) => {
            const partes = r.nombre
                .split(/\s+y\s+|\/|\s*,\s*/)
                .map((p) => normalizarTexto(p));
            return partes.includes(normRubro);
        });
    }

    if (!coincidencia) {
        const nombresDisponibles = rubros.map((r) => r.nombre).join(", ");
        const error = new Error(
            `No se encontró el rubro '${nombreRubro.trim()}'. Rubros válidos disponibles: ${nombresDisponibles}`
        );
        error.statusCode = 400;
        throw error;
    }

    return coincidencia;
};
