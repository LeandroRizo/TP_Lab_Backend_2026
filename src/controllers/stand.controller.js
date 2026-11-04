import { standQueryDTO } from "../dtos/standQuery.dto.js";
import {
    getStands,
    crearStand,
    getStandById,
    actualizarStand,
    eliminarStand,
    asignarArtesanoAStand,
    getStandsConUbicacion,
    getStandUbicacionById
} from "../services/stand.service.js";

export const obtenerStands = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Consultar stands del predio con filtros por pabellón, sector y estado (Público)'
        #swagger.security = []
        #swagger.parameters['numero'] = {
            in: 'query',
            description: 'Filtrar por número de stand',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['id_pabellon'] = {
            in: 'query',
            description: 'Filtrar por ID de pabellón',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['pabellon'] = {
            in: 'query',
            description: 'Filtrar por nombre o número de pabellón',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['id_zona'] = {
            in: 'query',
            description: 'Filtrar por ID de zona/sector',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['sector'] = {
            in: 'query',
            description: 'Filtrar por nombre o número de sector/zona',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['estado'] = {
            in: 'query',
            description: 'Filtrar por estado de ocupación del stand',
            required: false,
            '@schema': { type: 'string', enum: ['DISPONIBLE', 'OCUPADO'] }
        }
        #swagger.parameters['sortBy'] = {
            in: 'query',
            description: 'Campo de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['numero', 'created_at'], default: 'numero' }
        }
        #swagger.parameters['order'] = {
            in: 'query',
            description: 'Dirección de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['asc', 'desc'], default: 'asc' }
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
            description: 'Listado paginado de stands con su estado y ubicación',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ListaStandsRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Parámetros de consulta inválidos',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const filtros = standQueryDTO(req.queryValidada);
        const data = await getStands(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Crear un nuevo stand dentro del predio (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Stand creado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de stand inválidos',
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
    */
    try {
        const nuevo = await crearStand(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Obtener detalle de un stand por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del stand',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[200] = {
            description: 'Datos del stand',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandRespuesta" }
                }
            }
        }
        #swagger.responses[404] = {
            description: 'Stand no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await getStandById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Modificar un stand por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del stand',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Stand actualizado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos inválidos',
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
            description: 'Stand no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await actualizarStand(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Eliminar un stand por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del stand',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[204] = {
            description: 'Stand eliminado exitosamente'
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
            description: 'Stand no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await eliminarStand(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 4: Asignación artesano–stand
export const asignarArtesano = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Asignar un artesano a un stand del predio (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/AsignarStandEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Stand asignado al artesano exitosamente'
        }
        #swagger.responses[400] = {
            description: 'Datos de asignación inválidos',
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
            description: 'Stand o artesano no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const id_stand = req.params.id || req.body.id_stand;
        const id_artesano = req.body.id_artesano;
        const resultado = await asignarArtesanoAStand(id_stand, id_artesano);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Endpoint de stands con ubicación: pabellón, sector y coordenadas en JSON
export const obtenerUbicaciones = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Obtener todos los stands con su ubicación detallada (pabellón, sector y coordenadas) en JSON (Público)'
        #swagger.security = []
        #swagger.responses[200] = {
            description: 'Lista de stands con pabellón, sector y coordenadas geográficas/plano',
            content: {
                "application/json": {
                    schema: {
                        type: "array",
                        items: { $ref: "#/components/schemas/StandUbicacionRespuesta" }
                    }
                }
            }
        }
    */
    try {
        const data = await getStandsConUbicacion();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerUbicacionPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Stands']
        #swagger.summary = 'Obtener la ubicación detallada (pabellón, sector y coordenadas) de un stand específico (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del stand',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[200] = {
            description: 'Ubicación detallada del stand',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/StandUbicacionRespuesta" }
                }
            }
        }
        #swagger.responses[404] = {
            description: 'Stand no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await getStandUbicacionById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};
