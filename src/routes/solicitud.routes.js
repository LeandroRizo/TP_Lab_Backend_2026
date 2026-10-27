import express from "express";
import {
    obtenerSolicitudes,
    obtenerPorId,
    resolver
} from "../controllers/solicitud.controller.js";
import { postularse } from "../controllers/auth.controller.js";

import { validarResolverSolicitud, validarSolicitudQuery } from "../middlewares/validarSolicitud.js";
import { validarPostulacion } from "../middlewares/validarAuth.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4 & 6: Postulación pública
router.post("/postulacion", validarPostulacion, postularse);

// Criterio 4: Solo ADMINISTRADOR: listado y resolución de solicitudes
// Criterio 3: Orden: autenticación → cuenta → rol → validación → controlador
router.get(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarSolicitudQuery,
    obtenerSolicitudes
);

router.get(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    obtenerPorId
);

router.put(
    "/:id/resolver",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarResolverSolicitud,
    resolver
);

router.patch(
    "/:id/resolver",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarResolverSolicitud,
    resolver
);

export default router;
