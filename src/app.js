import express from 'express';
import artesanoRoutes from "./routes/artesano.routes.js";

const app = express();
const PORT = 3000;

app.use(express.json());

app.use("/api/artesanos", artesanoRoutes);

app.get('/', (req, res) => {
 res.status(200).send(`API Poncho Digital funcionando...`);
});

app.listen(PORT, () => {
 console.log(`Servidor escuchando en http://localhost:${PORT}`);
});

