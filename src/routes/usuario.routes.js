import express from "express";
import {
    obtenerUsuarios,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/usuario.controller.js";
import { validarUsuario } from "../middlewares/validarUsuario.js";
import { validarUsuarioQuery } from "../middlewares/validarUsuarioQuery.js";

const router = express.Router();

router.get("/", validarUsuarioQuery, obtenerUsuarios);
router.post("/", validarUsuario, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarUsuario, actualizar);
router.delete("/:id", eliminar);

export default router;
