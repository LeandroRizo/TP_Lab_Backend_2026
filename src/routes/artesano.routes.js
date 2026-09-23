import express from "express";

import {
    obtenerArtesanos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/artesano.controller.js";

import { validarArtesano } from "../middlewares/validarArtesano.js";

const router = express.Router();

router.get("/", obtenerArtesanos);
router.post("/", validarArtesano, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarArtesano, actualizar);
router.delete("/:id", eliminar);

export default router;