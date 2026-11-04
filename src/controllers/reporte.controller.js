import {
    obtenerReporteGeneral,
    obtenerArtesanosPorLocalidad,
    obtenerArtesanosPorRubro,
    obtenerStandsOcupacion,
    obtenerProductosPorArtesano
} from "../services/reporte.service.js";
import { obtenerTendencias } from "../services/estadisticas.service.js";
import { obtenerCache, guardarCache } from "../utils/cache.js";

const TTL_REPORTES_MS = 60 * 1000; // 60 segundos

const usarCacheActivo = (req) => {
    if (req.query?.nocache === "true") return false;
    return true;
};

const responderConCache = async (req, res, claveCache, generadorDatos) => {
    if (usarCacheActivo(req)) {
        const enCache = obtenerCache(claveCache);
        if (enCache) {
            res.set("X-Cache", "HIT");
            res.set("Cache-Control", "private, max-age=60");
            return res.status(200).json(enCache);
        }
    }

    const datos = await generadorDatos();
    if (usarCacheActivo(req)) {
        guardarCache(claveCache, datos, TTL_REPORTES_MS);
    }
    res.set("X-Cache", "MISS");
    res.set("Cache-Control", "private, max-age=60");
    return res.status(200).json(datos);
};

export const getReporteGeneral = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Obtener reporte general consolidado del festival (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché y recalcula el reporte en tiempo real',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Reporte general con métricas de artesanos, stands, productos y tendencias (incluye cabecera X-Cache: HIT | MISS)',
            content: {
                "application/json": {
                    schema: { $ref: "#/components/schemas/ReporteGeneralRespuesta" }
                }
            }
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:general", obtenerReporteGeneral);
    } catch (error) {
        next(error);
    }
};

export const getArtesanosPorLocalidadReporte = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Reporte de cantidad de artesanos registrados por localidad (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Distribución de artesanos por localidad'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:artesanos-localidad", obtenerArtesanosPorLocalidad);
    } catch (error) {
        next(error);
    }
};

export const getArtesanosPorRubroReporte = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Reporte de cantidad de artesanos registrados por rubro artesanal (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Distribución de artesanos por rubro'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:artesanos-rubro", obtenerArtesanosPorRubro);
    } catch (error) {
        next(error);
    }
};

export const getStandsOcupacionReporte = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Reporte de cantidad de stands ocupados y disponibles (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Métricas de ocupación de stands del predio'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:stands-ocupacion", obtenerStandsOcupacion);
    } catch (error) {
        next(error);
    }
};

export const getProductosPorArtesanoReporte = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Reporte de cantidad de productos publicados por cada artesano (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Cantidad de productos agrupados por artesano'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:productos-artesano", obtenerProductosPorArtesano);
    } catch (error) {
        next(error);
    }
};

export const getTendenciasBusquedaReporte = async (req, res, next) => {
    /*
        #swagger.tags = ['Reportes']
        #swagger.summary = 'Reporte de estadísticas de intereses y tendencias de búsqueda de visitantes (Solo Administrador)'
        #swagger.security = [{ "bearerAuth": [] }]
        #swagger.parameters['nocache'] = {
            in: 'query',
            description: 'Si es true, omite la lectura de caché',
            required: false,
            '@schema': { type: 'string', enum: ['true', 'false'] }
        }
        #swagger.responses[200] = {
            description: 'Estadísticas de términos más buscados y consultas por entidad'
        }
        #swagger.responses[401] = {
            description: 'No autenticado',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
        #swagger.responses[403] = {
            description: 'Requiere rol Administrador',
            content: { "application/json": { schema: { $ref: "#/components/schemas/ErrorApi" } } }
        }
    */
    try {
        await responderConCache(req, res, "reportes:tendencias-busqueda", () => Promise.resolve(obtenerTendencias()));
    } catch (error) {
        next(error);
    }
};
