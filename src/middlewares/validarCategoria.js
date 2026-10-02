import { categoriaSchema } from "../schemas/categoria.schema.js";
import { crearCategoriaDTO } from "../dtos/categoria.dto.js";

export const validarCategoria = (req, res, next) => {
    const resultado = categoriaSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de categoria no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearCategoriaDTO(resultado.data);
    next();
};
