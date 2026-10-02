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

const router = express.Router();

router.get("/", validarLocalidadQuery, obtenerLocalidads);
router.post("/", validarLocalidad, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarLocalidad, actualizar);
router.delete("/:id", eliminar);

export default router;
