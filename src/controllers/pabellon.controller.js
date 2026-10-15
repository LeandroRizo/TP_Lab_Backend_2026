import { pabellonQueryDTO } from "../dtos/pabellonQuery.dto.js";
import {
    getPabellons,
    crearPabellon,
    getPabellonById,
    actualizarPabellon,
    eliminarPabellon
} from "../services/pabellon.service.js";

export const obtenerPabellons = async (req, res, next) => {
    try {
        const filtros = pabellonQueryDTO(req.queryValidada);
        const data = await getPabellons(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearPabellon(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getPabellonById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Pabellon no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarPabellon(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarPabellon(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
