import {
    getRubros,
    crearRubro,
    getRubroById,
    actualizarRubro,
    eliminarRubro
} from "../services/rubro.service.js";

export const obtenerRubros = async (req, res, next) => {
    /*
        #swagger.tags = ['Rubros']
        #swagger.summary = 'Listar rubros artesanales con paginación (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = { in: 'query', description: 'Filtrar por nombre', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['page'] = { in: 'query', description: 'Página', required: false, '@schema': { type: 'integer', minimum: 1, default: 1 } }
        #swagger.parameters['limit'] = { in: 'query', description: 'Límite por página', required: false, '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 } }
        #swagger.responses[200] = { description: 'Listado de rubros' }
    */
    try {
        const data = await getRubros(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Rubros']
        #swagger.summary = 'Crear un rubro artesanal (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/RubroEntrada" } } }
        }
        #swagger.responses[201] = { description: 'Rubro creado exitosamente' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const nuevo = await crearRubro(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Rubros']
        #swagger.summary = 'Obtener un rubro por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = { in: 'path', description: 'ID del rubro', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[200] = { description: 'Rubro encontrado' }
        #swagger.responses[404] = { description: 'Rubro no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await getRubroById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Rubro no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Rubros']
        #swagger.summary = 'Actualizar un rubro por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID del rubro', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/RubroEntrada" } } }
        }
        #swagger.responses[200] = { description: 'Rubro actualizado' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Rubro no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await actualizarRubro(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Rubros']
        #swagger.summary = 'Eliminar un rubro por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID del rubro', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[204] = { description: 'Rubro eliminado exitosamente' }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Rubro no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        await eliminarRubro(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
