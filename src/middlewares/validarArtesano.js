import { artesanoSchema } from "../schemas/artesano.schema.js";
import { crearArtesanoDTO } from "../dtos/artesano.dto.js";

export const validarArtesano = (req, res, next) => {
    const resultado = artesanoSchema.safeParse(req.body);
    if (!resultado.success) {
        return res.status(400).json({
            mensaje: "Los datos de artesano no son válidos",
            errores: resultado.error.issues
        });
    }
    req.body = crearArtesanoDTO(resultado.data);
    next();
};
