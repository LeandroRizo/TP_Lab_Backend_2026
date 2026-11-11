import express from "express";
import {
    obtenerCategorias,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/categoria.controller.js";
import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { categoriaSchema } from "../schemas/categoria.schema.js";
import { categoriaQuerySchema } from "../schemas/categoriaQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(categoriaQuerySchema), obtenerCategorias);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(categoriaSchema, "Los datos de categoria no son válidos"), crear);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), validarBody(categoriaSchema, "Los datos de categoria no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), eliminar);

export default router;
