import { pabellonQuerySchema } from "../schemas/pabellonQuery.schema.js";

export const validarPabellonQuery = (req, res, next) => {
    const resultado = pabellonQuerySchema.safeParse(req.query);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los parámetros de consulta no son válidos",
            errores: resultado.error.issues
        });
    }
    req.queryValidada = resultado.data;
    next();
};
