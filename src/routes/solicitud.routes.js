import express from "express";
import {
    obtenerSolicitudes,
    obtenerPorId,
    resolver
} from "../controllers/solicitud.controller.js";
import { postularse } from "../controllers/auth.controller.js";

import { validarBody, validarQuery, validarParams } from "../middlewares/validar.middleware.js";
import { resolverSolicitudSchema, solicitudQuerySchema } from "../schemas/solicitud.schema.js";
import { postulacionSchema } from "../schemas/auth.schema.js";
import { idParamSchema } from "../schemas/param.schema.js";
import { autenticar } from "../middlewares/auth.middleware.js";
import { contextoUsuario } from "../middlewares/contextoUsuario.js";
import { autorizarRoles } from "../middlewares/autorizarRoles.js";

const router = express.Router();

// Criterio 4 & 6: Postulación pública
router.post("/postulacion", validarBody(postulacionSchema, "Los datos de postulación no son válidos"), postularse);

// Criterio 4: Solo ADMINISTRADOR: listado y resolución de solicitudes
// Criterio 3: Orden: autenticación → cuenta → rol → validación → controlador
router.get(
    "/",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarQuery(solicitudQuerySchema),
    obtenerSolicitudes
);

router.get(
    "/:id",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    obtenerPorId
);

router.put(
    "/:id/resolver",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    validarBody(resolverSolicitudSchema, "Los datos de resolución de la solicitud no son válidos"),
    resolver
);

router.patch(
    "/:id/resolver",
    autenticar,
    contextoUsuario,
    autorizarRoles("ADMINISTRADOR"),
    validarParams(idParamSchema),
    validarBody(resolverSolicitudSchema, "Los datos de resolución de la solicitud no son válidos"),
    resolver
);

export default router;
