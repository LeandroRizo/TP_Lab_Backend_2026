export const standQueryDTO = (datos) => {
    return {
        numero: datos.numero,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
