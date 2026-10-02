import { inscripcionQueryDTO } from "../dtos/inscripcionQuery.dto.js";
import {
    getInscripcions,
    crearInscripcion,
    getInscripcionById,
    actualizarInscripcion,
    eliminarInscripcion
} from "../services/inscripcion.service.js";

export const obtenerInscripcions = async (req, res) => {
    try {
        const filtros = inscripcionQueryDTO(req.queryValidada);
        const data = await getInscripcions(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearInscripcion(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getInscripcionById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Inscripcion no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarInscripcion(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Inscripcion no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarInscripcion(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Inscripcion no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
