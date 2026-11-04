export const crearUsuarioDTO = (datos) => {
    const dto = {
        nombre: datos.nombre,
        email: datos.email
    };
    if (datos.password !== undefined) dto.password = datos.password;
    if (datos.id_rol !== undefined) dto.id_rol = datos.id_rol;
    if (datos.activo !== undefined) dto.activo = datos.activo;
    return dto;
};
