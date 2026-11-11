import express from "express";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import swaggerUi from "swagger-ui-express";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const router = express.Router();
const swaggerPath = path.join(__dirname, "../../swagger-output.json");

const cargarSpecSwagger = () => {
    return JSON.parse(fs.readFileSync(swaggerPath, "utf8"));
};

// Endpoint que expone la especificación OpenAPI 3.0 en formato JSON
router.get(["/swagger.json", "/swagger-output.json"], (req, res) => {
    /* #swagger.ignore = true */
    try {
        const spec = cargarSpecSwagger();
        res.status(200).json(spec);
    } catch (error) {
        res.status(500).json({
            mensaje: "Error al cargar la documentación Swagger",
            error: error.message
        });
    }
});

// Interfaz interactiva Swagger UI servida localmente mediante swagger-ui-express
router.use(
    "/",
    /* #swagger.ignore = true */
    swaggerUi.serve,
    (req, res, next) => {
        const spec = cargarSpecSwagger();
        return swaggerUi.setup(spec, {
            customSiteTitle: "Poncho Digital API - Swagger UI"
        })(req, res, next);
    }
);

export default router;
