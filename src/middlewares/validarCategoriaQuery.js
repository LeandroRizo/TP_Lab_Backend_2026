import { categoriaQuerySchema } from "../schemas/categoriaQuery.schema.js";

export const validarCategoriaQuery = (req, res, next) => {
    const resultado = categoriaQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
