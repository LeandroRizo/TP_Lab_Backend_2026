export const pabellonQueryDTO = (datos) => {
    return {
        nombre: datos.nombre,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
