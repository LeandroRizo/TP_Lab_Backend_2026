export const crearInscripcionDTO = (datos) => {
    return {
        id_artesano: datos.id_artesano,
        id_stand: datos.id_stand,
        anio: datos.anio,
        fecha_solicitud: datos.fecha_solicitud,
        fecha_resolucion: datos.fecha_resolucion,
        estado: datos.estado,
        motivo_rechazo: datos.motivo_rechazo,
        observaciones: datos.observaciones
    };
};
