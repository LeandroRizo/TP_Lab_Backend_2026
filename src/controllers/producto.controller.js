import { productoQueryDTO } from "../dtos/productoQuery.dto.js";
import {
    getProductos,
    crearProducto,
    getProductoById,
    actualizarProducto,
    eliminarProducto
} from "../services/producto.service.js";

export const obtenerProductos = async (req, res) => {
    try {
        const filtros = productoQueryDTO(req.queryValidada);
        const data = await getProductos(filtros);
        res.status(200).json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const crear = async (req, res) => {
    try {
        const nuevo = await crearProducto(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const obtenerPorId = async (req, res) => {
    try {
        const item = await getProductoById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Producto no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

export const actualizar = async (req, res) => {
    try {
        const item = await actualizarProducto(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Producto no encontrado" });
        res.status(500).json({ error: error.message });
    }
};

export const eliminar = async (req, res) => {
    try {
        await eliminarProducto(req.params.id);
        res.status(204).send();
    } catch (error) {
        if (error.code === 'P2025') return res.status(404).json({ mensaje: "Producto no encontrado" });
        res.status(500).json({ error: error.message });
    }
};
