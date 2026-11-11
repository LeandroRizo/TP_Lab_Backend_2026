import {
    getPabellons,
    crearPabellon,
    getPabellonById,
    actualizarPabellon,
    eliminarPabellon
} from "../services/pabellon.service.js";

export const obtenerPabellons = async (req, res, next) => {
    /*
        #swagger.tags = ['Pabellones']
        #swagger.summary = 'Listar pabellones del predio (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = { in: 'query', description: 'Filtrar por nombre', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['page'] = { in: 'query', description: 'Página', required: false, '@schema': { type: 'integer', minimum: 1, default: 1 } }
        #swagger.parameters['limit'] = { in: 'query', description: 'Límite por página', required: false, '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 } }
        #swagger.responses[200] = { description: 'Listado de pabellones' }
    */
    try {
        const data = await getPabellons(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Pabellones']
        #swagger.summary = 'Crear un pabellón (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/PabellonEntrada" } } }
        }
        #swagger.responses[201] = { description: 'Pabellón creado exitosamente' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const nuevo = await crearPabellon(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Pabellones']
        #swagger.summary = 'Obtener un pabellón por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = { in: 'path', description: 'ID del pabellón', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[200] = { description: 'Pabellón encontrado' }
        #swagger.responses[404] = { description: 'Pabellón no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await getPabellonById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Pabellon no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Pabellones']
        #swagger.summary = 'Actualizar un pabellón por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID del pabellón', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/PabellonEntrada" } } }
        }
        #swagger.responses[200] = { description: 'Pabellón actualizado' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Pabellón no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await actualizarPabellon(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Pabellones']
        #swagger.summary = 'Eliminar un pabellón por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID del pabellón', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[204] = { description: 'Pabellón eliminado exitosamente' }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Pabellón no encontrado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        await eliminarPabellon(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
