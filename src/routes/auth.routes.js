import express from "express";
import {
    registrar,
    login,
    obtenerMe,
    logout,
    postularse
} from "../controllers/auth.controller.js";
import { validarRegistro, validarLogin, validarPostulacion } from "../middlewares/validarAuth.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";

const router = express.Router();

// Criterio 1.2: Validación de entrada aplicada por middleware
// Criterio 2.5: Registro y login siguen públicos
router.post("/register", validarRegistro, registrar);
router.post("/login", validarLogin, login);

// Criterio 4 & 6: Postulación pública
router.post("/postulacion", validarPostulacion, postularse);

// Criterio 2.5: Ruta protegida GET /me con middleware de autenticación
router.get("/me", autenticar, contextoUsuario, obtenerMe);

// Criterio 2.6: Cierre de sesión POST /logout
router.post("/logout", autenticar, logout);

export default router;
