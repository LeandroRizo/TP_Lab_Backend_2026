import express from "express";
import {
    obtenerArtesanos,
    crear
} from "../controllers/artesano.controller.js";

const router = express.Router();

router.get("/", obtenerArtesanos);
router.post("/", crear);

export default router;