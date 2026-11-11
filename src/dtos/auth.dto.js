// Criterio 1.4: Respuestas sin datos sensibles (solo campos públicos, omitiendo passwordHash)
export const usuarioPublicoDTO = (usuario) => {
    if (!usuario) return null;
    return {
        id_usuario: usuario.id_usuario,
        nombre: usuario.nombre,
        email: usuario.email,
        id_rol: usuario.id_rol,
        activo: usuario.activo,
        created_at: usuario.created_at,
        updated_at: usuario.updated_at,
        rol: usuario.rol ? {
            id_rol: usuario.rol.id_rol,
            nombre: usuario.rol.nombre,
            descripcion: usuario.rol.descripcion
        } : undefined,
        artesano: usuario.artesano ? {
            id_artesano: usuario.artesano.id_artesano,
            nombre: usuario.artesano.nombre,
            apellido: usuario.artesano.apellido,
            dni: usuario.artesano.dni
        } : undefined
    };
};
