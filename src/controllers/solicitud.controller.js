import {
    getSolicitudes,
    getSolicitudById,
    resolverSolicitud
} from "../services/solicitud.service.js";

// Criterio 4: Listado de solicitudes (Solo ADMIN)
export const obtenerSolicitudes = async (req, res, next) => {
    /*
        #swagger.tags = ['Solicitudes']
        #swagger.summary = 'Listar solicitudes de postulación con filtros y paginación (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['estado'] = {
            in: 'query',
            description: 'Filtrar por estado de la solicitud',
            required: false,
            '@schema': { type: 'string', enum: ['PENDIENTE', 'APROBADA', 'RECHAZADA', 'MODIFICACION'] }
        }
        #swagger.parameters['sortBy'] = {
            in: 'query',
            description: 'Campo de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['created_at', 'estado'], default: 'created_at' }
        }
        #swagger.parameters['order'] = {
            in: 'query',
            description: 'Dirección de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['asc', 'desc'], default: 'desc' }
        }
        #swagger.parameters['page'] = {
            in: 'query',
            description: 'Número de página',
            required: false,
            '@schema': { type: 'integer', minimum: 1, default: 1 }
        }
        #swagger.parameters['limit'] = {
            in: 'query',
            description: 'Cantidad de resultados por página (1 a 100)',
            required: false,
            '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 }
        }
        #swagger.responses[200] = {
            description: 'Listado paginado de solicitudes de postulación',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ListaSolicitudesRespuesta" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'No autenticado o token inválido',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const data = await getSolicitudes(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Solicitudes']
        #swagger.summary = 'Obtener detalle de una solicitud de postulación por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico de la solicitud',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[200] = {
            description: 'Detalle de la solicitud',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/SolicitudRespuesta" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[404] = {
            description: 'Solicitud no encontrada',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
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
    /*
        #swagger.tags = ['Solicitudes']
        #swagger.summary = 'Resolver una solicitud de postulación (APROBADA habilita rol Artesano; RECHAZADA o MODIFICACION no habilita)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico de la solicitud a resolver',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ResolverSolicitudEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Solicitud resuelta exitosamente (transacción atómica)',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/SolicitudRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Estado inválido (debe ser APROBADA, RECHAZADA o MODIFICACION)',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[404] = {
            description: 'Solicitud no encontrada',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[409] = {
            description: 'Conflicto: la solicitud ya fue resuelta previamente',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const resultado = await resolverSolicitud(req.params.id, req.body);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};
