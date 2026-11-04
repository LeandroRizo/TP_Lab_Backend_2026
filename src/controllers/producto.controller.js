import { productoQueryDTO } from "../dtos/productoQuery.dto.js";
import {
    getProductos,
    crearProducto,
    getProductoById,
    actualizarProductoPropio,
    eliminarProductoPropio,
    getMisProductos
} from "../services/producto.service.js";

// Consultas GET públicas (Criterio 4)
export const obtenerProductos = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Listar productos con filtros, ordenamiento y paginación (Público)'
        #swagger.security = []
        #swagger.parameters['nombre'] = {
            in: 'query',
            description: 'Filtrar por nombre del producto',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['id_categoria'] = {
            in: 'query',
            description: 'Filtrar por ID de categoría',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['id_artesano'] = {
            in: 'query',
            description: 'Filtrar por ID del artesano creador',
            required: false,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.parameters['precioMin'] = {
            in: 'query',
            description: 'Precio mínimo',
            required: false,
            '@schema': { type: 'number', minimum: 0 }
        }
        #swagger.parameters['precioMax'] = {
            in: 'query',
            description: 'Precio máximo',
            required: false,
            '@schema': { type: 'number', minimum: 0 }
        }
        #swagger.parameters['sortBy'] = {
            in: 'query',
            description: 'Campo de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['nombre', 'precio', 'created_at'], default: 'nombre' }
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
            description: 'Listado paginado de productos',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ListaProductosRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Parámetros de consulta inválidos',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const filtros = productoQueryDTO(req.queryValidada);
        const data = await getProductos(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Obtener detalle de un producto por su ID (Público)'
        #swagger.security = []
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del producto',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[200] = {
            description: 'Datos del producto',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ProductoRespuesta" }
                }
            }
        }
        #swagger.responses[404] = {
            description: 'Producto no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await getProductoById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Producto no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: El artesano del alta sale de la cuenta autenticada, nunca del body
export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Publicar un nuevo producto propio (Solo Artesano)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ProductoEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Producto creado y asociado al artesano autenticado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ProductoRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de producto inválidos o campo adicional no permitido',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[401] = {
            description: 'No autenticado o token inválido',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Artesano habilitado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const nuevo = await crearProducto({
            ...req.body,
            id_artesano
        });
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Modificar filtra por id y por el propietario en la misma consulta del servicio
export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Modificar un producto propio por su ID (Solo Artesano propietario)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del producto a modificar',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ProductoActualizarEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Producto propio actualizado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ProductoRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de actualización inválidos',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[404] = {
            description: 'Producto no encontrado o perteneciente a otro artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const item = await actualizarProductoPropio(req.params.id, id_artesano, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Eliminar filtra por id y por el propietario en la misma consulta del servicio
export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Eliminar un producto propio por su ID (Solo Artesano propietario)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'ID numérico del producto a eliminar',
            required: true,
            '@schema': { type: 'integer', minimum: 1 }
        }
        #swagger.responses[204] = {
            description: 'Producto propio eliminado exitosamente'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[404] = {
            description: 'Producto no encontrado o perteneciente a otro artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        await eliminarProductoPropio(req.params.id, id_artesano);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Listado propio sin parámetros del cliente
export const obtenerMisProductos = async (req, res, next) => {
    /*
        #swagger.tags = ['Productos']
        #swagger.summary = 'Listar todos los productos propios del artesano autenticado (Solo Artesano)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.responses[200] = {
            description: 'Lista de productos pertenecientes al artesano autenticado',
            content: {
                "application/json": {
                    schema: {
                        type: "array",
                        items: { $ref: "#/components/schemas/ProductoRespuesta" }
                    }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Artesano',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const data = await getMisProductos(id_artesano);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};
