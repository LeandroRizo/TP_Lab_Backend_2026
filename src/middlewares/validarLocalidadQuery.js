import { localidadQuerySchema } from "../schemas/localidadQuery.schema.js";

export const validarLocalidadQuery = (req, res, next) => {
    const resultado = localidadQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
