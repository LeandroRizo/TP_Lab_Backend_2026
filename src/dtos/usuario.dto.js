export const crearUsuarioDTO = (datos) => {
    return {
        email: datos.email,
        passwordHash: datos.passwordHash,
        id_rol: datos.id_rol
    };
};
