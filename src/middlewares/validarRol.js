import { rolSchema } from "../schemas/rol.schema.js";
import { crearRolDTO } from "../dtos/rol.dto.js";

export const validarRol = (req, res, next) => {
    const resultado = rolSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de rol no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearRolDTO(resultado.data);
    next();
};
