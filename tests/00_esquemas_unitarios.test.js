import { describe, it } from "node:test";
import assert from "node:assert/strict";
import fs from "node:fs";
import { productoSchema, productoActualizarSchema } from "../src/schemas/producto.schema.js";
import { registroSchema, loginSchema, postulacionSchema } from "../src/schemas/auth.schema.js";
import { resolverSolicitudSchema } from "../src/schemas/solicitud.schema.js";
import { estadoCuentaSchema } from "../src/schemas/cuenta.schema.js";
import { inscripcionSchema } from "../src/schemas/inscripcion.schema.js";
import { esquemas } from "../src/documentacion/esquemas.js";

describe("00. Pruebas Unitarias de Esquemas Zod (safeParse) y Contrato OpenAPI", () => {
    it("Criterio 2.3: Tabla de casos válidos e inválidos para productoSchema con safeParse (incluyendo rechazo de artesanoId e id_artesano)", () => {
        const tablaCasosProducto = [
            {
                nombreCaso: "Válido: producto completo con todos los campos permitidos",
                entrada: {
                    id_categoria: 1,
                    nombre: "Poncho de Vicuña",
                    descripcion: "Tejido artesanal en telar",
                    precio: 250000
                },
                esperadoValido: true
            },
            {
                nombreCaso: "Válido: producto sin descripción opcional",
                entrada: {
                    id_categoria: 2,
                    nombre: "Manta Catamarqueña",
                    precio: 85000
                },
                esperadoValido: true
            },
            {
                nombreCaso: "Inválido: campo adicional artesanoId rechazado en el alta de producto",
                entrada: {
                    id_categoria: 1,
                    nombre: "Poncho Intruso",
                    precio: 50000,
                    artesanoId: 99
                },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: campo adicional id_artesano rechazado en el alta de producto",
                entrada: {
                    id_categoria: 1,
                    nombre: "Poncho Intruso 2",
                    precio: 50000,
                    id_artesano: 99
                },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: nombre vacío",
                entrada: {
                    id_categoria: 1,
                    nombre: "   ",
                    precio: 10000
                },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: precio negativo o cero",
                entrada: {
                    id_categoria: 1,
                    nombre: "Poncho Precio Cero",
                    precio: -500
                },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: sin id_categoria obligatorio",
                entrada: {
                    nombre: "Poncho Sin Categoría",
                    precio: 15000
                },
                esperadoValido: false
            }
        ];

        for (const caso of tablaCasosProducto) {
            const resultado = productoSchema.safeParse(caso.entrada);
            assert.equal(
                resultado.success,
                caso.esperadoValido,
                `Fallo en caso '${caso.nombreCaso}': se esperaba success=${caso.esperadoValido}`
            );
        }
    });

    it("Criterio 2.3: Tabla de casos válidos e inválidos para registroSchema y postulacionSchema (rechaza rol, activo y estado)", () => {
        const tablaCasosRegistro = [
            {
                nombreCaso: "Válido: registro estándar",
                schema: registroSchema,
                entrada: { nombre: "Ana Gómez", email: "ana@correo.com", password: "Password123" },
                esperadoValido: true
            },
            {
                nombreCaso: "Inválido: registro intentando inyectar campo rol",
                schema: registroSchema,
                entrada: { nombre: "Ana Hack", email: "ana@correo.com", password: "Password123", rol: "Administrador" },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: registro intentando inyectar campo activo",
                schema: registroSchema,
                entrada: { nombre: "Ana Hack", email: "ana@correo.com", password: "Password123", activo: true },
                esperadoValido: false
            },
            {
                nombreCaso: "Inválido: postulación intentando fijar estado APROBADA",
                schema: postulacionSchema,
                entrada: {
                    nombre: "Pedro",
                    apellido: "Quiroga",
                    email: "pedro@correo.com",
                    password: "Password123",
                    dni: "30111222",
                    id_localidad: 1,
                    id_rubro: 1,
                    estado: "APROBADA"
                },
                esperadoValido: false
            }
        ];

        for (const caso of tablaCasosRegistro) {
            const resultado = caso.schema.safeParse(caso.entrada);
            assert.equal(
                resultado.success,
                caso.esperadoValido,
                `Fallo en caso '${caso.nombreCaso}': se esperaba success=${caso.esperadoValido}`
            );
        }
    });

    it("Criterio 2.3: Tabla de casos para resolverSolicitudSchema y estadoCuentaSchema con safeParse", () => {
        const tablaCasosResolucion = [
            { entrada: { estado: "APROBADA", observaciones: "Cumple requisitos" }, esperado: true },
            { entrada: { estado: "RECHAZADA", motivo_rechazo: "Falta documentación" }, esperado: true },
            { entrada: { estado: "MODIFICACION", observaciones: "Corregir DNI" }, esperado: true },
            { entrada: { estado: "PENDIENTE" }, esperado: false },
            { entrada: { estado: "CUALQUIER_OTRO" }, esperado: false },
            { entrada: { estado: "APROBADA", campoExtra: 123 }, esperado: false }
        ];

        for (const caso of tablaCasosResolucion) {
            const res = resolverSolicitudSchema.safeParse(caso.entrada);
            assert.equal(res.success, caso.esperado);
        }

        assert.equal(estadoCuentaSchema.safeParse({ activo: true }).success, true);
        assert.equal(estadoCuentaSchema.safeParse({ activo: false }).success, true);
        assert.equal(estadoCuentaSchema.safeParse({ activo: "true" }).success, false);
        assert.equal(productoActualizarSchema.safeParse({ nombre: "Nuevo Nombre", artesanoId: 1 }).success, false);
        assert.equal(loginSchema.safeParse({ email: "a@b.com", password: "123", rol: "Admin" }).success, false);
    });

    it("Criterio 1.2 y 1.6: Esquemas OpenAPI generados con z.toJSONSchema no exponen campos prohibidos y todos los $ref resuelven", () => {
        assert.ok(esquemas.ProductoEntrada);
        assert.equal(esquemas.ProductoEntrada.properties.artesanoId, undefined);
        assert.equal(esquemas.ProductoEntrada.properties.id_artesano, undefined);
        assert.equal(esquemas.RegistroEntrada.properties.rol, undefined);
        assert.equal(esquemas.RegistroEntrada.properties.activo, undefined);
        assert.equal(esquemas.PostulacionEntrada.properties.estado, undefined);
        assert.ok(esquemas.ErrorApi.example);

        const spec = JSON.parse(fs.readFileSync("./swagger-output.json", "utf8"));
        assert.equal(spec.components["@schemas"], undefined, "swagger-output.json no debe contener la clave no estándar @schemas");
        const raw = JSON.stringify(spec);
        const refs = [...raw.matchAll(/"\$ref":"([^"]+)"/g)].map(m => m[1]);
        assert.ok(refs.length > 0);
        for (const ref of refs) {
            const nombreEsquema = ref.replace("#/components/schemas/", "");
            assert.ok(
                spec.components?.schemas?.[nombreEsquema],
                `El $ref ${ref} no resuelve en components.schemas`
            );
        }
    });

    it("Criterio 1.6 (Auditoria 5.1, 5.2, 6.4): Coherencia de UsuarioPublico, StandUbicacionRespuesta, ArtesanoPublicoRespuesta y UsuarioEntrada con respuestas reales", () => {
        // UsuarioPublico: rol y artesano como objetos anidados
        assert.equal(esquemas.UsuarioPublico.properties.rol.type, "object");
        assert.ok(esquemas.UsuarioPublico.properties.rol.properties.id_rol);
        assert.ok(esquemas.UsuarioPublico.properties.rol.properties.nombre);
        assert.equal(esquemas.UsuarioPublico.properties.artesano.type, "object");
        assert.equal(esquemas.UsuarioPublico.properties.artesano.nullable, true);
        assert.equal(esquemas.UsuarioPublico.properties.passwordHash, undefined);

        // StandUbicacionRespuesta: propiedad artesano (no artesano_asignado)
        assert.ok(esquemas.StandUbicacionRespuesta.properties.artesano);
        assert.equal(esquemas.StandUbicacionRespuesta.properties.artesano_asignado, undefined);

        // ArtesanoPublicoRespuesta: no expone datos privados (dni, telefono, direccion)
        assert.ok(esquemas.ArtesanoPublicoRespuesta);
        assert.equal(esquemas.ArtesanoPublicoRespuesta.properties.dni, undefined);
        assert.equal(esquemas.ArtesanoPublicoRespuesta.properties.telefono, undefined);
        assert.equal(esquemas.ArtesanoPublicoRespuesta.properties.direccion, undefined);

        // UsuarioEntrada: recibe password (no passwordHash)
        assert.ok(esquemas.UsuarioEntrada.properties.password);
        assert.equal(esquemas.UsuarioEntrada.properties.passwordHash, undefined);
    });

    it("Validación de inscripcionSchema con safeParse: z.coerce.date(), rechazo de fecha inválida y .strict()", () => {
        // 1. Aceptación de fecha válida y conversión a instancia Date mediante z.coerce.date()
        const resultadoValido = inscripcionSchema.safeParse({
            id_artesano: 1,
            id_stand: 2,
            anio: 2026,
            fecha_solicitud: "2026-07-15T10:00:00.000Z",
            estado: "CONFIRMADA"
        });
        assert.equal(resultadoValido.success, true);
        assert.ok(resultadoValido.data.fecha_solicitud instanceof Date);
        assert.equal(resultadoValido.data.fecha_solicitud.toISOString(), "2026-07-15T10:00:00.000Z");

        // 2. Rechazo de una fecha inválida
        const resultadoFechaInvalida = inscripcionSchema.safeParse({
            id_artesano: 1,
            anio: 2026,
            fecha_solicitud: "fecha-no-valida-xyz",
            estado: "CONFIRMADA"
        });
        assert.equal(resultadoFechaInvalida.success, false);

        // 3. Rechazo de propiedades adicionales por .strict()
        const resultadoCampoExtra = inscripcionSchema.safeParse({
            id_artesano: 1,
            anio: 2026,
            fecha_solicitud: "2026-07-15T10:00:00.000Z",
            estado: "CONFIRMADA",
            propiedadNoPermitida: "intruso"
        });
        assert.equal(resultadoCampoExtra.success, false);
    });
});
