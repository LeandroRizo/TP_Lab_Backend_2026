import {
    getSolicitudes,
    getSolicitudById,
    resolverSolicitud
} from "../services/solicitud.service.js";

// Criterio 4: Listado de solicitudes (Solo ADMIN)
export const obtenerSolicitudes = async (req, res, next) => {
    try {
        const data = await getSolicitudes(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getSolicitudById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Solicitud no encontrada" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

// Criterio 6: Resolución de solicitud (Solo ADMIN)
export const resolver = async (req, res, next) => {
    try {
        const resultado = await resolverSolicitud(req.params.id, req.body);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};
