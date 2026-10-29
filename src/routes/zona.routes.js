import express from "express";
import {
    obtenerZonas,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/zona.controller.js";
import { validarZona } from "../middlewares/validarZona.js";
import { validarZonaQuery } from "../middlewares/validarZonaQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarZonaQuery, obtenerZonas);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarZona, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarZona, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
