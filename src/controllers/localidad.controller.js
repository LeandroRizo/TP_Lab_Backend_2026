import {
    getLocalidads,
    crearLocalidad,
    getLocalidadById,
    actualizarLocalidad,
    eliminarLocalidad
} from "../services/localidad.service.js";

export const obtenerLocalidads = async (req, res, next) => {
    /*
        #swagger.tags = ['Localidades']
        #swagger.summary = 'Listar localidades con paginación (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = { in: 'query', description: 'Filtrar por nombre', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['provincia'] = { in: 'query', description: 'Filtrar por provincia', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['departamento'] = { in: 'query', description: 'Filtrar por departamento', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['sortBy'] = { in: 'query', description: 'Campo de ordenamiento', required: false, '@schema': { type: 'string', enum: ['nombre', 'provincia', 'departamento', 'id_localidad'], default: 'nombre' } }
        #swagger.parameters['order'] = { in: 'query', description: 'Dirección de ordenamiento', required: false, '@schema': { type: 'string', enum: ['asc', 'desc'], default: 'asc' } }
        #swagger.parameters['page'] = { in: 'query', description: 'Página', required: false, '@schema': { type: 'integer', minimum: 1, default: 1 } }
        #swagger.parameters['limit'] = { in: 'query', description: 'Límite por página', required: false, '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 } }
        #swagger.responses[200] = { description: 'Listado de localidades' }
    */
    try {
        const data = await getLocalidads(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Localidades']
        #swagger.summary = 'Crear una localidad (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/LocalidadEntrada" } } }
        }
        #swagger.responses[201] = { description: 'Localidad creada exitosamente' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const nuevo = await crearLocalidad(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Localidades']
        #swagger.summary = 'Obtener una localidad por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la localidad', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[200] = { description: 'Localidad encontrada' }
        #swagger.responses[404] = { description: 'Localidad no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await getLocalidadById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Localidad no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Localidades']
        #swagger.summary = 'Actualizar una localidad por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la localidad', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/LocalidadEntrada" } } }
        }
        #swagger.responses[200] = { description: 'Localidad actualizada' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Localidad no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await actualizarLocalidad(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Localidades']
        #swagger.summary = 'Eliminar una localidad por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la localidad', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[204] = { description: 'Localidad eliminada exitosamente' }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Localidad no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        await eliminarLocalidad(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
