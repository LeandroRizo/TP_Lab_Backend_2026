import express from "express";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const router = express.Router();
const swaggerJsonPath = path.join(__dirname, "../docs/swagger.json");

// Endpoint que expone la especificación OpenAPI 3.0 en formato JSON
router.get("/swagger.json", (req, res) => {
    try {
        const spec = JSON.parse(fs.readFileSync(swaggerJsonPath, "utf8"));
        res.setHeader("Content-Type", "application/json");
        res.status(200).json(spec);
    } catch (error) {
        res.status(500).json({ mensaje: "Error al cargar la documentación Swagger", error: error.message });
    }
});

// Interfaz interactiva Swagger UI servida de forma directa y autónoma
router.get(["/", "/index.html"], (req, res) => {
    const html = `<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Poncho Digital API - Swagger UI</title>
    <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@5/swagger-ui.css" />
    <link rel="icon" type="image/png" href="https://unpkg.com/swagger-ui-dist@5/favicon-32x32.png" />
    <style>
        html { box-sizing: border-box; overflow: -moz-scrollbars-vertical; overflow-y: scroll; }
        *, *:before, *:after { box-sizing: inherit; }
        body { margin: 0; background: #fafafa; }
        .topbar { display: none !important; }
        .swagger-ui .info { margin: 20px 0; }
        .swagger-ui .info .title { color: #8B1E0F; }
    </style>
</head>
<body>
    <div id="swagger-ui"></div>
    <script src="https://unpkg.com/swagger-ui-dist@5/swagger-ui-bundle.js"></script>
    <script src="https://unpkg.com/swagger-ui-dist@5/swagger-ui-standalone-preset.js"></script>
    <script>
    window.onload = function() {
        window.ui = SwaggerUIBundle({
            url: "/api-docs/swagger.json",
            dom_id: '#swagger-ui',
            deepLinking: true,
            presets: [
                SwaggerUIBundle.presets.apis,
                SwaggerUIStandalonePreset
            ],
            plugins: [
                SwaggerUIBundle.plugins.DownloadUrl
            ],
            layout: "StandaloneLayout"
        });
    };
    </script>
</body>
</html>`;
    res.setHeader("Content-Type", "text/html; charset=utf-8");
    res.status(200).send(html);
});

export default router;
