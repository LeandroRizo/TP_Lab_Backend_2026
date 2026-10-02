export const artesanoQueryDTO = (datos) => {
    return {
        nombre: datos.nombre,
        apellido: datos.apellido,
        dni: datos.dni,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
