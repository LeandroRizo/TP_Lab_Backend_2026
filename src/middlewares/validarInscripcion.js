import { inscripcionSchema } from "../schemas/inscripcion.schema.js";
import { crearInscripcionDTO } from "../dtos/inscripcion.dto.js";

export const validarInscripcion = (req, res, next) => {
    const resultado = inscripcionSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de inscripcion no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearInscripcionDTO(resultado.data);
    next();
};
