import { inscripcionQueryDTO } from "../dtos/inscripcionQuery.dto.js";
import {
    getInscripcions,
    crearInscripcion,
    getInscripcionById,
    actualizarInscripcion,
    eliminarInscripcion
} from "../services/inscripcion.service.js";

export const obtenerInscripcions = async (req, res, next) => {
    try {
        const filtros = inscripcionQueryDTO(req.queryValidada);
        const data = await getInscripcions(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearInscripcion(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getInscripcionById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Inscripcion no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarInscripcion(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarInscripcion(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
