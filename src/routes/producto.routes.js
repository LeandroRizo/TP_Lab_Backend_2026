import express from "express";
import {
    obtenerProductos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar,
    obtenerMisProductos
} from "../controllers/producto.controller.js";

import { validarProducto } from "../middlewares/validarProducto.js";
import { validarProductoQuery } from "../middlewares/validarProductoQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4: Consultas GET públicas
router.get("/", validarProductoQuery, obtenerProductos);

// Criterio 5: Listado propio sin parámetros del cliente (Solo ARTESANO)
// Orden en la ruta: autenticación → cuenta → rol → controlador
router.get("/mis-productos", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);
router.get("/propios", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);
router.get("/me", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);

// Criterio 4: Consulta por ID pública
router.get("/:id", obtenerPorId);

// Criterio 4 & 5: Solo ARTESANO: alta, modificación y baja de productos
// Orden en la ruta: autenticación → cuenta → rol → validación → controlador
router.post("/", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarProducto, crear);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarProducto, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), eliminar);

export default router;
