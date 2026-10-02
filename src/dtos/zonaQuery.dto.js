export const zonaQueryDTO = (datos) => {
    return {
        nombre: datos.nombre,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
