import { localidadSchema } from "../schemas/localidad.schema.js";
import { crearLocalidadDTO } from "../dtos/localidad.dto.js";

export const validarLocalidad = (req, res, next) => {
    const resultado = localidadSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de localidad no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearLocalidadDTO(resultado.data);
    next();
};
