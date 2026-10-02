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

const router = express.Router();

router.get("/", validarRubroQuery, obtenerRubros);
router.post("/", validarRubro, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarRubro, actualizar);
router.delete("/:id", eliminar);

export default router;
