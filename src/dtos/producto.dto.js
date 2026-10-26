// Criterio 5: El artesano del alta sale de la cuenta autenticada, nunca del body
export const crearProductoDTO = (datos, id_artesano) => {
    return {
        id_artesano: id_artesano !== undefined ? id_artesano : datos.id_artesano,
        id_categoria: datos.id_categoria,
        nombre: datos.nombre,
        descripcion: datos.descripcion,
        precio: datos.precio
    };
};
