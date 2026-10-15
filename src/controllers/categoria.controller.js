import { categoriaQueryDTO } from "../dtos/categoriaQuery.dto.js";
import {
    getCategorias,
    crearCategoria,
    getCategoriaById,
    actualizarCategoria,
    eliminarCategoria
} from "../services/categoria.service.js";

export const obtenerCategorias = async (req, res, next) => {
    try {
        const filtros = categoriaQueryDTO(req.queryValidada);
        const data = await getCategorias(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearCategoria(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getCategoriaById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Categoria no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarCategoria(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarCategoria(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};
