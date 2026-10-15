// Criterio 1.5: El body no puede fijar rol ni otros campos internos.
export const registroDTO = (datos) => {
    return {
        nombre: datos.nombre,
        email: datos.email,
        password: datos.password
    };
};

export const loginDTO = (datos) => {
    return {
        email: datos.email,
        password: datos.password
    };
};

// Criterio 1.4: Respuestas sin datos sensibles (solo campos públicos)
export const usuarioPublicoDTO = (usuario) => {
    if (!usuario) return null;
    return {
        id_usuario: usuario.id_usuario,
        nombre: usuario.nombre,
        email: usuario.email,
        id_rol: usuario.id_rol,
        created_at: usuario.created_at,
        updated_at: usuario.updated_at,
        rol: usuario.rol ? {
            id_rol: usuario.rol.id_rol,
            nombre: usuario.rol.nombre,
            descripcion: usuario.rol.descripcion
        } : undefined
    };
};
