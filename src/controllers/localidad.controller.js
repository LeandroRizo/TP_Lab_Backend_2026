import { localidadQueryDTO } from "../dtos/localidadQuery.dto.js";
import {
    getLocalidads,
    crearLocalidad,
    getLocalidadById,
    actualizarLocalidad,
    eliminarLocalidad
} from "../services/localidad.service.js";

export const obtenerLocalidads = async (req, res, next) => {
    try {
        const filtros = localidadQueryDTO(req.queryValidada);
        const data = await getLocalidads(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearLocalidad(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getLocalidadById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Localidad no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarLocalidad(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarLocalidad(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
