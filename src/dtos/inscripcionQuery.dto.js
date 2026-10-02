export const inscripcionQueryDTO = (datos) => {
    return {
        estado: datos.estado,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
