import { standQueryDTO } from "../dtos/standQuery.dto.js";
import {
    getStands,
    crearStand,
    getStandById,
    actualizarStand,
    eliminarStand
} from "../services/stand.service.js";

export const obtenerStands = async (req, res) => {
    try {
        const filtros = standQueryDTO(req.queryValidada);
        const data = await getStands(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearStand(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getStandById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarStand(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarStand(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
