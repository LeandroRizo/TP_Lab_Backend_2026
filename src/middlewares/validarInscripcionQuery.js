import { inscripcionQuerySchema } from "../schemas/inscripcionQuery.schema.js";

export const validarInscripcionQuery = (req, res, next) => {
    const resultado = inscripcionQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
