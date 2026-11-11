import express from "express";
import {
    obtenerLocalidads,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/localidad.controller.js";
import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { localidadSchema } from "../schemas/localidad.schema.js";
import { localidadQuerySchema } from "../schemas/localidadQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(localidadQuerySchema), obtenerLocalidads);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(localidadSchema, "Los datos de localidad no son válidos"), crear);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), validarBody(localidadSchema, "Los datos de localidad no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), eliminar);

export default router;
