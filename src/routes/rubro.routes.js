import express from "express";
import {
    obtenerRubros,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/rubro.controller.js";
import { validarRubro } from "../middlewares/validarRubro.js";
import { validarRubroQuery } from "../middlewares/validarRubroQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarRubroQuery, obtenerRubros);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarRubro, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarRubro, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
