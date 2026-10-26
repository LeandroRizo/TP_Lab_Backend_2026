import { crearAdminSchema, estadoCuentaSchema } from "../schemas/cuenta.schema.js";

// Criterio 7: Validación de creación de administradores y estado de cuenta
export const validarCrearAdmin = (req, res, next) => {
    const resultado = crearAdminSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos para crear el administrador no son válidos",
            errores: resultado.error.issues
        });
    }

    req.body = resultado.data;
    next();
};

export const validarEstadoCuenta = (req, res, next) => {
    const resultado = estadoCuentaSchema.safeParse(req.body);

    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "El estado de la cuenta debe contener un booleano 'activo' válido",
            errores: resultado.error.issues
        });
    }

    req.body = resultado.data;
    next();
};
