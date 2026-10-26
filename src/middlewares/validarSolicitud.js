import { resolverSolicitudSchema, solicitudQuerySchema, asignarStandSchema } from "../schemas/solicitud.schema.js";
import { resolverSolicitudDTO, solicitudQueryDTO } from "../dtos/solicitud.dto.js";

export const validarResolverSolicitud = (req, res, next) => {
    const resultado = resolverSolicitudSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de resolución de la solicitud no son válidos",
            errores: resultado.error.issues
        });
    }

    req.body = resolverSolicitudDTO(resultado.data);
    next();
};

export const validarSolicitudQuery = (req, res, next) => {
    const resultado = solicitudQuerySchema.safeParse(req.query);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }

    req.queryValidada = solicitudQueryDTO(resultado.data);
    next();
};

export const validarAsignarStand = (req, res, next) => {
    const resultado = asignarStandSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos para la asignación de stand no son válidos",
            errores: resultado.error.issues
        });
    }

    req.body = resultado.data;
    next();
};
