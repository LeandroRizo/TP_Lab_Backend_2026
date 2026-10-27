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
    try {
        const filtros = usuarioQueryDTO(req.queryValidada);
        const data = await getUsuarios(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearUsuario(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getUsuarioById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Usuario no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarUsuario(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarUsuario(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 7: Endpoints solo para admin - Crear administrador
export const crearAdmin = async (req, res, next) => {
    try {
        const nuevoAdmin = await crearAdministrador(req.body);
        res.status(201).json(nuevoAdmin);
    } catch (error) {
        next(error);
    }
};

// Criterio 7: Endpoints solo para admin - Activar o desactivar cuentas
export const cambiarEstado = async (req, res, next) => {
    try {
        const { activo } = req.body;
        const usuarioActualizado = await cambiarEstadoCuenta(req.params.id, activo);
        res.status(200).json(usuarioActualizado);
    } catch (error) {
        next(error);
    }
};
