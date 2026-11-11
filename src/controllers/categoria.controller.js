import {
    getCategorias,
    crearCategoria,
    getCategoriaById,
    actualizarCategoria,
    eliminarCategoria
} from "../services/categoria.service.js";

export const obtenerCategorias = async (req, res, next) => {
    /*
        #swagger.tags = ['Categorías']
        #swagger.summary = 'Listar categorías de productos con paginación (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = { in: 'query', description: 'Filtrar por nombre', required: false, '@schema': { type: 'string' } }
        #swagger.parameters['page'] = { in: 'query', description: 'Página', required: false, '@schema': { type: 'integer', minimum: 1, default: 1 } }
        #swagger.parameters['limit'] = { in: 'query', description: 'Límite por página', required: false, '@schema': { type: 'integer', minimum: 1, maximum: 100, default: 10 } }
        #swagger.responses[200] = { description: 'Listado de categorías' }
    */
    try {
        const data = await getCategorias(req.queryValidada);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Categorías']
        #swagger.summary = 'Crear una categoría de productos (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/CategoriaEntrada" } } }
        }
        #swagger.responses[201] = { description: 'Categoría creada exitosamente' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const nuevo = await crearCategoria(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Categorías']
        #swagger.summary = 'Obtener una categoría por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la categoría', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[200] = { description: 'Categoría encontrada' }
        #swagger.responses[404] = { description: 'Categoría no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await getCategoriaById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Categoria no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Categorías']
        #swagger.summary = 'Actualizar una categoría por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la categoría', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.requestBody = {
            required: true,
            content: { "application/json": { schema: { $ref: "#/components/schemas/CategoriaEntrada" } } }
        }
        #swagger.responses[200] = { description: 'Categoría actualizada' }
        #swagger.responses[400] = { description: 'Datos inválidos', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Categoría no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        const item = await actualizarCategoria(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Categorías']
        #swagger.summary = 'Eliminar una categoría por su ID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = { in: 'path', description: 'ID de la categoría', required: true, '@schema': { type: 'integer', minimum: 1 } }
        #swagger.responses[204] = { description: 'Categoría eliminada exitosamente' }
        #swagger.responses[401] = { description: 'No autenticado', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[403] = { description: 'Requiere rol Administrador', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
        #swagger.responses[404] = { description: 'Categoría no encontrada', content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } } }
    */
    try {
        await eliminarCategoria(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
