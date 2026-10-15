import { usuarioQueryDTO } from "../dtos/usuarioQuery.dto.js";
import {
    getUsuarios,
    crearUsuario,
    getUsuarioById,
    actualizarUsuario,
    eliminarUsuario
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
