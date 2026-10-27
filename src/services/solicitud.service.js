import prisma from "../prisma.js";

// Criterio 4: Listado de solicitudes (Solo ADMIN)
export const getSolicitudes = async (filtros = {}) => {
    const where = {};
    if (filtros.estado) {
        where.estado = { equals: filtros.estado, mode: 'insensitive' };
    }

    const page = filtros.page || 1;
    const limit = filtros.limit || 10;
    const skip = (page - 1) * limit;

    const [solicitudes, total] = await Promise.all([
        prisma.solicitud.findMany({
            where,
            include: {
                artesano: {
                    include: {
                        usuario: {
                            select: {
                                id_usuario: true,
                                nombre: true,
                                email: true,
                                activo: true,
                                id_rol: true,
                                rol: true
                            }
                        },
                        localidad: true,
                        rubro: true
                    }
                }
            },
            orderBy: { [filtros.sortBy || "created_at"]: filtros.order || "desc" },
            skip,
            take: limit
        }),
        prisma.solicitud.count({ where })
    ]);

    const totalPages = Math.ceil(total / limit);
    return {
        data: solicitudes,
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

export const getSolicitudById = async (id) => {
    return await prisma.solicitud.findUnique({
        where: { id_solicitud: Number(id) },
        include: {
            artesano: {
                include: {
                    usuario: true,
                    localidad: true,
                    rubro: true
                }
            }
        }
    });
};

// Criterio 6: Resolución de solicitud (Solo ADMIN)
// Resolver una solicitud ya resuelta → 409
// Al aprobar (solo admin), el estado cambia y la cuenta queda habilitada como ARTESANO en la misma transacción.
// Rechazar o pedir modificaciones no habilita.
export const resolverSolicitud = async (id_solicitud, { estado, motivo_rechazo, observaciones }) => {
    const solicitud = await prisma.solicitud.findUnique({
        where: { id_solicitud: Number(id_solicitud) },
        include: {
            artesano: {
                include: { usuario: true }
            }
        }
    });

    if (!solicitud) {
        const error = new Error("Solicitud no encontrada");
        error.statusCode = 404;
        throw error;
    }

    // Criterio 6: Resolver una solicitud ya resuelta → 409
    if (solicitud.estado.toUpperCase() !== "PENDIENTE") {
        const error = new Error("La solicitud ya ha sido resuelta previamente");
        error.statusCode = 409;
        throw error;
    }

    const estadoNormalizado = estado.toUpperCase();
    const esAprobada = estadoNormalizado === "APROBADA" || estadoNormalizado === "APROBADO";

    // Transacción atómica
    const solicitudActualizada = await prisma.$transaction(async (tx) => {
        // Actualizar estado de la solicitud
        const actualizada = await tx.solicitud.update({
            where: { id_solicitud: Number(id_solicitud) },
            data: {
                estado: estadoNormalizado,
                motivo_rechazo: motivo_rechazo || null,
                observaciones: observaciones || null
            },
            include: {
                artesano: {
                    include: {
                        usuario: {
                            include: { rol: true }
                        }
                    }
                }
            }
        });

        // Criterio 6: Al aprobar, la cuenta queda habilitada como ARTESANO en la misma transacción
        if (esAprobada) {
            let rolArtesano = await tx.rol.findFirst({
                where: { nombre: { equals: "Artesano", mode: "insensitive" } }
            });
            if (!rolArtesano) {
                rolArtesano = await tx.rol.findUnique({ where: { id_rol: 2 } });
            }

            if (rolArtesano) {
                await tx.usuario.update({
                    where: { id_usuario: solicitud.artesano.id_usuario },
                    data: {
                        id_rol: rolArtesano.id_rol
                    }
                });
            }
        }
        // Rechazar o pedir modificaciones NO habilita (el rol no cambia)

        return actualizada;
    });

    return solicitudActualizada;
};
