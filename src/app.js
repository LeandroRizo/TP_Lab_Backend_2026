import express from 'express';
import rolRoutes from "./routes/rol.routes.js";
import usuarioRoutes from "./routes/usuario.routes.js";
import artesanoRoutes from "./routes/artesano.routes.js";
import localidadRoutes from "./routes/localidad.routes.js";
import rubroRoutes from "./routes/rubro.routes.js";
import inscripcionRoutes from "./routes/inscripcion.routes.js";
import pabellonRoutes from "./routes/pabellon.routes.js";
import zonaRoutes from "./routes/zona.routes.js";
import standRoutes from "./routes/stand.routes.js";
import categoriaRoutes from "./routes/categoria.routes.js";
import productoRoutes from "./routes/producto.routes.js";

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use("/api/roles", rolRoutes);
app.use("/api/usuarios", usuarioRoutes);
app.use("/api/artesanos", artesanoRoutes);
app.use("/api/localidades", localidadRoutes);
app.use("/api/rubros", rubroRoutes);
app.use("/api/inscripciones", inscripcionRoutes);
app.use("/api/pabellones", pabellonRoutes);
app.use("/api/zonas", zonaRoutes);
app.use("/api/stands", standRoutes);
app.use("/api/categorias", categoriaRoutes);
app.use("/api/productos", productoRoutes);

app.get('/', (req, res) => {
 res.status(200).send(`API Poncho Digital funcionando...`);
});

app.listen(PORT, () => {
 console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
