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

import { validarStand } from "../middlewares/validarStand.js";
import { validarStandQuery } from "../middlewares/validarStandQuery.js";
import { validarAsignarStand } from "../middlewares/validarSolicitud.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";
import { registroConsultas } from "../middlewares/registroConsultas.js";

const router = express.Router();

// Criterio 4: Consultas GET públicas
router.get("/", registroConsultas("stands"), validarStandQuery, obtenerStands);
router.get("/ubicacion", obtenerUbicaciones);
router.get("/:id/ubicacion", obtenerUbicacionPorId);
router.get("/:id", obtenerPorId);

// Criterio 4: Solo ADMINISTRADOR: alta, modificación y baja de stands; asignación artesano–stand
// Criterio 3: Orden: autenticación → cuenta → rol → validación → controlador
router.post(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarStand,
    crear
);

router.put(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarStand,
    actualizar
);

router.delete(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    eliminar
);

// Criterio 4: Asignación artesano–stand
router.post(
    "/asignar",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarAsignarStand,
    asignarArtesano
);

router.put(
    "/:id/asignar",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarAsignarStand,
    asignarArtesano
);

export default router;
