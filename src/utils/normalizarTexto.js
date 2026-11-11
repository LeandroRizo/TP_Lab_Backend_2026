/**
 * Normaliza una cadena de texto para comparaciones insensibles a mayúsculas,
 * minúsculas, tildes/diacríticos y espacios múltiples o sobrantes.
 * 
 * No modifica los datos originales almacenados en base de datos.
 * Se utiliza exclusivamente para comparar y resolver entidades en memoria.
 * 
 * @param {string} texto Cadena a normalizar
 * @returns {string} Cadena normalizada sin tildes, minúscula y con espacios simples
 */
export const normalizarTexto = (texto) => {
    if (typeof texto !== "string") return "";
    return texto
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "") // Elimina marcas diacríticas (tildes, acentos, diéresis)
        .trim()
        .toLowerCase()
        .replace(/\s+/g, " "); // Colapsa múltiples espacios internos en un único espacio
};
