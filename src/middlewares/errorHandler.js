// Criterio 1.7: Manejador centralizado de errores
export const errorHandler = (err, req, res, next) => {
    // Si la respuesta ya fue enviada, delegar a Express
    if (res.headersSent) {
        return next(err);
    }

    // Errores con statusCode explícito (ej. errores de validación de negocio, 401, 409, etc.)
    if (err.statusCode || err.status) {
        const status = err.statusCode || err.status;
        return res.status(status).json({
            mensaje: err.message || "Error en la petición",
            errores: err.errores || undefined
        });
    }

    // Errores de clave única de Prisma (ej. email repetido en DB)
    if (err.code === "P2002") {
        return res.status(409).json({
            mensaje: "Conflicto: ya existe un registro con esos datos únicos",
            campo: err.meta?.target
        });
    }

    // Registro no encontrado en Prisma
    if (err.code === "P2025") {
        return res.status(404).json({
            mensaje: "Recurso no encontrado"
        });
    }

    // Error interno no controlado
    console.error("Error no controlado capturado en errorHandler:", err);
    return res.status(500).json({
        mensaje: "Error interno del servidor",
        error: process.env.NODE_ENV === "development" ? err.message : undefined
    });
};
