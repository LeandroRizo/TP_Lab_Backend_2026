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

const router = express.Router();

router.get("/", validarPabellonQuery, obtenerPabellons);
router.post("/", validarPabellon, crear);
router.get("/:id", obtenerPorId);
router.put("/:id", validarPabellon, actualizar);
router.delete("/:id", eliminar);

export default router;
