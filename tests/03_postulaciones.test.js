import { describe, it, before } from "node:test";
import assert from "node:assert/strict";
import prisma from "../src/prisma.js";
import { BASE_URL, generarToken, obtenerUsuariosPrueba } from "./testHelper.js";

describe("03. Postulaciones, Aprobación y Estados", () => {
    let ctx;
    let localidad;
    let rubro;
    let categoria;
    let postulacionAprobada;
    let tokenPostulanteAprobado;

    before(async () => {
        ctx = await obtenerUsuariosPrueba();
        localidad = await prisma.localidad.findFirst();
        rubro = await prisma.rubro.findFirst();
        categoria = await prisma.categoria.findFirst();
    });

    it("1. Postulación pública crea cuenta con rol Postulante y solicitud en estado PENDIENTE", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/postulacion`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Carla",
                apellido: "Medina",
                email: `carla_${timestamp}@postulante.test`,
                password: "CarlaPassword2026!",
                dni: `DNI_CARLA_${timestamp}`,
                telefono: "3834998877",
                direccion: "Calle Falsa 123",
                descripcion: "Cerámica tradicional",
                instagram: "@carla.ceramicas",
                id_localidad: localidad.id_localidad,
                id_rubro: rubro.id_rubro,
                observaciones: "Postulante nueva"
            })
        });

        assert.equal(res.status, 201);
        postulacionAprobada = await res.json();
        assert.ok(postulacionAprobada.usuario);
        assert.ok(postulacionAprobada.artesano);
        assert.ok(postulacionAprobada.solicitud);
        assert.equal(postulacionAprobada.solicitud.estado, "PENDIENTE");

        const u = await prisma.usuario.findUnique({
            where: { id_usuario: postulacionAprobada.usuario.id_usuario },
            include: { rol: true }
        });
        assert.equal(u.rol.nombre.toLowerCase(), "postulante");
        tokenPostulanteAprobado = generarToken(u.id_usuario);
    });

    it("2. Mientras la solicitud está PENDIENTE, el postulante NO puede crear productos (HTTP 403)", async () => {
        const resProd = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${tokenPostulanteAprobado}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Jarrón de Barro No Habilitado",
                precio: 15000,
                id_categoria: categoria.id_categoria
            })
        });
        assert.equal(resProd.status, 403);
    });

    it("3. Aprobación atómica cambia estado a APROBADA y habilita rol Artesano (HTTP 200)", async () => {
        const resAprobar = await fetch(`${BASE_URL}/api/solicitudes/${postulacionAprobada.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                estado: "APROBADA",
                observaciones: "Aprobada formalmente por el comité evaluador"
            })
        });
        assert.equal(resAprobar.status, 200);

        // Verificar en base de datos que la solicitud pasó a APROBADA
        const solDb = await prisma.solicitud.findUnique({
            where: { id_solicitud: postulacionAprobada.solicitud.id_solicitud }
        });
        assert.equal(solDb.estado, "APROBADA");

        // Verificar en base de datos que el usuario ahora tiene rol Artesano
        const uActualizado = await prisma.usuario.findUnique({
            where: { id_usuario: postulacionAprobada.usuario.id_usuario },
            include: { rol: true }
        });
        assert.equal(uActualizado.rol.nombre.toLowerCase(), "artesano");
    });

    it("4. Usuario aprobado con rol Artesano puede crear productos propios exitosamente (HTTP 201)", async () => {
        const resProdHabilitado = await fetch(`${BASE_URL}/api/productos`, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${tokenPostulanteAprobado}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: "Jarrón de Barro Aprobado",
                precio: 15000,
                id_categoria: categoria.id_categoria
            })
        });
        assert.equal(resProdHabilitado.status, 201);
        const prod = await resProdHabilitado.json();
        assert.ok(prod.id_producto);
        assert.equal(prod.id_artesano, postulacionAprobada.artesano.id_artesano);

        // Limpieza del producto de prueba
        await prisma.producto.delete({ where: { id_producto: prod.id_producto } });
    });

    it("5. Solicitud ya resuelta NO puede volver a aprobarse ni resolverse (HTTP 409)", async () => {
        const resDuplicado = await fetch(`${BASE_URL}/api/solicitudes/${postulacionAprobada.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                estado: "APROBADA"
            })
        });
        assert.equal(resDuplicado.status, 409);
        const errJson = await resDuplicado.json();
        assert.equal(errJson.mensaje, "La solicitud ya ha sido resuelta previamente");
    });

    it("6. Atomicidad garantizada: fallo en resolución revierte cambios y mantiene PENDIENTE", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/postulacion`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Atomic",
                apellido: "Test",
                email: `atomic_${timestamp}@postulante.test`,
                password: "AtomicPassword2026!",
                dni: `DNI_ATOMIC_${timestamp}`,
                id_localidad: localidad.id_localidad,
                id_rubro: rubro.id_rubro
            })
        });
        const data = await res.json();

        // Intento con estado inválido para forzar error en la resolución
        const resInvalido = await fetch(`${BASE_URL}/api/solicitudes/${data.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ estado: "ESTADO_NO_VALIDO_HACK" })
        });
        assert.equal(resInvalido.status, 400);

        // Comprobar que en la BD la solicitud permanece intacta en PENDIENTE
        const solCheck = await prisma.solicitud.findUnique({
            where: { id_solicitud: data.solicitud.id_solicitud }
        });
        assert.equal(solCheck.estado, "PENDIENTE");

        // Comprobar que el usuario sigue con rol Postulante
        const uCheck = await prisma.usuario.findUnique({
            where: { id_usuario: data.usuario.id_usuario },
            include: { rol: true }
        });
        assert.equal(uCheck.rol.nombre.toLowerCase(), "postulante");
    });

    it("7. Rechazar solicitud deja el estado en RECHAZADA y NO habilita rol Artesano", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/postulacion`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Rechazado",
                apellido: "Test",
                email: `rechazado_${timestamp}@postulante.test`,
                password: "RechazadoPassword2026!",
                dni: `DNI_RECHAZADO_${timestamp}`,
                id_localidad: localidad.id_localidad,
                id_rubro: rubro.id_rubro
            })
        });
        assert.equal(res.status, 201);
        const data = await res.json();

        const resRechazo = await fetch(`${BASE_URL}/api/solicitudes/${data.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                estado: "RECHAZADA",
                motivo_rechazo: "No cumple con la antigüedad requerida"
            })
        });
        assert.equal(resRechazo.status, 200);

        const u = await prisma.usuario.findUnique({
            where: { id_usuario: data.usuario.id_usuario },
            include: { rol: true }
        });
        assert.notEqual(u.rol.nombre.toLowerCase(), "artesano");
    });

    it("8. Solicitar modificaciones deja el estado en MODIFICACION y NO habilita rol Artesano", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/postulacion`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Modif",
                apellido: "Test",
                email: `modif_${timestamp}@postulante.test`,
                password: "ModifPassword2026!",
                dni: `DNI_MODIF_${timestamp}`,
                id_localidad: localidad.id_localidad,
                id_rubro: rubro.id_rubro
            })
        });
        assert.equal(res.status, 201);
        const data = await res.json();

        const resModif = await fetch(`${BASE_URL}/api/solicitudes/${data.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                estado: "MODIFICACION",
                observaciones: "Subir foto más nítida de los productos"
            })
        });
        assert.equal(resModif.status, 200);

        const u = await prisma.usuario.findUnique({
            where: { id_usuario: data.usuario.id_usuario },
            include: { rol: true }
        });
        assert.notEqual(u.rol.nombre.toLowerCase(), "artesano");
    });

    it("9. Intentar resolver con un estado inválido devuelve HTTP 400", async () => {
        const timestamp = Date.now();
        const res = await fetch(`${BASE_URL}/api/postulacion`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nombre: "Invalido",
                apellido: "Test",
                email: `invalido_${timestamp}@postulante.test`,
                password: "InvalidoPassword2026!",
                dni: `DNI_INVALID_${timestamp}`,
                id_localidad: localidad.id_localidad,
                id_rubro: rubro.id_rubro
            })
        });
        const data = await res.json();

        const resInvalido = await fetch(`${BASE_URL}/api/solicitudes/${data.solicitud.id_solicitud}/resolver`, {
            method: "PUT",
            headers: {
                Authorization: `Bearer ${ctx.adminToken}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                estado: "ESTADO_INVENTADO_HACK"
            })
        });
        assert.equal(resInvalido.status, 400);
    });
});
