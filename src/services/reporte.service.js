import prisma from "../prisma.js";
import { obtenerTendencias } from "./estadisticas.service.js";

// Reporte general consolidado para administradores
export const obtenerReporteGeneral = async () => {
    const [
        totalArtesanos,
        artesanosPorLocalidad,
        artesanosPorRubro,
        totalStands,
        standsOcupados,
        totalProductos,
        productosPorArtesano
    ] = await Promise.all([
        prisma.artesano.count(),
        obtenerArtesanosPorLocalidad(),
        obtenerArtesanosPorRubro(),
        prisma.stand.count(),
        prisma.stand.count({
            where: {
                inscripciones: {
                    some: { estado: "APROBADA" }
                }
            }
        }),
        prisma.producto.count(),
        obtenerProductosPorArtesano()
    ]);

    const standsDisponibles = totalStands - standsOcupados;
    const tendenciasBusqueda = obtenerTendencias();

    return {
        fecha_generacion: new Date(),
        resumen: {
            total_artesanos: totalArtesanos,
            total_productos: totalProductos,
            total_stands: totalStands,
            stands_ocupados: standsOcupados,
            stands_disponibles: standsDisponibles
        },
        artesanos_por_localidad: artesanosPorLocalidad,
        artesanos_por_rubro: artesanosPorRubro,
        stands: {
            total: totalStands,
            ocupados: standsOcupados,
            disponibles: standsDisponibles,
            porcentaje_ocupacion: totalStands > 0 ? Number(((standsOcupados / totalStands) * 100).toFixed(1)) : 0
        },
        productos_por_artesano: productosPorArtesano,
        tendencias_busqueda: tendenciasBusqueda
    };
};

export const obtenerArtesanosPorLocalidad = async () => {
    const localidades = await prisma.localidad.findMany({
        include: {
            _count: {
                select: { artesanos: true }
            }
        },
        orderBy: { nombre: "asc" }
    });

    return localidades.map(loc => ({
        id_localidad: loc.id_localidad,
        localidad: loc.nombre,
        cantidad_artesanos: loc._count.artesanos
    }));
};

export const obtenerArtesanosPorRubro = async () => {
    const rubros = await prisma.rubro.findMany({
        include: {
            _count: {
                select: { artesanos: true }
            }
        },
        orderBy: { nombre: "asc" }
    });

    return rubros.map(rub => ({
        id_rubro: rub.id_rubro,
        rubro: rub.nombre,
        cantidad_artesanos: rub._count.artesanos
    }));
};

export const obtenerStandsOcupacion = async () => {
    const [total, ocupados] = await Promise.all([
        prisma.stand.count(),
        prisma.stand.count({
            where: {
                inscripciones: {
                    some: { estado: "APROBADA" }
                }
            }
        })
    ]);

    const disponibles = total - ocupados;

    return {
        total_stands: total,
        ocupados,
        disponibles,
        porcentaje_ocupacion: total > 0 ? Number(((ocupados / total) * 100).toFixed(1)) : 0
    };
};

export const obtenerProductosPorArtesano = async () => {
    const artesanos = await prisma.artesano.findMany({
        select: {
            id_artesano: true,
            nombre: true,
            apellido: true,
            dni: true,
            _count: {
                select: { productos: true }
            }
        },
        orderBy: { nombre: "asc" }
    });

    return artesanos.map(art => ({
        id_artesano: art.id_artesano,
        artesano: `${art.nombre} ${art.apellido}`.trim(),
        dni: art.dni,
        cantidad_productos: art._count.productos
    }));
};
