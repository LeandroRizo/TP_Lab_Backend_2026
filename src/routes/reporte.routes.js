import express from "express";
import {
    getReporteGeneral,
    getArtesanosPorLocalidadReporte,
    getArtesanosPorRubroReporte,
    getStandsOcupacionReporte,
    getProductosPorArtesanoReporte,
    getTendenciasBusquedaReporte
} from "../controllers/reporte.controller.js";

import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Todos los reportes son administrativos (Solo ADMINISTRADOR)
// Orden: autenticación → cuenta → rol → controlador
router.use(autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"));

router.get("/", getReporteGeneral);
router.get("/general", getReporteGeneral);
router.get("/artesanos-por-localidad", getArtesanosPorLocalidadReporte);
router.get("/artesanos-por-rubro", getArtesanosPorRubroReporte);
router.get("/stands-ocupacion", getStandsOcupacionReporte);
router.get("/productos-por-artesano", getProductosPorArtesanoReporte);
router.get("/tendencias-busqueda", getTendenciasBusquedaReporte);

export default router;
