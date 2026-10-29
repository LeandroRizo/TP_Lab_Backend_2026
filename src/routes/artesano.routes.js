import express from "express";
import {
    obtenerArtesanos,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/artesano.controller.js";
import { validarArtesano } from "../middlewares/validarArtesano.js";
import { validarArtesanoQuery } from "../middlewares/validarArtesanoQuery.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";
import { registroConsultas } from "../middlewares/registroConsultas.js";

const router = express.Router();

router.get("/", registroConsultas("artesanos"), validarArtesanoQuery, obtenerArtesanos);
router.post("/", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarArtesano, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), validarArtesano, actualizar);
router.delete("/:id", autenticar, contextoUsuario, autorizarRoles("ADMINISTRADOR"), eliminar);

export default router;
