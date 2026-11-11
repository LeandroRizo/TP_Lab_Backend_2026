import express from "express";
import {
    obtenerRubros,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/rubro.controller.js";
import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { rubroSchema } from "../schemas/rubro.schema.js";
import { rubroQuerySchema } from "../schemas/rubroQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(rubroQuerySchema), obtenerRubros);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(rubroSchema, "Los datos de rubro no son válidos"), crear);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), validarBody(rubroSchema, "Los datos de rubro no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), eliminar);

export default router;
