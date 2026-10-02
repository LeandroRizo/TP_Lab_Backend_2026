import { productoQuerySchema } from "../schemas/productoQuery.schema.js";

export const validarProductoQuery = (req, res, next) => {
    const resultado = productoQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
