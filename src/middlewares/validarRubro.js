import { rubroSchema } from "../schemas/rubro.schema.js";
import { crearRubroDTO } from "../dtos/rubro.dto.js";

export const validarRubro = (req, res, next) => {
    const resultado = rubroSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de rubro no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearRubroDTO(resultado.data);
    next();
};
