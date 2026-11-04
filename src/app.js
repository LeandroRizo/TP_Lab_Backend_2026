import express from 'express';
// Criterio 2.1: Módulo de configuración que valida JWT_SECRET y detiene el arranque si falta
import config from "./config/env.js";

// Rutas
import authRoutes from "./routes/auth.routes.js";
import rolRoutes from "./routes/rol.routes.js";
import usuarioRoutes from "./routes/usuario.routes.js";
import artesanoRoutes from "./routes/artesano.routes.js";
import localidadRoutes from "./routes/localidad.routes.js";
import rubroRoutes from "./routes/rubro.routes.js";
import inscripcionRoutes from "./routes/inscripcion.routes.js";
import solicitudRoutes from "./routes/solicitud.routes.js";
import pabellonRoutes from "./routes/pabellon.routes.js";
import zonaRoutes from "./routes/zona.routes.js";
import standRoutes from "./routes/stand.routes.js";
import categoriaRoutes from "./routes/categoria.routes.js";
import productoRoutes from "./routes/producto.routes.js";
import reporteRoutes from "./routes/reporte.routes.js";
import estadisticaRoutes from "./routes/estadistica.routes.js";
import docRoutes from "./routes/doc.routes.js";

// Controladores y middlewares para rutas directas
import { postularse } from "./controllers/auth.controller.js";
import { validarPostulacion } from "./middlewares/validarAuth.js";

// Middlewares
import { errorHandler } from "./middlewares/errorHandler.js";

// Tareas programadas
import { iniciarLimpiezaRevocaciones } from "./utils/cleanupTask.js";

const app = express();
const PORT = config.port;

app.use(express.json());

// Criterio 1.1 (Nivel 1): Swagger UI se publica en /docs (y /api-docs) antes del manejador 404
app.use("/docs", /* #swagger.ignore = true */ docRoutes);
app.use("/api-docs", /* #swagger.ignore = true */ docRoutes);

// Criterio 1.2, 1.4, 1.5, 1.6, 2.2, 2.5, 2.6: Autenticación, registro, login, GET /me y POST /logout
app.use("/api/auth", authRoutes);
// Rutas de compatibilidad directa (ej. /api/me, /me, /api/logout, /logout)
app.use("/api", /* #swagger.ignore = true */ authRoutes);
app.use(/* #swagger.ignore = true */ authRoutes);

// Criterio 4 & 6: Postulación pública directa
app.post("/api/postulacion", validarPostulacion, postularse);
app.post("/postulacion", /* #swagger.ignore = true */ validarPostulacion, postularse);

// Endpoints de entidades del Poncho Digital
app.use("/api/roles", rolRoutes);
app.use("/api/usuarios", /* #swagger.security = [{ "bearerAuth": [] }] */ usuarioRoutes);
app.use("/api/artesanos", artesanoRoutes);
app.use("/api/localidades", localidadRoutes);
app.use("/api/rubros", rubroRoutes);
app.use("/api/inscripciones", inscripcionRoutes);
app.use("/api/solicitudes", /* #swagger.security = [{ "bearerAuth": [] }] */ solicitudRoutes);
app.use("/api/pabellones", pabellonRoutes);
app.use("/api/zonas", zonaRoutes);
app.use("/api/stands", standRoutes);
app.use("/api/categorias", categoriaRoutes);
app.use("/api/productos", productoRoutes);

// Reportes administrativos y estadísticas públicas
app.use("/api/reportes", /* #swagger.security = [{ "bearerAuth": [] }] */ reporteRoutes);
app.use("/api/estadisticas", estadisticaRoutes);

app.get('/', (req, res) => {
    /*
        #swagger.tags = ['Estado']
        #swagger.summary = 'Comprobar estado de funcionamiento de la API'
        #swagger.security = []
        #swagger.responses[200] = { description: 'API activa y operativa' }
    */
    res.status(200).send(`API Poncho Digital funcionando...`);
});

// Criterio 1.1 (Nivel 1): Manejador 404 ubicado después de las rutas y de /docs
app.use((req, res) => {
    res.status(404).json({
        mensaje: "Ruta no encontrada"
    });
});

// Criterio 1.7 & 8: Manejador de errores centralizado (al final de las rutas)
app.use(errorHandler);

// Criterio 2.1 (Nivel 2): app.listen y las tareas periódicas solo fuera de NODE_ENV=test
if (process.env.NODE_ENV !== "test") {
    app.listen(PORT, () => {
        console.log(`Servidor escuchando en http://localhost:${PORT}`);
        // Criterio 2.7: Tarea periódica iniciada al arrancar el servidor para limpiar revocaciones vencidas
        iniciarLimpiezaRevocaciones();
    });
}

export { app };
export default app;
