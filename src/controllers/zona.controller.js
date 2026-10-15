import { zonaQueryDTO } from "../dtos/zonaQuery.dto.js";
import {
    getZonas,
    crearZona,
    getZonaById,
    actualizarZona,
    eliminarZona
} from "../services/zona.service.js";

export const obtenerZonas = async (req, res, next) => {
    try {
        const filtros = zonaQueryDTO(req.queryValidada);
        const data = await getZonas(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearZona(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getZonaById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Zona no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarZona(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarZona(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
