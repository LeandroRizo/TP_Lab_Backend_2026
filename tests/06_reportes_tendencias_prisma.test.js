import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import { BASE_URL, obtenerUsuariosPrueba } from "./testHelper.js";

describe("06. Reportes, Tendencias de Búsqueda y Errores Prisma", () => {
    let ctx;

    before(async () => {
        ctx = await obtenerUsuariosPrueba();
    });

    it("Solo ADMINISTRADOR puede acceder a reportes; usuario no admin recibe HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.artesanoToken}` }
        });
        assert.equal(res.status, 403);
    });

    it("Admin obtiene reporte general consolidado en GET /api/reportes (HTTP 200)", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });

        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(data.resumen);
        assert.ok(typeof data.resumen.total_artesanos === "number");
        assert.ok(Array.isArray(data.artesanos_por_localidad));
        assert.ok(Array.isArray(data.artesanos_por_rubro));
        assert.ok(data.stands);
        assert.ok(typeof data.stands.ocupados === "number");
        assert.ok(typeof data.stands.disponibles === "number");
        assert.ok(Array.isArray(data.productos_por_artesano));
    });

    it("Admin accede a reporte específico de ocupación de stands", async () => {
        const res = await fetch(`${BASE_URL}/api/reportes/stands-ocupacion`, {
            headers: { Authorization: `Bearer ${ctx.adminToken}` }
        });

        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(typeof data.total_stands === "number");
        assert.ok(typeof data.porcentaje_ocupacion === "number");
    });

    it("Middleware registra consulta de visitante al buscar productos", async () => {
        const terminoUnico = `busqueda_poncho_${Date.now()}`;
        // Petición pública simulando visitante buscando producto
        const resBusqueda = await fetch(`${BASE_URL}/api/productos?nombre=${terminoUnico}`);
        assert.equal(resBusqueda.status, 200);

        // Consultar estadísticas de tendencias
        const resStats = await fetch(`${BASE_URL}/api/estadisticas/tendencias`);
        assert.equal(resStats.status, 200);
        const stats = await resStats.json();

        assert.ok(stats.total_consultas_registradas > 0);
        assert.ok(stats.terminos_populares.some(t => t.termino === terminoUnico));
    });

    it("Documentación Swagger UI responde HTTP 200 en /api-docs y expone /api-docs/swagger.json", async () => {
        const resUi = await fetch(`${BASE_URL}/api-docs`);
        assert.equal(resUi.status, 200);
        const html = await resUi.text();
        assert.ok(html.includes("SwaggerUIBundle"));

        const resJson = await fetch(`${BASE_URL}/api-docs/swagger.json`);
        assert.equal(resJson.status, 200);
        const spec = await resJson.json();
        assert.equal(spec.openapi, "3.0.0");
        assert.ok(spec.paths["/api/auth/login"]);
    });
});
