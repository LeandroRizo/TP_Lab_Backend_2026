import express from "express";
import {
    obtenerUsuarios,
    crear,
    obtenerPorId,
    actualizar,
    eliminar,
    crearAdmin,
    cambiarEstado
} from "../controllers/usuario.controller.js";

import { validarUsuario } from "../middlewares/validarUsuario.js";
import { validarUsuarioQuery } from "../middlewares/validarUsuarioQuery.js";
import { validarCrearAdmin, validarEstadoCuenta } from "../middlewares/validarCuenta.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4 & 7: Gestión de cuentas (Solo ADMINISTRADOR)
// Criterio 3: Orden: autenticación → cuenta → rol → validación → controlador
router.post(
    "/administrador",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarCrearAdmin,
    crearAdmin
);

router.post(
    "/admin",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarCrearAdmin,
    crearAdmin
);

router.patch(
    "/:id/estado",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarEstadoCuenta,
    cambiarEstado
);

router.put(
    "/:id/estado",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarEstadoCuenta,
    cambiarEstado
);

router.patch(
    "/:id/activo",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarEstadoCuenta,
    cambiarEstado
);

// Endpoints generales de usuarios protegidos para ADMINISTRADOR
router.get("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarUsuarioQuery, obtenerUsuarios);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarUsuario, crear);
router.get("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarUsuario, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
