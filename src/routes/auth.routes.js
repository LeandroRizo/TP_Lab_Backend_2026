import express from "express";
import {
    registrar,
    login,
    obtenerMe,
    logout,
    postularse
} from "../controllers/auth.controller.js";
import { validarBody } from "../middlewares/validar.middleware.js";
import { registroSchema, loginSchema, postulacionSchema } from "../schemas/auth.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";

const router = express.Router();

// Criterio 1.2: Validación de entrada aplicada por middleware
// Criterio 2.5: Registro y login siguen públicos
router.post("/register", validarBody(registroSchema, "Los datos de registro no son válidos"), registrar);
router.post("/login", validarBody(loginSchema, "Los datos de inicio de sesión no son válidos"), login);

// Criterio 4 & 6: Postulación pública
router.post("/postulacion", validarBody(postulacionSchema, "Los datos de postulación no son válidos"), postularse);

// Criterio 2.5: Ruta protegida GET /me con middleware de autenticación
router.get("/me", autenticar, contextoUsuario, obtenerMe);

// Criterio 2.6: Cierre de sesión POST /logout
router.post("/logout", autenticar, logout);

export default router;
