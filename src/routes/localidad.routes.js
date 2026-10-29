import express from "express";
import {
    obtenerLocalidads,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/localidad.controller.js";
import { validarLocalidad } from "../middlewares/validarLocalidad.js";
import { validarLocalidadQuery } from "../middlewares/validarLocalidadQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarLocalidadQuery, obtenerLocalidads);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarLocalidad, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarLocalidad, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
