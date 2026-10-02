export const crearProductoDTO = (datos) => {
    return {
        id_artesano: datos.id_artesano,
        id_categoria: datos.id_categoria,
        nombre: datos.nombre,
        descripcion: datos.descripcion,
        precio: datos.precio
    };
};
