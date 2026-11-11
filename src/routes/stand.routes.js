import express from "express";
import {
    obtenerStands,
    crear,
    obtenerPorId,
    actualizar,
    eliminar,
    asignarArtesano,
    obtenerUbicaciones,
    obtenerUbicacionPorId
} from "../controllers/stand.controller.js";

import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { standSchema } from "../schemas/stand.schema.js";
import { standQuerySchema } from "../schemas/standQuery.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { asignarStandSchema } from "../schemas/solicitud.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4: Consultas GET públicas
router.get("/", validarQuery(standQuerySchema), obtenerStands);
router.get("/ubicacion", obtenerUbicaciones);
router.get("/:id/ubicacion", validarParams(idParamSchema), obtenerUbicacionPorId);
router.get("/:id", validarParams(idParamSchema), obtenerPorId);

// Criterio 4: Solo ADMINISTRADOR: alta, modificación y baja de stands; asignación artesano–stand
// Criterio 3: Orden: autenticación → cuenta → rol → validación → controlador
router.post(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarBody(standSchema, "Los datos de stand no son válidos"),
    crear
);

router.put(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    validarBody(standSchema, "Los datos de stand no son válidos"),
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

// Criterio 4: Asignación artesano–stand
router.post(
    "/asignar",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarBody(asignarStandSchema, "Los datos para la asignación de stand no son válidos"),
    asignarArtesano
);

router.put(
    "/:id/asignar",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    validarBody(asignarStandSchema, "Los datos para la asignación de stand no son válidos"),
    asignarArtesano
);

export default router;
