import express from "express";
import {
    obtenerInscripcions,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/inscripcion.controller.js";
import { asignarArtesano } from "../controllers/stand.controller.js";

import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { inscripcionSchema } from "../schemas/inscripcion.schema.js";
import { inscripcionQuerySchema } from "../schemas/inscripcionQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { asignarStandSchema } from "../schemas/solicitud.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarQuery(inscripcionQuerySchema), obtenerInscripcions);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);

// Criterio 4: Solo ADMINISTRADOR
router.post(
    "/asignar-stand",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarBody(asignarStandSchema, "Los datos para la asignación de stand no son válidos"),
    asignarArtesano
);

router.post(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarBody(inscripcionSchema, "Los datos de inscripcion no son válidos"),
    crear
);

router.put(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    validarBody(inscripcionSchema, "Los datos de inscripcion no son válidos"),
    actualizar
);

router.delete(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    eliminar
);

export default router;
