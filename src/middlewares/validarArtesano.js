export const validarArtesano = (req, res, next) => {
    const { nombre, apellido, rubro, localidad } = req.body;

    if (
        typeof nombre !== "string" ||
        nombre.trim() === "" ||
        typeof apellido !== "string" ||
        apellido.trim() === "" ||
        typeof rubro !== "string" ||
        rubro.trim() === "" ||
        typeof localidad !== "string" ||
        localidad.trim() === ""
    ) {
        return res.status(400).json({
            mensaje: "Todos los campos del artesano son obligatorios y deben ser textos no vacíos"
        });
    }

    next();
};