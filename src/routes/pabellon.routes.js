import express from "express";
import {
    obtenerPabellons,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/pabellon.controller.js";
import { validarPabellon } from "../middlewares/validarPabellon.js";
import { validarPabellonQuery } from "../middlewares/validarPabellonQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

router.get("/", validarPabellonQuery, obtenerPabellons);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarPabellon, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarPabellon, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
