import { usuarioQueryDTO } from "../dtos/usuarioQuery.dto.js";
import {
    getUsuarios,
    crearUsuario,
    getUsuarioById,
    actualizarUsuario,
    eliminarUsuario,
    crearAdministrador,
    cambiarEstadoCuenta
} from "../services/usuario.service.js";

export const obtenerUsuarios = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Listar cuentas de usuario con filtros y paginación (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['email'] = {
            in: 'query',
            description: 'Filtrar por email parcial o exacto',
            required: false,
            '@schema': { type: 'string' }
        }
        #swagger.parameters['sortBy'] = {
            in: 'query',
            description: 'Campo de ordenamiento',
            required: false,
            '@schema': { type: 'string', enum: ['email'], default: 'email' }
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
            description: 'Listado paginado de usuarios'
        }
        #swagger.responses[401] = {
            description: 'No autenticado o token inválido',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador o cuenta inactiva',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const filtros = usuarioQueryDTO(req.queryValidada);
        const data = await getUsuarios(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Crear un usuario desde administración (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Usuario creado exitosamente',
            content: { "application/json": { schema: { $ref: "#/components/schemas/UsuarioPublico" } } }
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
        #swagger.responses[409] = {
            description: 'Email duplicado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const nuevo = await crearUsuario(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Obtener un usuario por su UUID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'UUID del usuario',
            required: true,
            '@schema': { type: 'string', format: 'uuid' }
        }
        #swagger.responses[200] = {
            description: 'Usuario encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/UsuarioPublico" } } }
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
            description: 'Usuario no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await getUsuarioById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Usuario no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Actualizar datos de un usuario (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'UUID del usuario',
            required: true,
            '@schema': { type: 'string', format: 'uuid' }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioActualizarEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Usuario actualizado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/UsuarioPublico" } } }
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
            description: 'Usuario no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const item = await actualizarUsuario(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Eliminar un usuario por su UUID (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'UUID del usuario',
            required: true,
            '@schema': { type: 'string', format: 'uuid' }
        }
        #swagger.responses[204] = {
            description: 'Usuario eliminado exitosamente'
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
            description: 'Usuario no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await eliminarUsuario(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 7: Endpoints solo para admin - Crear administrador
export const crearAdmin = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Dar de alta una nueva cuenta con rol Administrador (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/CrearAdminEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Cuenta de administrador creada exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioPublico" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de entrada inválidos',
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
            description: 'Conflicto: el email ya se encuentra registrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const nuevoAdmin = await crearAdministrador(req.body);
        res.status(201).json(nuevoAdmin);
    } catch (error) {
        next(error);
    }
};

// Criterio 7: Endpoints solo para admin - Activar o desactivar cuentas
export const cambiarEstado = async (req, res, next) => {
    /*
        #swagger.tags = ['Usuarios']
        #swagger.summary = 'Activar o desactivar una cuenta de usuario (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['id'] = {
            in: 'path',
            description: 'UUID de la cuenta de usuario',
            required: true,
            '@schema': { type: 'string', format: 'uuid' }
        }
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/EstadoCuentaEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Estado de la cuenta actualizado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioPublico" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'El campo activo debe ser booleano',
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
            description: 'Usuario no encontrado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[409] = {
            description: 'Conflicto: no se permite desactivar al último administrador activo',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        const { activo } = req.body;
        const usuarioActualizado = await cambiarEstadoCuenta(req.params.id, activo);
        res.status(200).json(usuarioActualizado);
    } catch (error) {
        next(error);
    }
};
