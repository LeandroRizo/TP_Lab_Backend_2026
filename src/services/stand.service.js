import prisma from "../prisma.js";

export const getStands = async (filtros) => {
    const where = {};
    if (filtros.numero) {
        where.numero = filtros.numero;
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [stands, total] = await Promise.all([
        prisma.stand.findMany({
            where,
            include: {
                zona: true,
                inscripciones: {
                    include: { artesano: true }
                }
            },
            orderBy: { [filtros.sortBy]: filtros.order },
            skip,
            take: filtros.limit
        }),
        prisma.stand.count({ where })
    ]);

    const totalPages = Math.ceil(total / filtros.limit);
    return {
        data: stands,
        meta: { page: filtros.page, limit: filtros.limit, total, totalPages, hasNextPage: filtros.page < totalPages, hasPreviousPage: filtros.page > 1 }
    };
};

export const getStandById = async (id) => {
    return await prisma.stand.findUnique({
        where: { id_stand: Number(id) },
        include: {
            zona: true,
            inscripciones: {
                include: { artesano: true }
            }
        }
    });
};

export const crearStand = async (datos) => {
    return await prisma.stand.create({ data: datos });
};

export const actualizarStand = async (id, datos) => {
    return await prisma.stand.update({ where: { id_stand: Number(id) }, data: datos });
};

export const eliminarStand = async (id) => {
    return await prisma.stand.delete({ where: { id_stand: Number(id) } });
};

// Criterio 4: Asignación artesano–stand (Solo ADMIN)
export const asignarArtesanoAStand = async (id_stand, id_artesano) => {
    const stand = await prisma.stand.findUnique({ where: { id_stand: Number(id_stand) } });
    if (!stand) {
        const error = new Error("Stand no encontrado");
        error.statusCode = 404;
        throw error;
    }

    const artesano = await prisma.artesano.findUnique({ where: { id_artesano: Number(id_artesano) } });
    if (!artesano) {
        const error = new Error("Artesano no encontrado");
        error.statusCode = 404;
        throw error;
    }

    const anioActual = new Date().getFullYear();
    const inscripcionExistente = await prisma.inscripcion.findFirst({
        where: { id_artesano: Number(id_artesano), anio: anioActual }
    });

    if (inscripcionExistente) {
        return await prisma.inscripcion.update({
            where: { id_inscripcion: inscripcionExistente.id_inscripcion },
            data: {
                id_stand: Number(id_stand),
                estado: "APROBADA",
                fecha_resolucion: new Date()
            },
            include: { stand: true, artesano: true }
        });
    }

    return await prisma.inscripcion.create({
        data: {
            id_artesano: Number(id_artesano),
            id_stand: Number(id_stand),
            anio: anioActual,
            fecha_solicitud: new Date(),
            fecha_resolucion: new Date(),
            estado: "APROBADA",
            observaciones: "Asignación directa por administrador"
        },
        include: { stand: true, artesano: true }
    });
};
