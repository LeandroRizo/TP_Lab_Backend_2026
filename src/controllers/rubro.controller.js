import { rubroQueryDTO } from "../dtos/rubroQuery.dto.js";
import {
    getRubros,
    crearRubro,
    getRubroById,
    actualizarRubro,
    eliminarRubro
} from "../services/rubro.service.js";

export const obtenerRubros = async (req, res) => {
    try {
        const filtros = rubroQueryDTO(req.queryValidada);
        const data = await getRubros(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearRubro(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getRubroById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Rubro no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarRubro(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Rubro no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarRubro(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Rubro no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
