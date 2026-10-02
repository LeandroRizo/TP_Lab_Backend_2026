import { rolQuerySchema } from "../schemas/rolQuery.schema.js";

export const validarRolQuery = (req, res, next) => {
    const resultado = rolQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
