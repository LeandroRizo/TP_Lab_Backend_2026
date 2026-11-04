import { artesanoQueryDTO } from "../dtos/artesanoQuery.dto.js";
import {
    getArtesanos,
    crearArtesano,
    getArtesanoById,
    actualizarArtesano,
    eliminarArtesano
} from "../services/artesano.service.js";

export const obtenerArtesanos = async (req, res, next) => {
    /*
        #swagger.tags = ['Artesanos']
        #swagger.summary = 'Listar artesanos con filtros, ordenamiento y paginación (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = {
            in: 'query',
            description: 'Filtrar por nombre del artesano',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['apellido'] = {
            in: 'query',
            description: 'Filtrar por apellido del artesano',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['dni'] = {
            in: 'query',
            description: 'Filtrar por DNI',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['id_localidad'] = {
            in: 'query',
            description: 'Filtrar por ID de localidad',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['id_rubro'] = {
            in: 'query',
            description: 'Filtrar por ID de rubro artesanal',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['sortBy'] = {
            in: 'query',
            description: 'Campo de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['nombre', 'apellido', 'dni', 'created_at'], default: 'nombre' }
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
            description: 'Listado paginado de artesanos',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ListaArtesanosRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Parámetros de consulta inválidos',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const filtros = artesanoQueryDTO(req.queryValidada);
        const data = await getArtesanos(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Artesanos']
        #swagger.summary = 'Registrar un artesano directamente (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ArtesanoEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Artesano creado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ArtesanoRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de artesano inválidos',
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
        #swagger.responses[409] = {
            description: 'DNI o usuario ya vinculado a otro artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const nuevo = await crearArtesano(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Artesanos']
        #swagger.summary = 'Obtener detalle de un artesano por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del artesano',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[200] = {
            description: 'Datos públicos del artesano',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ArtesanoPublicoRespuesta" }
                }
            }
        }
        #swagger.responses[404] = {
            description: 'Artesano no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await getArtesanoById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Artesano no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Artesanos']
        #swagger.summary = 'Modificar datos de un artesano por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del artesano',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ArtesanoEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Artesano actualizado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ArtesanoRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de artesano inválidos',
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
            description: 'Artesano no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await actualizarArtesano(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Artesanos']
        #swagger.summary = 'Eliminar un artesano por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del artesano',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[204] = {
            description: 'Artesano eliminado exitosamente'
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
            description: 'Artesano no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await eliminarArtesano(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
