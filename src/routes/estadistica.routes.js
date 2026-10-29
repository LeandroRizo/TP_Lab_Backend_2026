import express from "express";
import { obtenerTendencias } from "../services/estadisticas.service.js";

const router = express.Router();

// Estadísticas públicas de tendencias de búsqueda de visitantes
router.get("/tendencias", (req, res) => {
    const tendencias = obtenerTendencias();
    res.status(200).json(tendencias);
});

export default router;
