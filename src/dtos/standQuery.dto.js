export const standQueryDTO = (datos) => {
    return {
        numero: datos.numero,
        id_pabellon: datos.id_pabellon,
        pabellon: datos.pabellon,
        id_zona: datos.id_zona,
        zona: datos.zona,
        sector: datos.sector,
        estado: datos.estado ? datos.estado.toUpperCase() : undefined,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
