import { zonaQuerySchema } from "../schemas/zonaQuery.schema.js";

export const validarZonaQuery = (req, res, next) => {
    const resultado = zonaQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
