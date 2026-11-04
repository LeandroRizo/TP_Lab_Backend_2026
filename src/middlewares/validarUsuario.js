import { usuarioSchema, usuarioActualizarSchema } from "../schemas/usuario.schema.js";
import { crearUsuarioDTO } from "../dtos/usuario.dto.js";

export const validarUsuario = (req, res, next) => {
    const esModificacion = req.method === "PUT" || req.method === "PATCH";
    const schema = esModificacion ? usuarioActualizarSchema : usuarioSchema;

    const resultado = schema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de usuario no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearUsuarioDTO(resultado.data);
    next();
};
