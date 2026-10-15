export const crearUsuarioDTO = (datos) => {
    return {
        nombre: datos.nombre,
        email: datos.email,
        passwordHash: datos.passwordHash,
        id_rol: datos.id_rol
    };
};
