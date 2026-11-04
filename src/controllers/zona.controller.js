import { zonaQueryDTO } from "../dtos/zonaQuery.dto.js";
import {
    getZonas,
    crearZona,
    getZonaById,
    actualizarZona,
    eliminarZona
} from "../services/zona.service.js";

export const obtenerZonas = async (req, res, next) => {
    /*
        #swagger.tags = ['Zonas']
        #swagger.summary = 'Listar zonas/sectores de los pabellones (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = { in: 'query', description: 'Filtrar por nombre', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['page'] = { in: 'query', description: 'Página', required: false, '@schema': { type: 'integer', minimum: 1, default: 1 } }
        #swagger.parameters['limit'] = { in: 'query', description: 'Límite por página', required: false, '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 } }
        #swagger.responses[200] = { description: 'Listado de zonas/sectores' }
    */
    try {
        const filtros = zonaQueryDTO(req.queryValidada);
        const data = await getZonas(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Zonas']
        #swagger.summary = 'Crear una zona/sector dentro de un pabellón (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/ZonaEntrada" } } }
        }
        #swagger.responses[201] = { description: 'Zona creada exitosamente' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const nuevo = await crearZona(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Zonas']
        #swagger.summary = 'Obtener una zona/sector por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la zona', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[200] = { description: 'Zona encontrada' }
        #swagger.responses[404] = { description: 'Zona no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await getZonaById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Zona no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Zonas']
        #swagger.summary = 'Actualizar una zona/sector por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la zona', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/ZonaEntrada" } } }
        }
        #swagger.responses[200] = { description: 'Zona actualizada' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Zona no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await actualizarZona(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Zonas']
        #swagger.summary = 'Eliminar una zona/sector por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la zona', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[204] = { description: 'Zona eliminada exitosamente' }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Zona no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        await eliminarZona(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
