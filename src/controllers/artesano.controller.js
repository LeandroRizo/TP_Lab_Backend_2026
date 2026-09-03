import { getArtesanos, crearArtesano } from "../services/artesano.service.js";

export const obtenerArtesanos = (req, res) => {
    const artesanos = getArtesanos();

    res.status(200).json(artesanos);
};

export const crear = (req, res) => {
    const nuevoArtesano = crearArtesano(req.body);

    res.status(201).json(nuevoArtesano);
};