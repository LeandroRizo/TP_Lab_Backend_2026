import { standQueryDTO } from "../dtos/standQuery.dto.js";
import {
    getStands,
    crearStand,
    getStandById,
    actualizarStand,
    eliminarStand,
    asignarArtesanoAStand,
    getStandsConUbicacion,
    getStandUbicacionById
} from "../services/stand.service.js";

export const obtenerStands = async (req, res, next) => {
    try {
        const filtros = standQueryDTO(req.queryValidada);
        const data = await getStands(filtros);
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const crear = async (req, res, next) => {
    try {
        const nuevo = await crearStand(req.body);
        res.status(201).json(nuevo);
    } catch (error) {
        next(error);
    }
};

export const obtenerPorId = async (req, res, next) => {
    try {
        const item = await getStandById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const actualizar = async (req, res, next) => {
    try {
        const item = await actualizarStand(req.params.id, req.body);
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};

export const eliminar = async (req, res, next) => {
    try {
        await eliminarStand(req.params.id);
        res.status(204).send();
    } catch (error) {
        next(error);
    }
};

// Criterio 4: Asignación artesano–stand
export const asignarArtesano = async (req, res, next) => {
    try {
        const id_stand = req.params.id || req.body.id_stand;
        const id_artesano = req.body.id_artesano;
        const resultado = await asignarArtesanoAStand(id_stand, id_artesano);
        res.status(200).json(resultado);
    } catch (error) {
        next(error);
    }
};

// Endpoint de stands con ubicación: pabellón, sector y coordenadas en JSON
export const obtenerUbicaciones = async (req, res, next) => {
    try {
        const data = await getStandsConUbicacion();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const obtenerUbicacionPorId = async (req, res, next) => {
    try {
        const item = await getStandUbicacionById(req.params.id);
        if (!item) return res.status(404).json({ mensaje: "Stand no encontrado" });
        res.status(200).json(item);
    } catch (error) {
        next(error);
    }
};
