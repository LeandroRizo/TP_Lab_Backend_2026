import fs from "fs";
import swaggerAutogen from "swagger-autogen";
import { esquemas } from "./src/documentacion/esquemas.js";

const doc = {
    info: {
        title: "Poncho Digital API",
        version: "1.0.0",
        description: "API REST para la plataforma digital de artesanos de la Fiesta Nacional e Internacional del Poncho (Trabajo de Laboratorio Backend 2026 - UNCa)."
    },
    servers: [
        {
            url: "http://localhost:3000",
            description: "Servidor local de desarrollo"
        }
    ],
    tags: [
        { name: "Autenticación", description: "Registro, login JWT, perfil de cuenta (/me) y cierre de sesión (/logout)" },
        { name: "Solicitudes", description: "Postulación pública de artesanos y resolución administrativa (APROBADA, RECHAZADA, MODIFICACION)" },
        { name: "Usuarios", description: "Gestión administrativa de cuentas, alta de administradores y activación/desactivación" },
        { name: "Artesanos", description: "Catálogo público y gestión administrativa de artesanos" },
        { name: "Productos", description: "Catálogo público y CRUD de productos propios para artesanos habilitados" },
        { name: "Stands", description: "Gestión de stands, consulta por filtros, ubicación con coordenadas y asignación artesano-stand" },
        { name: "Reportes", description: "Reportes administrativos consolidados y métricas del festival" },
        { name: "Estadísticas", description: "Tendencias públicas de búsqueda de visitantes" },
        { name: "Categorías", description: "Categorías de productos artesanales" },
        { name: "Localidades", description: "Localidades de origen de los artesanos" },
        { name: "Rubros", description: "Rubros artesanales del festival" },
        { name: "Pabellones", description: "Pabellones del predio ferial" },
        { name: "Zonas", description: "Zonas y sectores dentro de los pabellones" },
        { name: "Roles", description: "Roles del sistema (Administrador, Artesano, Postulante)" },
        { name: "Inscripciones", description: "Inscripciones de participación en ediciones del festival" }
    ],
    components: {
        securitySchemes: {
            bearerAuth: {
                type: "http",
                scheme: "bearer",
                bearerFormat: "JWT",
                description: "Ingrese el token JWT obtenido en POST /api/auth/login"
            }
        },
        schemas: esquemas,
        "@schemas": esquemas
    }
};

const outputFile = "./swagger-output.json";
const endpointsFiles = ["./src/app.js"];

const generar = swaggerAutogen({
    openapi: "3.0.0",
    autoHeaders: false,
    autoQuery: false,
    autoBody: false
});

const resultado = await generar(outputFile, endpointsFiles, doc);

if (resultado && resultado.success) {
    // Normalizar la salida para que contenga únicamente components.schemas estándar de OpenAPI 3.0
    const spec = JSON.parse(fs.readFileSync(outputFile, "utf8"));
    spec.components = spec.components || {};
    spec.components.schemas = esquemas;
    delete spec.components["@schemas"];
    const jsonFormateado = JSON.stringify(spec, null, 2);
    fs.writeFileSync(outputFile, jsonFormateado, "utf8");
    fs.writeFileSync("./src/docs/swagger.json", jsonFormateado, "utf8");
}
