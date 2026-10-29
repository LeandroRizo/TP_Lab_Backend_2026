export const artesanoQueryDTO = (datos) => {
    return {
        nombre: datos.nombre,
        apellido: datos.apellido,
        dni: datos.dni,
        id_localidad: datos.id_localidad,
        id_rubro: datos.id_rubro,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
