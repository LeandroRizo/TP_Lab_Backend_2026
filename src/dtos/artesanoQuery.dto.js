export const artesanoQueryDTO = (datos) => {
    return {
        localidad: datos.localidad,
        rubro: datos.rubro,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};