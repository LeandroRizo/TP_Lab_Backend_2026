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

// DTO público de artesano para visitantes (omite datos personales privados: dni, telefono, direccion, id_usuario)
export const artesanoPublicoDTO = (artesano) => {
    if (!artesano) return null;
    const dto = {
        id_artesano: artesano.id_artesano,
        nombre: artesano.nombre,
        apellido: artesano.apellido,
        descripcion: artesano.descripcion ?? null,
        instagram: artesano.instagram ?? null,
        id_localidad: artesano.id_localidad,
        id_rubro: artesano.id_rubro,
        created_at: artesano.created_at,
        updated_at: artesano.updated_at
    };

    if (artesano.localidad !== undefined) {
        dto.localidad = artesano.localidad;
    }
    if (artesano.rubro !== undefined) {
        dto.rubro = artesano.rubro;
    }
    if (artesano.productos !== undefined) {
        dto.productos = artesano.productos;
    }

    return dto;
};
