import prisma from "../prisma.js";
import { invalidarCache } from "../utils/cache.js";

export const getRubros = async (filtros) => {
    const where = {};
    if (filtros.nombre) {
        where.nombre = { contains: filtros.nombre, mode: 'insensitive' };
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
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getRubroById = async (id) => {
    return await prisma.rubro.findUnique({ where: { id_rubro: Number(id) } });
};

export const crearRubro = async (datos) => {
    const creado = await prisma.rubro.create({ data: datos });
    invalidarCache("reportes:general", "reportes:artesanos-rubro");
    return creado;
};

export const actualizarRubro = async (id, datos) => {
    const actualizado = await prisma.rubro.update({ where: { id_rubro: Number(id) }, data: datos });
    invalidarCache("reportes:general", "reportes:artesanos-rubro");
    return actualizado;
};

export const eliminarRubro = async (id) => {
    const eliminado = await prisma.rubro.delete({ where: { id_rubro: Number(id) } });
    invalidarCache("reportes:general", "reportes:artesanos-rubro");
    return eliminado;
};
