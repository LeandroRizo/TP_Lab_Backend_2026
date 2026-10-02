import express from "express";
import {
    obtenerInscripcions,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/inscripcion.controller.js";
import { validarInscripcion } from "../middlewares/validarInscripcion.js";
import { validarInscripcionQuery } from "../middlewares/validarInscripcionQuery.js";

const router = express.Router();

router.get("/", validarInscripcionQuery, obtenerInscripcions);
router.post("/", validarInscripcion, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarInscripcion, actualizar);
router.delete("/:id", eliminar);

export default router;
