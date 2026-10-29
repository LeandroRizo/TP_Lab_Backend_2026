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
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarCategoriaQuery, obtenerCategorias);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarCategoria, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarCategoria, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
