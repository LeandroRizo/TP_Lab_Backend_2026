import { artesanoQuerySchema } from "../schemas/artesanoQuery.schema.js";

export const validarArtesanoQuery = (req, res, next) => {
    const resultado = artesanoQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
