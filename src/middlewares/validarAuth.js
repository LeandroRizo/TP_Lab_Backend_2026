import { registroSchema, loginSchema, postulacionSchema } from "../schemas/auth.schema.js";
import { registroDTO, loginDTO, postulacionDTO } from "../dtos/auth.dto.js";

// Criterio 1.2: Esquemas Zod aplicados por middleware, dejando el DTO en req para el controlador.
export const validarRegistro = (req, res, next) => {
    const resultado = registroSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de registro no son válidos",
            errores: resultado.error.issues
        });
    }

    const dto = registroDTO(resultado.data);
    req.body = dto;
    req.dto = dto;

    next();
};

export const validarLogin = (req, res, next) => {
    const resultado = loginSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de login no son válidos",
            errores: resultado.error.issues
        });
    }

    const dto = loginDTO(resultado.data);
    req.body = dto;
    req.dto = dto;

    next();
};

// Criterio 6: Validación de postulación
export const validarPostulacion = (req, res, next) => {
    const resultado = postulacionSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de la postulación no son válidos",
            errores: resultado.error.issues
        });
    }

    const dto = postulacionDTO(resultado.data);
    req.body = dto;
    req.dto = dto;

    next();
};
