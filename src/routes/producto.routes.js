import express from "express";
import {
    obtenerProductos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar,
    obtenerMisProductos
} from "../controllers/producto.controller.js";

import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { productoSchema, productoActualizarSchema } from "../schemas/producto.schema.js";
import { productoQuerySchema } from "../schemas/productoQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4: Consultas GET públicas
router.get("/", validarQuery(productoQuerySchema), obtenerProductos);

// Criterio 5: Listado propio sin parámetros del cliente (Solo ARTESANO)
// Orden en la ruta: autenticación → cuenta → rol → controlador
router.get("/mis-productos", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);
router.get("/propios", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);
router.get("/me", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), obtenerMisProductos);

// Criterio 4: Consulta por ID pública
router.get("/:id", validarParams(idParamSchema), obtenerPorId);

// Criterio 4 & 5: Solo ARTESANO: alta, modificación y baja de productos
// Orden en la ruta: autenticación → cuenta → rol → validación → controlador
router.post("/", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarBody(productoSchema, "Los datos de producto no son válidos"), crear);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarParams(idParamSchema), validarBody(productoActualizarSchema, "Los datos de producto no son válidos"), actualizar);
router.patch("/:id", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarParams(idParamSchema), validarBody(productoActualizarSchema, "Los datos de producto no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ARTESANO"), validarParams(idParamSchema), eliminar);

export default router;
