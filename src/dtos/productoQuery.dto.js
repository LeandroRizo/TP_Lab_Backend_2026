export const productoQueryDTO = (datos) => {
    return {
        nombre: datos.nombre,
        id_categoria: datos.id_categoria,
        id_artesano: datos.id_artesano,
        precioMin: datos.precioMin,
        precioMax: datos.precioMax,
        sortBy: datos.sortBy,
        order: datos.order,
        page: datos.page,
        limit: datos.limit
    };
};
