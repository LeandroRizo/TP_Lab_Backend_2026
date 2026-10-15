import { artesanoQueryDTO } from "../dtos/artesanoQuery.dto.js";
import {
    getArtesanos,
    crearArtesano,
    getArtesanoById,
    actualizarArtesano,
    eliminarArtesano
} from "../services/artesano.service.js";

export const obtenerArtesanos = async (req, res, next) => {
    try {
        const filtros = artesanoQueryDTO(req.queryValidada);
        const data = await getArtesanos(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearArtesano(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getArtesanoById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Artesano no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarArtesano(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarArtesano(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
