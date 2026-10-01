export const crearArtesanoDTO = (datos) => {
    return {
        nombre: datos.nombre,
        apellido: datos.apellido,
        rubro: datos.rubro,
        localidad: datos.localidad
    };
};