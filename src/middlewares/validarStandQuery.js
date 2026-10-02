import { standQuerySchema } from "../schemas/standQuery.schema.js";

export const validarStandQuery = (req, res, next) => {
    const resultado = standQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
