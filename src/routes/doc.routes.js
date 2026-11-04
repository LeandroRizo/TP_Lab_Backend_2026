import express from "express";
import fs from "fs";
import path from "path";
import { createRequire } from "module";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const require = createRequire(import.meta.url);

// Resolver el directorio local de swagger-ui-dist instalado en node_modules (sin depender de CDN externo)
const swaggerUiDistPath = path.dirname(require.resolve("swagger-ui-dist/package.json"));

const router = express.Router();
const rootSwaggerPath = path.join(__dirname, "../../swagger-output.json");
const fallbackSwaggerPath = path.join(__dirname, "../docs/swagger.json");

const cargarSpecSwagger = () => {
    if (fs.existsSync(rootSwaggerPath)) {
        return JSON.parse(fs.readFileSync(rootSwaggerPath, "utf8"));
    }
    return JSON.parse(fs.readFileSync(fallbackSwaggerPath, "utf8"));
};

// Endpoint que expone la especificación OpenAPI 3.0 en formato JSON
router.get(["/swagger.json", "/swagger-output.json"], (req, res) => {
    /* #swagger.ignore = true */
    try {
        const spec = cargarSpecSwagger();
        res.setHeader("Content-Type", "application/json");
        res.status(200).json(spec);
    } catch (error) {
        res.status(500).json({ mensaje: "Error al cargar la documentación Swagger", error: error.message });
    }
});

// Interfaz interactiva Swagger UI servida en /docs y /api-docs usando recursos locales sin CDN externo
router.get(["/", "/index.html"], (req, res) => {
    /* #swagger.ignore = true */
    const html = `<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Poncho Digital API - Swagger UI</title>
    <link rel="stylesheet" href="/docs/swagger-ui.css" />
    <link rel="icon" type="image/png" href="/docs/favicon-32x32.png" />
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
    <script src="/docs/swagger-ui-bundle.js"></script>
    <script src="/docs/swagger-ui-standalone-preset.js"></script>
    <script>
    window.onload = function() {
        var basePath = window.location.pathname.replace(/\\/index\\.html$/, '').replace(/\\/$/, '');
        window.ui = SwaggerUIBundle({
            url: (basePath || '/docs') + "/swagger.json",
            dom_id: '#swagger-ui',
            deepLinking: true,
            persistAuthorization: true,
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

// Servir archivos estáticos locales de swagger-ui-dist (swagger-ui.css, swagger-ui-bundle.js, etc.)
router.use(express.static(swaggerUiDistPath, { index: false }));

export default router;
