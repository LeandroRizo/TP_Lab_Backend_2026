export const usuarioQueryDTO = (datos) => {
    return {
        email: datos.email,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
