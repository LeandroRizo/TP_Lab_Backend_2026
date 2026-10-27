import express from "express";
import {
    obtenerInscripcions,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/inscripcion.controller.js";
import { asignarArtesano } from "../controllers/stand.controller.js";

import { validarInscripcion } from "../middlewares/validarInscripcion.js";
import { validarInscripcionQuery } from "../middlewares/validarInscripcionQuery.js";
import { validarAsignarStand } from "../middlewares/validarSolicitud.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarInscripcionQuery, obtenerInscripcions);
router.get("/:id", obtenerPorId);

// Criterio 4: Solo ADMINISTRADOR
router.post(
    "/asignar-stand",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarAsignarStand,
    asignarArtesano
);

router.post(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarInscripcion,
    crear
);

router.put(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarInscripcion,
    actualizar
);

router.delete(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    eliminar
);

export default router;
