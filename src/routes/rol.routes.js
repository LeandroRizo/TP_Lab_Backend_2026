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

const router = express.Router();

router.get("/", validarRolQuery, obtenerRols);
router.post("/", validarRol, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarRol, actualizar);
router.delete("/:id", eliminar);

export default router;
