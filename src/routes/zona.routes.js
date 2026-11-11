import express from "express";
import {
    obtenerZonas,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/zona.controller.js";
import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { zonaSchema } from "../schemas/zona.schema.js";
import { zonaQuerySchema } from "../schemas/zonaQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(zonaQuerySchema), obtenerZonas);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(zonaSchema, "Los datos de zona no son válidos"), crear);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), validarBody(zonaSchema, "Los datos de zona no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), eliminar);

export default router;
