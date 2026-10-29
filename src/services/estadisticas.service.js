// Servicio para registro de consultas de visitantes y análisis de tendencias de búsqueda

const MAX_HISTORIAL = 1000;
const historialBusquedas = [];

export const registrarBusqueda = ({ termino, entidad, ip, userAgent }) => {
    if (!termino || typeof termino !== "string") return;
    const terminoLimpio = termino.trim().toLowerCase();
    if (!terminoLimpio) return;

    const evento = {
        termino: terminoLimpio,
        entidad: entidad || "general",
        ip: ip || "127.0.0.1",
        userAgent: userAgent || "unknown",
        fecha: new Date()
    };

    historialBusquedas.push(evento);
    if (historialBusquedas.length > MAX_HISTORIAL) {
        historialBusquedas.shift();
    }

    return evento;
};

export const obtenerTendencias = (limiteTop = 10) => {
    const total = historialBusquedas.length;
    const frecuencias = {};
    const porEntidad = {};

    for (const item of historialBusquedas) {
        frecuencias[item.termino] = (frecuencias[item.termino] || 0) + 1;
        porEntidad[item.entidad] = (porEntidad[item.entidad] || 0) + 1;
    }

    const terminosPopulares = Object.entries(frecuencias)
        .map(([termino, cantidad]) => ({
            termino,
            cantidad,
            porcentaje: total > 0 ? Number(((cantidad / total) * 100).toFixed(1)) : 0
        }))
        .sort((a, b) => b.cantidad - a.cantidad)
        .slice(0, limiteTop);

    const ultimasBusquedas = historialBusquedas
        .slice(-20)
        .reverse()
        .map(b => ({
            termino: b.termino,
            entidad: b.entidad,
            fecha: b.fecha
        }));

    return {
        total_consultas_registradas: total,
        terminos_populares: terminosPopulares,
        consultas_por_entidad: porEntidad,
        ultimas_consultas: ultimasBusquedas
    };
};

export const limpiarHistorialBusquedas = () => {
    historialBusquedas.length = 0;
};
