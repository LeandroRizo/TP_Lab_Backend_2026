import { pabellonQueryDTO } from "../dtos/pabellonQuery.dto.js";
import {
    getPabellons,
    crearPabellon,
    getPabellonById,
    actualizarPabellon,
    eliminarPabellon
} from "../services/pabellon.service.js";

export const obtenerPabellons = async (req, res) => {
    try {
        const filtros = pabellonQueryDTO(req.queryValidada);
        const data = await getPabellons(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearPabellon(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getPabellonById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Pabellon no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarPabellon(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Pabellon no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarPabellon(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Pabellon no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
