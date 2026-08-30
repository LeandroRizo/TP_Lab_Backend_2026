// Simulación de base datos en memoria

let artesanos = [
    {id: 1, nombre: 'Juan', apellido: 'Pérez', rubro: "Textil", localidad: 'Capital'}
];

export const getArtesanos = () => {
    return artesanos;
}

export const crearArtesano = (nuevoArtesano) => {
  const id = artesanos.length > 0 ? artesanos[artesanos.length - 1].id + 1 : 1;
  const artesano = { id, ...nuevoArtesano };
  artesanos.push(artesano);
  return artesano;
};