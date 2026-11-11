import express from "express";
import {
    obtenerPabellons,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/pabellon.controller.js";
import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { pabellonSchema } from "../schemas/pabellon.schema.js";
import { pabellonQuerySchema } from "../schemas/pabellonQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(pabellonQuerySchema), obtenerPabellons);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(pabellonSchema, "Los datos de pabellon no son válidos"), crear);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), validarBody(pabellonSchema, "Los datos de pabellon no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idParamSchema), eliminar);

export default router;
