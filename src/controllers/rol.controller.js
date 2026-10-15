import { rolQueryDTO } from "../dtos/rolQuery.dto.js";
import {
    getRols,
    crearRol,
    getRolById,
    actualizarRol,
    eliminarRol
} from "../services/rol.service.js";

export const obtenerRols = async (req, res, next) => {
    try {
        const filtros = rolQueryDTO(req.queryValidada);
        const data = await getRols(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearRol(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getRolById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Rol no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarRol(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarRol(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
