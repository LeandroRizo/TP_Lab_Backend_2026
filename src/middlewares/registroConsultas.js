import { registrarBusqueda } from "../services/estadisticas.service.js";

// Middleware para registro de consultas de visitantes
export const registroConsultas = (entidad = "general") => {
    return (req, res, next) => {
        try {
            const query = req.query || {};
            const termino = query.nombre || query.q || query.buscar || query.apellido || query.pabellon || query.sector;

            if (termino && typeof termino === "string" && termino.trim().length > 0) {
                const ip = req.ip || req.headers["x-forwarded-for"] || req.socket?.remoteAddress;
                const userAgent = req.headers["user-agent"];

                registrarBusqueda({
                    termino: termino.trim(),
                    entidad,
                    ip,
                    userAgent
                });
            }
        } catch (error) {
            // El registro de métricas nunca debe interrumpir el flujo de la petición
            console.error("Error en middleware registroConsultas:", error);
        }

        next();
    };
};
