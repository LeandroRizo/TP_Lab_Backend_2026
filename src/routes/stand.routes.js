import express from "express";
import {
    obtenerStands,
    crear,
    obtenerPorId,
    actualizar,
    eliminar
} from "../controllers/stand.controller.js";
import { validarStand } from "../middlewares/validarStand.js";
import { validarStandQuery } from "../middlewares/validarStandQuery.js";

const router = express.Router();

router.get("/", validarStandQuery, obtenerStands);
router.post("/", validarStand, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarStand, actualizar);
router.delete("/:id", eliminar);

export default router;
