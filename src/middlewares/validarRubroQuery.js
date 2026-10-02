import { rubroQuerySchema } from "../schemas/rubroQuery.schema.js";

export const validarRubroQuery = (req, res, next) => {
    const resultado = rubroQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
