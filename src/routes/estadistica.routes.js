import express from "express";
import { obtenerTendencias } from "../services/estadisticas.service.js";

const router = express.Router();

// Estadísticas públicas de tendencias de búsqueda de visitantes
router.get("/tendencias", (req, res) => {
    /*
        #swagger.tags = ['Estadísticas']
        #swagger.summary = 'Consultar estadísticas públicas de intereses y tendencias de búsqueda de visitantes'
        #swagger.security = []
        #swagger.responses[200] = {
            description: 'Tendencias de términos buscados y consultas por entidad'
        }
    */
    const tendencias = obtenerTendencias();
    res.status(200).json(tendencias);
});

export default router;
