import jwt from "jsonwebtoken";
import config from "../config/env.js";
import { esTokenRevocado } from "../services/auth.service.js";

export const autenticar = async (req, res, next) => {
    try {
        const authHeader = req.headers["authorization"] || req.headers["Authorization"];

        // Criterio 2.4: Sin encabezado -> 401 + header WWW-Authenticate
        if (!authHeader) {
            res.set("WWW-Authenticate", 'Bearer realm="API"');
            return res.status(401).json({
                mensaje: "Encabezado de autorización no proporcionado"
            });
        }

        // Criterio 2.4: Formato incorrecto -> 400
        const partes = authHeader.trim().split(/\s+/);
        if (partes.length !== 2 || partes[0] !== "Bearer" || !partes[1]) {
            return res.status(400).json({
                mensaje: "Formato de token inválido. Debe ser: Bearer <token>"
            });
        }

        const token = partes[1];
        let payload;

        try {
            // Criterio 2.3: jwt.verify con algorithms: ["HS256"]
            payload = jwt.verify(token, config.jwtSecret, {
                algorithms: ["HS256"]
            });
        } catch (jwtError) {
            // Criterio 2.4: Inválido o vencido -> 401
            return res.status(401).json({
                mensaje: "Token inválido o expirado"
            });
        }

        // Criterio 2.3: Valida sub, exp y jti antes de usarlos
        if (!payload.sub || typeof payload.sub !== "string" || !payload.exp || !payload.jti) {
            return res.status(401).json({
                mensaje: "Token no válido: payload incompleto"
            });
        }

        // Criterio 2.4: Revocado -> 401
        const revocado = await esTokenRevocado(payload.jti);
        if (revocado) {
            return res.status(401).json({
                mensaje: "Token revocado"
            });
        }

        // Criterio 2.4 & 2.5: Deja req.usuario con id disponible
        req.usuario = {
            id: payload.sub,
            id_usuario: payload.sub
        };

        // Guardar metadata del token para el cierre de sesión (logout)
        req.tokenInfo = {
            jti: payload.jti,
            exp: payload.exp,
            token
        };

        next();
    } catch (error) {
        // Criterio 2.4: Errores no-JWT -> next(error)
        next(error);
    }
};
