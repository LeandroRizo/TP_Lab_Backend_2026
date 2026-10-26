import { productoQueryDTO } from "../dtos/productoQuery.dto.js";
import {
    getProductos,
    crearProducto,
    getProductoById,
    actualizarProductoPropio,
    eliminarProductoPropio,
    getMisProductos
} from "../services/producto.service.js";

// Consultas GET públicas (Criterio 4)
export const obtenerProductos = async (req, res, next) => {
    try {
        const filtros = productoQueryDTO(req.queryValidada);
        const data = await getProductos(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getProductoById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Producto no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: El artesano del alta sale de la cuenta autenticada, nunca del body
export const crear = async (req, res, next) => {
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const nuevo = await crearProducto({
            ...req.body,
            id_artesano
        });
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Modificar filtra por id y por el propietario en la misma consulta del servicio
export const actualizar = async (req, res, next) => {
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const item = await actualizarProductoPropio(req.params.id, id_artesano, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Eliminar filtra por id y por el propietario en la misma consulta del servicio
export const eliminar = async (req, res, next) => {
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        await eliminarProductoPropio(req.params.id, id_artesano);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 5: Listado propio sin parámetros del cliente
export const obtenerMisProductos = async (req, res, next) => {
    try {
        const id_artesano = req.contextoUsuario.artesano?.id_artesano;
        if (!id_artesano) {
            return res.status(403).json({ mensaje: "La cuenta no tiene un perfil de artesano vinculado" });
        }

        const data = await getMisProductos(id_artesano);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};
