import express from "express";
import {
    obtenerRols,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/rol.controller.js";
import { validarRol } from "../middlewares/validarRol.js";
import { validarRolQuery } from "../middlewares/validarRolQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarRolQuery, obtenerRols);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarRol, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarRol, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
