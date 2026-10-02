import { usuarioQuerySchema } from "../schemas/usuarioQuery.schema.js";

export const validarUsuarioQuery = (req, res, next) => {
    const resultado = usuarioQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
