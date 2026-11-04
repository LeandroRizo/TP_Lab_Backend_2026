import {
    registrarUsuario,
    autenticarUsuario,
    obtenerUsuarioPorId,
    revocarToken,
    postularArtesano
} from "../services/auth.service.js";

// Criterio 1.4: Registro (201) devuelve solo campos públicos
export const registrar = async (req, res, next) => {
    /*
        #swagger.tags = ['Autenticación']
        #swagger.summary = 'Registrar una nueva cuenta de usuario'
        #swagger.security = []
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/RegistroEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Usuario registrado exitosamente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioPublico" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de entrada inválidos',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[409] = {
            description: 'Conflicto: el email ya se encuentra registrado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
    */
    try {
        const nuevoUsuario = await registrarUsuario(req.body);
        res.status(201).json(nuevoUsuario);
    } catch (error) {
        next(error);
    }
};

// Criterio 1.4: Login (200) devuelve solo campos públicos y el token
export const login = async (req, res, next) => {
    /*
        #swagger.tags = ['Autenticación']
        #swagger.summary = 'Iniciar sesión y obtener token JWT'
        #swagger.security = []
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/LoginEntrada" }
                }
            }
        }
        #swagger.responses[200] = {
            description: 'Autenticación exitosa',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/LoginRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Formato de credenciales inválido',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'Credenciales inválidas o cuenta inactiva',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
    */
    try {
        const resultado = await autenticarUsuario(req.body);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Criterio 6: Postulación pública (crea cuenta, Artesano y solicitud PENDIENTE)
export const postularse = async (req, res, next) => {
    /*
        #swagger.tags = ['Solicitudes']
        #swagger.summary = 'Postularse como artesano (crea cuenta, perfil de artesano y solicitud PENDIENTE)'
        #swagger.security = []
        #swagger.requestBody = {
            required: true,
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/PostulacionEntrada" }
                }
            }
        }
        #swagger.responses[201] = {
            description: 'Postulación creada exitosamente en estado PENDIENTE',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/PostulacionRespuesta" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Datos de postulación inválidos',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[409] = {
            description: 'Conflicto: email o DNI ya registrado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
    */
    try {
        const resultado = await postularArtesano(req.body);
        res.status(201).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Criterio 2.5: Ruta protegida GET /me; el id sale de req.usuario.id; 401 si no existe; 403 si inactiva
export const obtenerMe = async (req, res, next) => {
    /*
        #swagger.tags = ['Autenticación']
        #swagger.summary = 'Obtener los datos vigentes de la cuenta autenticada'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.responses[200] = {
            description: 'Perfil del usuario autenticado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/UsuarioPublico" }
                }
            }
        }
        #swagger.responses[400] = {
            description: 'Encabezado Authorization con formato inválido',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'Token no proporcionado, inválido, revocado o cuenta inexistente',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[403] = {
            description: 'Cuenta desactivada',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
    */
    try {
        const usuario = await obtenerUsuarioPorId(req.usuario.id);
        res.status(200).json(usuario);
    } catch (error) {
        next(error);
    }
};

// Criterio 2.6: POST /logout -> 204
export const logout = async (req, res, next) => {
    /*
        #swagger.tags = ['Autenticación']
        #swagger.summary = 'Cerrar sesión y revocar el token JWT activo'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.responses[204] = {
            description: 'Sesión cerrada exitosamente (sin contenido)'
        }
        #swagger.responses[400] = {
            description: 'Encabezado Authorization con formato inválido',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'Token no proporcionado, inválido o ya revocado',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ErrorApi" }
                }
            }
        }
    */
    try {
        await revocarToken(req.tokenInfo.jti, req.tokenInfo.exp);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
