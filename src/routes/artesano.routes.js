import express from "express";

import {
    obtenerArtesanos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/artesano.controller.js";

const router = express.Router();

router.get("/", obtenerArtesanos);
router.post("/", crear);
router.get("/:id", obtenerPorId);
router.put("/:id", actualizar);
router.delete("/:id", eliminar);

export default router;