import { pabellonSchema } from "../schemas/pabellon.schema.js";
import { crearPabellonDTO } from "../dtos/pabellon.dto.js";

export const validarPabellon = (req, res, next) => {
    const resultado = pabellonSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de pabellon no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearPabellonDTO(resultado.data);
    next();
};
