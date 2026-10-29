import { productoSchema, productoActualizarSchema } from "../schemas/producto.schema.js";
import { crearProductoDTO } from "../dtos/producto.dto.js";

export const validarProducto = (req, res, next) => {
    const esModificacion = req.method === "PUT" || req.method === "PATCH";
    const schema = esModificacion ? productoActualizarSchema : productoSchema;

    const resultado = schema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de producto no son válidos",
            errores: resultado.error.issues
        });
    }

    if (esModificacion) {
        req.body = resultado.data;
    } else {
        req.body = crearProductoDTO(resultado.data);
    }
    next();
};
