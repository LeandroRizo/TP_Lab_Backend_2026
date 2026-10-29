import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import prisma from "../src/prisma.js";
import { BASE_URL, obtenerUsuariosPrueba } from "./testHelper.js";

describe("05. Stands, Filtros, Ubicaciones y Asignaciones", () => {
    let ctx;
    let standPrueba;

    before(async () => {
        ctx = await obtenerUsuariosPrueba();

        let pabellon = await prisma.pabellon.findFirst();
        if (!pabellon) {
            pabellon = await prisma.pabellon.create({
                data: { numero: 1, nombre: "Pabellón Turismo", descripcion: "Pabellón principal" }
            });
        }

        let zona = await prisma.zona.findFirst({ where: { id_pabellon: pabellon.id_pabellon } });
        if (!zona) {
            zona = await prisma.zona.create({
                data: { numero: 1, nombre: "Sector Artesanías", id_pabellon: pabellon.id_pabellon }
            });
        }

        standPrueba = await prisma.stand.findFirst({ where: { id_zona: zona.id_zona } });
        if (!standPrueba) {
            standPrueba = await prisma.stand.create({
                data: { numero: 501, descripcion: "Stand de prueba", id_zona: zona.id_zona }
            });
        }
    });

    it("Consulta pública de stands GET /api/stands devuelve 200 con paginación", async () => {
        const res = await fetch(`${BASE_URL}/api/stands`);
        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(Array.isArray(data.data));
        assert.ok(data.meta);
    });

    it("Filtro de stands por pabellón funciona correctamente", async () => {
        const res = await fetch(`${BASE_URL}/api/stands?id_pabellon=1`);
        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(Array.isArray(data.data));
    });

    it("Filtro de stands por sector/zona funciona correctamente", async () => {
        const res = await fetch(`${BASE_URL}/api/stands?id_zona=${standPrueba.id_zona}`);
        assert.equal(res.status, 200);
        const data = await res.json();
        assert.ok(Array.isArray(data.data));
    });

    it("Filtro de stands por estado DISPONIBLE u OCUPADO funciona correctamente", async () => {
        const resDisp = await fetch(`${BASE_URL}/api/stands?estado=DISPONIBLE`);
        assert.equal(resDisp.status, 200);

        const resOcup = await fetch(`${BASE_URL}/api/stands?estado=OCUPADO`);
        assert.equal(resOcup.status, 200);
    });

    it("GET /api/stands/ubicacion devuelve stands con pabellón, sector y coordenadas en JSON", async () => {
        const res = await fetch(`${BASE_URL}/api/stands/ubicacion`);
        assert.equal(res.status, 200);
        const list = await res.json();
        assert.ok(Array.isArray(list));
        assert.ok(list.length > 0);

        const item = list[0];
        assert.ok(item.id_stand);
        assert.ok(item.numero);
        assert.ok(item.estado); // "DISPONIBLE" u "OCUPADO"
        assert.ok(item.coordenadas);
        assert.equal(typeof item.coordenadas.x, "number");
        assert.equal(typeof item.coordenadas.y, "number");
        assert.equal(typeof item.coordenadas.lat, "number");
        assert.equal(typeof item.coordenadas.lng, "number");
    });

    it("GET /api/stands/:id/ubicacion devuelve ubicación de stand específico", async () => {
        const res = await fetch(`${BASE_URL}/api/stands/${standPrueba.id_stand}/ubicacion`);
        assert.equal(res.status, 200);
        const item = await res.json();
        assert.equal(item.id_stand, standPrueba.id_stand);
        assert.ok(item.coordenadas);
    });

    it("Admin puede asignar artesano a stand exitosamente", async () => {
        const res = await fetch(`${BASE_URL}/api/stands/asignar`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id_stand: standPrueba.id_stand,
                id_artesano: ctx.usuarioArtesano.artesano.id_artesano
            })
        });

        assert.equal(res.status, 200);
        const data = await res.json();
        assert.equal(data.id_stand, standPrueba.id_stand);
        assert.equal(data.id_artesano, ctx.usuarioArtesano.artesano.id_artesano);
    });

    it("No-administrador intentando asignar stand recibe HTTP 403", async () => {
        const res = await fetch(`${BASE_URL}/api/stands/asignar`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${ctx.artesanoToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id_stand: standPrueba.id_stand,
                id_artesano: ctx.usuarioArtesano.artesano.id_artesano
            })
        });

        assert.equal(res.status, 403);
    });
});
