import express from "express";
import {
    obtenerProductos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/producto.controller.js";
import { validarProducto } from "../middlewares/validarProducto.js";
import { validarProductoQuery } from "../middlewares/validarProductoQuery.js";

const router = express.Router();

router.get("/", validarProductoQuery, obtenerProductos);
router.post("/", validarProducto, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarProducto, actualizar);
router.delete("/:id", eliminar);

export default router;
