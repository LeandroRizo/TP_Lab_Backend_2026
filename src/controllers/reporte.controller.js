import {
    obtenerReporteGeneral,
    obtenerArtesanosPorLocalidad,
    obtenerArtesanosPorRubro,
    obtenerStandsOcupacion,
    obtenerProductosPorArtesano
} from "../services/reporte.service.js";
import { obtenerTendencias } from "../services/estadisticas.service.js";

export const getReporteGeneral = async (req, res, next) => {
    try {
        const reporte = await obtenerReporteGeneral();
        res.status(200).json(reporte);
    } catch (error) {
        next(error);
    }
};

export const getArtesanosPorLocalidadReporte = async (req, res, next) => {
    try {
        const data = await obtenerArtesanosPorLocalidad();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const getArtesanosPorRubroReporte = async (req, res, next) => {
    try {
        const data = await obtenerArtesanosPorRubro();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const getStandsOcupacionReporte = async (req, res, next) => {
    try {
        const data = await obtenerStandsOcupacion();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const getProductosPorArtesanoReporte = async (req, res, next) => {
    try {
        const data = await obtenerProductosPorArtesano();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};

export const getTendenciasBusquedaReporte = async (req, res, next) => {
    try {
        const data = obtenerTendencias();
        res.status(200).json(data);
    } catch (error) {
        next(error);
    }
};
