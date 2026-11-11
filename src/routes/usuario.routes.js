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

import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { usuarioSchema, usuarioActualizarSchema } from "../schemas/usuario.schema.js";
import { usuarioQuerySchema } from "../schemas/usuarioQuery.schema.js";
import { idUsuarioParamSchema } from "../schemas/param.schema.js";
import { crearAdminSchema, estadoCuentaSchema } from "../schemas/cuenta.schema.js";
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
    validarBody(crearAdminSchema, "Los datos para crear administrador no son válidos"),
    crearAdmin
);

router.post(
    "/admin",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarBody(crearAdminSchema, "Los datos para crear administrador no son válidos"),
    crearAdmin
);

router.patch(
    "/:id/estado",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idUsuarioParamSchema),
    validarBody(estadoCuentaSchema, "El estado de la cuenta debe indicarse con un valor booleano en el campo activo"),
    cambiarEstado
);

router.put(
    "/:id/estado",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idUsuarioParamSchema),
    validarBody(estadoCuentaSchema, "El estado de la cuenta debe indicarse con un valor booleano en el campo activo"),
    cambiarEstado
);

router.patch(
    "/:id/activo",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idUsuarioParamSchema),
    validarBody(estadoCuentaSchema, "El estado de la cuenta debe indicarse con un valor booleano en el campo activo"),
    cambiarEstado
);

// Endpoints generales de usuarios protegidos para ADMINISTRADOR
router.get("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarQuery(usuarioQuerySchema), obtenerUsuarios);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarBody(usuarioSchema, "Los datos de usuario no son válidos"), crear);
router.get("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idUsuarioParamSchema), obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idUsuarioParamSchema), validarBody(usuarioActualizarSchema, "Los datos de usuario no son válidos"), actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarParams(idUsuarioParamSchema), eliminar);

export default router;
