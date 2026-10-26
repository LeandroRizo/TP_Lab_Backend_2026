export const resolverSolicitudDTO = (datos) => {
    return {
        estado: datos.estado,
        motivo_rechazo: datos.motivo_rechazo,
        observaciones: datos.observaciones
    };
};

export const solicitudQueryDTO = (datos) => {
    return {
        estado: datos.estado,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
