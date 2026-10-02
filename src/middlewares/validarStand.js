import { standSchema } from "../schemas/stand.schema.js";
import { crearStandDTO } from "../dtos/stand.dto.js";

export const validarStand = (req, res, next) => {
    const resultado = standSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de stand no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearStandDTO(resultado.data);
    next();
};
