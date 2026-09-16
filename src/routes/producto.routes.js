import express from "express";

import {
    obtenerProductos,
    obtenerProductoPorId,
    crearNuevoProducto,
    actualizarProducto,
    eliminarProducto
} from "../controllers/producto.controller.js";

const router = express.Router();

router.get("/", obtenerProductos);
router.get("/:id", obtenerProductoPorId);
router.post("/", crearNuevoProducto);
router.put("/:id", actualizarProducto);
router.delete("/:id", eliminarProducto);

export default router;