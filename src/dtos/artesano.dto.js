export const crearArtesanoDTO = (datos) => {
    return {
        id_usuario: datos.id_usuario,
        nombre: datos.nombre,
        apellido: datos.apellido,
        dni: datos.dni,
        telefono: datos.telefono,
        direccion: datos.direccion,
        descripcion: datos.descripcion,
        instagram: datos.instagram,
        id_localidad: datos.id_localidad,
        id_rubro: datos.id_rubro
    };
};
