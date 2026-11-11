/**
 * Middleware reutilizable para validar el cuerpo de la petición (req.body) con un esquema Zod.
 * Asigna los datos validados y transformados en req.body y req.bodyValidado.
 */
export const validarBody = (schema, mensaje = "Los datos enviados no son válidos") => {
    return (req, res, next) => {
        const resultado = schema.safeParse(req.body);

        if (!resultado.success) {
            return res.status(400).json({
                mensaje,
                errores: resultado.error.issues
            });
        }

        req.body = resultado.data;
        req.bodyValidado = resultado.data;
        next();
    };
};

/**
 * Middleware reutilizable para validar parámetros de consulta (req.query) con un esquema Zod.
 * Asigna los filtros y paginación validados en req.queryValidada.
 */
export const validarQuery = (schema, mensaje = "Los parámetros de consulta no son válidos") => {
    return (req, res, next) => {
        const resultado = schema.safeParse(req.query);

        if (!resultado.success) {
            return res.status(400).json({
                mensaje,
                errores: resultado.error.issues
            });
        }

        req.queryValidada = resultado.data;
        next();
    };
};

/**
 * Middleware reutilizable para validar parámetros de ruta (req.params) con un esquema Zod.
 * Asigna los parámetros validados y transformados en req.params y req.paramsValidados.
 */
export const validarParams = (schema, mensaje = "Los parámetros de ruta no son válidos") => {
    return (req, res, next) => {
        const resultado = schema.safeParse(req.params);

        if (!resultado.success) {
            return res.status(400).json({
                mensaje,
                errores: resultado.error.issues
            });
        }

        req.params = resultado.data;
        req.paramsValidados = resultado.data;
        next();
    };
};
