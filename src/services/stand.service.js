import prisma from "../prisma.js";
import { artesanoPublicoDTO } from "../dtos/artesano.dto.js";

function sanitizarStandPublico(stand) {
    if (!stand) return null;

    let inscripcionesSanitizadas = stand.inscripciones;
    if (Array.isArray(stand.inscripciones)) {
        inscripcionesSanitizadas = stand.inscripciones.map((insc) => {
            return {
                ...insc,
                artesano: artesanoPublicoDTO(insc.artesano)
            };
        });
    }

    return {
        ...stand,
        inscripciones: inscripcionesSanitizadas
    };
}

export const getStands = async (filtros) => {
    const where = {};

    if (filtros.numero) {
        where.numero = filtros.numero;
    }

    if (filtros.id_pabellon || filtros.pabellon || filtros.zona || filtros.sector) {
        where.zona = {};

        if (filtros.id_pabellon) {
            where.zona.id_pabellon = Number(filtros.id_pabellon);
        } else if (filtros.pabellon) {
            where.zona.pabellon = {
                nombre: { contains: filtros.pabellon, mode: "insensitive" }
            };
        }

        if (filtros.zona || filtros.sector) {
            const sectorNombre = filtros.zona || filtros.sector;
            where.zona.nombre = { contains: sectorNombre, mode: "insensitive" };
        }
    }

    if (filtros.id_zona) {
        where.id_zona = Number(filtros.id_zona);
    }

    if (filtros.estado) {
        const est = filtros.estado.toUpperCase();
        if (est === "DISPONIBLE" || est === "LIBRE") {
            where.inscripciones = { none: { estado: "APROBADA" } };
        } else if (est === "OCUPADO") {
            where.inscripciones = { some: { estado: "APROBADA" } };
        }
    }

    const skip = (filtros.page - 1) * filtros.limit;
    const [stands, total] = await Promise.all([
        prisma.stand.findMany({
            where,
            include: {
                zona: {
                    include: { pabellon: true }
                },
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
        data: stands.map(sanitizarStandPublico),
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

export const getStandById = async (id) => {
    const stand = await prisma.stand.findUnique({
        where: { id_stand: Number(id) },
        include: {
            zona: {
                include: { pabellon: true }
            },
            inscripciones: {
                include: { artesano: true }
            }
        }
    });
    return sanitizarStandPublico(stand);
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

    // Verificar si el stand ya está asignado y aprobado para otro artesano en el año actual
    const standOcupado = await prisma.inscripcion.findFirst({
        where: {
            id_stand: Number(id_stand),
            anio: anioActual,
            estado: "APROBADA",
            id_artesano: { not: Number(id_artesano) }
        },
        include: { artesano: true }
    });

    if (standOcupado) {
        const nombreArtesano = standOcupado.artesano
            ? `${standOcupado.artesano.nombre} ${standOcupado.artesano.apellido}`
            : `ID ${standOcupado.id_artesano}`;
        const error = new Error(`El stand ${id_stand} ya se encuentra asignado al artesano ${nombreArtesano} para el año ${anioActual}`);
        error.statusCode = 409;
        throw error;
    }

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

// Endpoint de stands con ubicación: pabellón, sector y coordenadas en JSON
function formatearUbicacionStand(stand) {
    const pabellon = stand.zona ? stand.zona.pabellon : null;
    const pabNum = pabellon && pabellon.numero ? pabellon.numero : 1;
    const zonaNum = stand.zona && stand.zona.numero ? stand.zona.numero : 1;
    const standNum = stand.numero || 1;

    const tieneInscripcionActiva = Array.isArray(stand.inscripciones) && stand.inscripciones.length > 0;
    const estado = tieneInscripcionActiva ? "OCUPADO" : "DISPONIBLE";

    let datosArtesano = null;
    if (tieneInscripcionActiva && stand.inscripciones[0].artesano) {
        const art = stand.inscripciones[0].artesano;
        datosArtesano = {
            id_artesano: art.id_artesano,
            nombre: art.nombre,
            apellido: art.apellido
        };
    }

    let datosPabellon = null;
    if (pabellon) {
        datosPabellon = {
            id_pabellon: pabellon.id_pabellon,
            numero: pabellon.numero,
            nombre: pabellon.nombre
        };
    }

    let datosSector = null;
    if (stand.zona) {
        datosSector = {
            id_zona: stand.zona.id_zona,
            numero: stand.zona.numero,
            nombre: stand.zona.nombre
        };
    }

    return {
        id_stand: stand.id_stand,
        numero: stand.numero,
        descripcion: stand.descripcion,
        estado,
        artesano: datosArtesano,
        pabellon: datosPabellon,
        sector: datosSector,
        coordenadas: {
            x: standNum * 12 + zonaNum * 100,
            y: pabNum * 80 + (standNum % 5) * 15,
            lat: Number((-28.4692 + pabNum * 0.0005 + standNum * 0.00002).toFixed(6)),
            lng: Number((-65.7853 + zonaNum * 0.0004 + standNum * 0.00003).toFixed(6))
        }
    };
}

export const getStandsConUbicacion = async () => {
    const stands = await prisma.stand.findMany({
        include: {
            zona: {
                include: { pabellon: true }
            },
            inscripciones: {
                where: { estado: "APROBADA" },
                include: { artesano: true }
            }
        },
        orderBy: { numero: "asc" }
    });

    return stands.map((stand) => formatearUbicacionStand(stand));
};

export const getStandUbicacionById = async (id) => {
    const stand = await prisma.stand.findUnique({
        where: { id_stand: Number(id) },
        include: {
            zona: {
                include: { pabellon: true }
            },
            inscripciones: {
                where: { estado: "APROBADA" },
                include: { artesano: true }
            }
        }
    });

    if (!stand) return null;
    return formatearUbicacionStand(stand);
};
