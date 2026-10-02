import { categoriaQueryDTO } from "../dtos/categoriaQuery.dto.js";
import {
    getCategorias,
    crearCategoria,
    getCategoriaById,
    actualizarCategoria,
    eliminarCategoria
} from "../services/categoria.service.js";

export const obtenerCategorias = async (req, res) => {
    try {
        const filtros = categoriaQueryDTO(req.queryValidada);
        const data = await getCategorias(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearCategoria(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getCategoriaById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Categoria no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarCategoria(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Categoria no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarCategoria(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Categoria no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
