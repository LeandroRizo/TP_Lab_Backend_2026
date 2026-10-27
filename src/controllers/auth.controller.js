import {
    registrarUsuario,
    autenticarUsuario,
    obtenerUsuarioPorId,
    revocarToken,
    postularArtesano
} from "../services/auth.service.js";

// Criterio 1.4: Registro (201) devuelve solo campos públicos
export const registrar = async (req, res, next) => {
    try {
        const nuevoUsuario = await registrarUsuario(req.body);
        res.status(201).json(nuevoUsuario);
    } catch (error) {
        next(error);
    }
};

// Criterio 1.4: Login (200) devuelve solo campos públicos y el token
export const login = async (req, res, next) => {
    try {
        const resultado = await autenticarUsuario(req.body);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Criterio 6: Postulación pública (crea cuenta, Artesano y solicitud PENDIENTE)
export const postularse = async (req, res, next) => {
    try {
        const resultado = await postularArtesano(req.body);
        res.status(201).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Criterio 2.5: Ruta protegida GET /me; el id sale de req.usuario.id; 401 si no existe
export const obtenerMe = async (req, res, next) => {
    try {
        const usuario = await obtenerUsuarioPorId(req.usuario.id);
        res.status(200).json(usuario);
    } catch (error) {
        next(error);
    }
};

// Criterio 2.6: POST /logout -> 204
export const logout = async (req, res, next) => {
    try {
        await revocarToken(req.tokenInfo.jti, req.tokenInfo.exp);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
