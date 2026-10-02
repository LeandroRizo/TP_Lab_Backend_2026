import express from "express";
import {
    obtenerZonas,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/zona.controller.js";
import { validarZona } from "../middlewares/validarZona.js";
import { validarZonaQuery } from "../middlewares/validarZonaQuery.js";

const router = express.Router();

router.get("/", validarZonaQuery, obtenerZonas);
router.post("/", validarZona, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarZona, actualizar);
router.delete("/:id", eliminar);

export default router;
