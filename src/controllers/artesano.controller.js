import {
    getArtesanos,
    crearArtesano,
    getArtesanoById,
    actualizarArtesano,
    eliminarArtesano
} from "../services/artesano.service.js";

export const obtenerArtesanos = async (req, res) => {
    const artesanos = await getArtesanos();

    res.status(200).json(artesanos);
};

export const crear = async (req, res) => {
    const nuevoArtesano = await crearArtesano(req.body);

    res.status(201).json(nuevoArtesano);
};

export const obtenerPorId = async (req, res) => {
    const artesano = await getArtesanoById(req.params.id);

    if (!artesano) {
        return res.status(404).json({
            mensaje: "Artesano no encontrado"
        });
    }

    res.status(200).json(artesano);
};

export const actualizar = async (req, res) => {
    const artesano = await actualizarArtesano(req.params.id, req.body);

    res.status(200).json(artesano);
};

export const eliminar = async (req, res) => {
    await eliminarArtesano(req.params.id);

    res.status(204).send();
};