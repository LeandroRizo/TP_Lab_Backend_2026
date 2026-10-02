import express from "express";
import {
    obtenerCategorias,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/categoria.controller.js";
import { validarCategoria } from "../middlewares/validarCategoria.js";
import { validarCategoriaQuery } from "../middlewares/validarCategoriaQuery.js";

const router = express.Router();

router.get("/", validarCategoriaQuery, obtenerCategorias);
router.post("/", validarCategoria, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarCategoria, actualizar);
router.delete("/:id", eliminar);

export default router;
