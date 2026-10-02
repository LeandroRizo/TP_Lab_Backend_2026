import { zonaSchema } from "../schemas/zona.schema.js";
import { crearZonaDTO } from "../dtos/zona.dto.js";

export const validarZona = (req, res, next) => {
    const resultado = zonaSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de zona no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearZonaDTO(resultado.data);
    next();
};
