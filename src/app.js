import express from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
 res.status(200).send(`API Poncho Digital funcionando...`);
});

app.listen(PORT, () => {
 console.log(`Servidor escuchando en http://localhost:${PORT}`);
});

