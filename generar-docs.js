import fs from "fs";
import swaggerAutogen from "swagger-autogen";
import { esquemas } from "./src/documentacion/esquemas.js";

// Clon profundo de los esquemas limpios para evitar que swagger-autogen los mute en memoria durante el análisis
const esquemasNormalizados = JSON.parse(JSON.stringify(esquemas));

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
        schemas: {}
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
    spec.components.schemas = esquemasNormalizados;
    delete spec.components["@schemas"];

    // Asegurar que parámetros in: 'path' solo pertenezcan a rutas cuyo template incluya la variable
    for (const [pathKey, pathObj] of Object.entries(spec.paths || {})) {
        for (const method of ["get", "post", "put", "delete", "patch"]) {
            if (pathObj[method]?.parameters) {
                pathObj[method].parameters = pathObj[method].parameters.filter((param) => {
                    if (param.in === "path") {
                        return pathKey.includes(`{${param.name}}`);
                    }
                    return true;
                });
                if (pathObj[method].parameters.length === 0) {
                    delete pathObj[method].parameters;
                }
            }
        }
    }

    // Asociación de esquemas de respuesta formales para las 33 operaciones identificadas
    const respuestasExitosas = [
        // 1. Endpoint raíz
        { path: "/", method: "get", code: "200", contentType: "text/plain", schema: { type: "string", example: "API Poncho Digital funcionando..." } },

        // 2. Roles
        { path: "/api/roles/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaRolesRespuesta" },
        { path: "/api/roles/", method: "post", code: "201", schemaRef: "#/components/schemas/RolRespuesta" },
        { path: "/api/roles/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/RolRespuesta" },
        { path: "/api/roles/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/RolRespuesta" },

        // 3. Usuarios
        { path: "/api/usuarios/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaUsuariosRespuesta" },

        // 4. Localidades
        { path: "/api/localidades/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaLocalidadesRespuesta" },
        { path: "/api/localidades/", method: "post", code: "201", schemaRef: "#/components/schemas/LocalidadRespuesta" },
        { path: "/api/localidades/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/LocalidadRespuesta" },
        { path: "/api/localidades/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/LocalidadRespuesta" },

        // 5. Rubros
        { path: "/api/rubros/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaRubrosRespuesta" },
        { path: "/api/rubros/", method: "post", code: "201", schemaRef: "#/components/schemas/RubroRespuesta" },
        { path: "/api/rubros/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/RubroRespuesta" },
        { path: "/api/rubros/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/RubroRespuesta" },

        // 6. Inscripciones
        { path: "/api/inscripciones/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaInscripcionesRespuesta" },
        { path: "/api/inscripciones/", method: "post", code: "201", schemaRef: "#/components/schemas/InscripcionRespuesta" },
        { path: "/api/inscripciones/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/InscripcionRespuesta" },
        { path: "/api/inscripciones/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/InscripcionRespuesta" },
        { path: "/api/inscripciones/asignar-stand", method: "post", code: "200", schemaRef: "#/components/schemas/AsignarStandRespuesta" },

        // 7. Pabellones
        { path: "/api/pabellones/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaPabellonesRespuesta" },
        { path: "/api/pabellones/", method: "post", code: "201", schemaRef: "#/components/schemas/PabellonRespuesta" },
        { path: "/api/pabellones/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/PabellonRespuesta" },
        { path: "/api/pabellones/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/PabellonRespuesta" },

        // 8. Zonas
        { path: "/api/zonas/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaZonasRespuesta" },
        { path: "/api/zonas/", method: "post", code: "201", schemaRef: "#/components/schemas/ZonaRespuesta" },
        { path: "/api/zonas/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/ZonaRespuesta" },
        { path: "/api/zonas/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/ZonaRespuesta" },

        // 9. Stands (asignaciones)
        { path: "/api/stands/asignar", method: "post", code: "200", schemaRef: "#/components/schemas/AsignarStandRespuesta" },
        { path: "/api/stands/{id}/asignar", method: "put", code: "200", schemaRef: "#/components/schemas/AsignarStandRespuesta" },

        // 10. Categorías
        { path: "/api/categorias/", method: "get", code: "200", schemaRef: "#/components/schemas/ListaCategoriasRespuesta" },
        { path: "/api/categorias/", method: "post", code: "201", schemaRef: "#/components/schemas/CategoriaRespuesta" },
        { path: "/api/categorias/{id}", method: "get", code: "200", schemaRef: "#/components/schemas/CategoriaRespuesta" },
        { path: "/api/categorias/{id}", method: "put", code: "200", schemaRef: "#/components/schemas/CategoriaRespuesta" }
    ];

    for (const item of respuestasExitosas) {
        const op = spec.paths?.[item.path]?.[item.method];
        if (op) {
            op.responses = op.responses || {};
            op.responses[item.code] = op.responses[item.code] || {};
            if (item.schemaRef) {
                op.responses[item.code].content = {
                    "application/json": {
                        schema: { $ref: item.schemaRef }
                    }
                };
            } else if (item.contentType && item.schema) {
                op.responses[item.code].content = {
                    [item.contentType]: {
                        schema: item.schema
                    }
                };
            }
        }
    }

    const jsonFormateado = JSON.stringify(spec, null, 2);
    fs.writeFileSync(outputFile, jsonFormateado, "utf8");
    if (fs.existsSync("./src/docs")) {
        fs.writeFileSync("./src/docs/swagger.json", jsonFormateado, "utf8");
    }
    console.log("Documentación OpenAPI 3.0 generada y normalizada exitosamente.");
}
