import { productoSchema } from "../schemas/producto.schema.js";
import { crearProductoDTO } from "../dtos/producto.dto.js";

export const validarProducto = (req, res, next) => {
    const resultado = productoSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de producto no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearProductoDTO(resultado.data);
    next();
};
