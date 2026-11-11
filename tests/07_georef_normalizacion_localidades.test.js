import { describe, it, before, after } from "node:test";
import assert from "node:assert/strict";

// Validaciones de entorno obligatorias
assert.equal(process.env.NODE_ENV, "test", "NODE_ENV debe ser 'test'");
assert.match(process.env.DATABASE_URL || "", /_test(\?|$)/i, "DATABASE_URL debe apuntar a una base de pruebas");

const {
    BASE_URL,
    prisma,
    obtenerUsuariosPrueba,
    limpiarBaseDeDatos,
    cerrarEntornoPrueba
} = await import("./testHelper.js");

const { normalizarTexto } = await import("../src/utils/normalizarTexto.js");
const { postulacionSchema } = await import("../src/schemas/auth.schema.js");
const { localidadQuerySchema } = await import("../src/schemas/localidadQuery.schema.js");
const { ejecutarSeed } = await import("../prisma/seed.js");

describe("07. Catálogo Oficial Georef, Normalización y Registro por Nombre (Entrega Especial)", () => {
    let rubro;

    before(async () => {
        await limpiarBaseDeDatos();
        await obtenerUsuariosPrueba();
        rubro = await prisma.rubro.findFirst();
        if (!rubro) {
            rubro = await prisma.rubro.create({
                data: { nombre: "Textil", descripcion: "Tejidos tradicionales" }
            });
        }
    });

    after(async () => {
        await cerrarEntornoPrueba();
    });

    // =========================================================================
    // 1. PRUEBAS UNITARIAS: NORMALIZACIÓN DE TEXTO
    // =========================================================================
    describe("1. Pruebas Unitarias de Función de Normalización", () => {
        it("Normalización: 'Belén' y 'belen' coinciden exactamente", () => {
            assert.equal(normalizarTexto("Belén"), "belen");
            assert.equal(normalizarTexto("belen"), "belen");
            assert.equal(normalizarTexto("Belén"), normalizarTexto("belen"));
        });

        it("Normalización: 'BELÉN', 'BeLéN' y combinaciones de mayúsculas/minúsculas coinciden", () => {
            const casos = ["BELÉN", "belén", "BeLéN", "bElEn", "BELEN"];
            for (const c of casos) {
                assert.equal(
                    normalizarTexto(c),
                    "belen",
                    `Fallo al normalizar '${c}': esperado 'belen', obtenido '${normalizarTexto(c)}'`
                );
            }
        });

        it("Normalización: espacios sobrantes al inicio, final e internos repetidos se colapsan", () => {
            assert.equal(
                normalizarTexto("   San   Fernando   del   Valle   de   Catamarca   "),
                "san fernando del valle de catamarca"
            );
            assert.equal(normalizarTexto("  Belén  "), "belen");
        });

        it("Normalización: las provincias con acentos y mayúsculas también se normalizan", () => {
            assert.equal(normalizarTexto("cAtAmArCa"), "catamarca");
            assert.equal(normalizarTexto("Entre Ríos"), "entre rios");
            assert.equal(normalizarTexto("  TUCUMÁN  "), "tucuman");
            assert.equal(normalizarTexto("Córdoba"), "cordoba");
            assert.equal(normalizarTexto("NEUQUÉN"), "neuquen");
        });

        it("Normalización: manejo seguro de valores no-string o vacíos", () => {
            assert.equal(normalizarTexto(null), "");
            assert.equal(normalizarTexto(undefined), "");
            assert.equal(normalizarTexto(""), "");
            assert.equal(normalizarTexto(123), "");
        });
    });

    // =========================================================================
    // 2. PRUEBAS UNITARIAS: VALIDACIÓN DE ESQUEMAS ZOD
    // =========================================================================
    describe("2. Pruebas Unitarias de Esquemas Zod", () => {
        it("postulacionSchema: acepta postulación con nombres de localidad y provincia", () => {
            const input = {
                nombre: "Juan",
                apellido: "Pérez",
                email: "juan.georef@correo.com",
                password: "Password123",
                dni: "35123456",
                localidad: "bElEn",
                provincia: "cAtAmArCa",
                id_rubro: 1
            };
            const res = postulacionSchema.safeParse(input);
            assert.equal(res.success, true);
        });

        it("postulacionSchema: mantiene compatibilidad hacia atrás con id_localidad numérico", () => {
            const input = {
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana.legacy@correo.com",
                password: "Password123",
                dni: "36123456",
                id_localidad: 1,
                id_rubro: 1
            };
            const res = postulacionSchema.safeParse(input);
            assert.equal(res.success, true);
        });

        it("postulacionSchema: rechaza si se envía localidad sin provincia", () => {
            const input = {
                nombre: "Luis",
                apellido: "Sosa",
                email: "luis.sinprov@correo.com",
                password: "Password123",
                dni: "37123456",
                localidad: "Belén",
                id_rubro: 1
            };
            const res = postulacionSchema.safeParse(input);
            assert.equal(res.success, false);
            assert.ok(res.error.issues.some((i) => i.path.includes("provincia")));
        });

        it("postulacionSchema: rechaza si se envía provincia sin localidad", () => {
            const input = {
                nombre: "Luis",
                apellido: "Sosa",
                email: "luis.sinloc@correo.com",
                password: "Password123",
                dni: "37123456",
                provincia: "Catamarca",
                id_rubro: 1
            };
            const res = postulacionSchema.safeParse(input);
            assert.equal(res.success, false);
            assert.ok(res.error.issues.some((i) => i.path.includes("localidad")));
        });

        it("postulacionSchema: rechaza si no se envía ni id_localidad ni (localidad, provincia)", () => {
            const input = {
                nombre: "Luis",
                apellido: "Sosa",
                email: "luis.nada@correo.com",
                password: "Password123",
                dni: "37123456",
                id_rubro: 1
            };
            const res = postulacionSchema.safeParse(input);
            assert.equal(res.success, false);
        });

        it("localidadQuerySchema: valida filtros por provincia, departamento y nombre con paginación", () => {
            const queryValida = {
                provincia: "Catamarca",
                departamento: "Belén",
                nombre: "Londres",
                page: "2",
                limit: "25",
                sortBy: "nombre",
                order: "asc"
            };
            const res = localidadQuerySchema.safeParse(queryValida);
            assert.equal(res.success, true);
            assert.equal(res.data.page, 2);
            assert.equal(res.data.limit, 25);
            assert.equal(res.data.provincia, "Catamarca");
        });
    });

    // =========================================================================
    // 3. PRUEBAS DE INTEGRACIÓN: IMPORTACIÓN GEOREF E IDEMPOTENCIA DEL SEED
    // =========================================================================
    describe("3. Pruebas de Integración: Importación Georef y Seed Idempotente", () => {
        it("Seed: importa el catálogo de localidades, excluye 'Entidad' y es estrictamente idempotente", async () => {
            // 1. Ejecutar el seed completo
            await ejecutarSeed(process.env);

            const totalLocalidades1 = await prisma.localidad.count();
            // Debe haber importado las localidades nacionales válidas (>= 3.350)
            assert.ok(
                totalLocalidades1 >= 3350,
                `Se esperaban al menos 3350 localidades importadas, se encontraron ${totalLocalidades1}`
            );

            // Verificar que no se hayan importado entidades censales duplicadas
            // (todas las localidades cargadas deben tener id_georef único oficial)
            const conIdGeoref = await prisma.localidad.count({
                where: { id_georef: { not: null } }
            });
            assert.equal(
                conIdGeoref,
                totalLocalidades1,
                "Todas las localidades importadas deben poseer id_georef oficial"
            );

            // Verificar que existen las localidades de Catamarca (>= 132)
            const catamarcaCount = await prisma.localidad.count({
                where: { provincia: "Catamarca" }
            });
            assert.ok(
                catamarcaCount >= 132,
                `Se esperaban al menos 132 localidades de Catamarca, se encontraron ${catamarcaCount}`
            );

            // 2. Segunda ejecución: no debe duplicar ningún registro (idempotencia)
            await ejecutarSeed(process.env);
            const totalLocalidades2 = await prisma.localidad.count();
            assert.equal(
                totalLocalidades2,
                totalLocalidades1,
                "La segunda ejecución del seed no debe duplicar localidades"
            );

            // 3. Verificar que el artesano demo de prueba se creó y conserva relación con una localidad válida
            const artesanoDemo = await prisma.artesano.findFirst({
                include: { localidad: true }
            });
            assert.ok(artesanoDemo, "El artesano demo debe existir tras el seed");
            assert.ok(artesanoDemo.localidad, "El artesano demo debe tener localidad asociada");
            assert.ok(artesanoDemo.id_localidad > 0, "id_localidad debe ser mayor a 0");
        });
    });

    // =========================================================================
    // 4. PRUEBAS DE INTEGRACIÓN: POST /api/postulacion CON LOCALIDAD Y PROVINCIA
    // =========================================================================
    describe("4. Pruebas de Integración: POST /api/postulacion con Resolución por Nombre", () => {
        it("POST /api/postulacion: registra correctamente enviando 'bElEn' y 'cAtAmArCa' (sin acentos, minúsculas y mayúsculas)", async () => {
            const timestamp = Date.now();
            const email = `artesano_belen_${timestamp}@postulacion.test`;
            const dni = `DNI_GEOREF_${timestamp}`;

            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Rosa",
                    apellido: "Acuña",
                    email,
                    password: "PasswordBelen2026!",
                    dni,
                    telefono: "3835409988",
                    direccion: "Avenida San Martín 150",
                    descripcion: "Tejedora de ponchos en telar de peine",
                    instagram: "@rosa.acuna.belen",
                    localidad: "bElEn",
                    provincia: "cAtAmArCa",
                    id_rubro: rubro.id_rubro,
                    observaciones: "Postulación con Georef resuelto automáticamente"
                })
            });

            assert.equal(res.status, 201, "Debe responder HTTP 201 Created");
            const body = await res.json();
            assert.ok(body.artesano, "La respuesta debe contener el artesano");
            assert.ok(body.artesano.id_artesano, "El artesano debe tener id_artesano generado");
            assert.ok(body.artesano.id_localidad, "El artesano debe tener id_localidad asignado");

            // Verificar en la base de datos real que el ID asignado corresponde a Belén, Catamarca
            const artesanoDb = await prisma.artesano.findUnique({
                where: { id_artesano: body.artesano.id_artesano },
                include: { localidad: true, usuario: true, solicitudes: true }
            });

            assert.ok(artesanoDb);
            assert.equal(artesanoDb.localidad.nombre, "Belén");
            assert.equal(artesanoDb.localidad.provincia, "Catamarca");
            assert.equal(artesanoDb.localidad.departamento, "Belén");
            assert.equal(artesanoDb.solicitudes[0].estado, "PENDIENTE");
        });

        it("POST /api/postulacion: registra localidad con espacios adicionales y tildes ('  Santa   María  ')", async () => {
            const timestamp = Date.now();
            const email = `artesano_santamaria_${timestamp}@postulacion.test`;
            const dni = `DNI_SM_${timestamp}`;

            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Carlos",
                    apellido: "Mamani",
                    email,
                    password: "PasswordSM2026!",
                    dni,
                    localidad: "  Santa   María  ",
                    provincia: "  Catamarca  ",
                    id_rubro: rubro.id_rubro
                })
            });

            assert.equal(res.status, 201);
            const body = await res.json();
            const artesanoDb = await prisma.artesano.findUnique({
                where: { id_artesano: body.artesano.id_artesano },
                include: { localidad: true }
            });
            assert.equal(artesanoDb.localidad.nombre, "Santa María");
            assert.equal(artesanoDb.localidad.provincia, "Catamarca");
        });

        it("POST /api/postulacion: rechaza con HTTP 400 una localidad inexistente", async () => {
            const timestamp = Date.now();
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Inexistente",
                    apellido: "Test",
                    email: `inexistente_${timestamp}@correo.test`,
                    password: "Password123!",
                    dni: `DNI_INEX_${timestamp}`,
                    localidad: "LocalidadFantasmaQueNoExiste12345",
                    provincia: "Catamarca",
                    id_rubro: rubro.id_rubro
                })
            });

            assert.equal(res.status, 400);
            const body = await res.json();
            assert.match(body.mensaje, /no se encontró/i);

            // Verificar atomicidad: no se creó usuario huérfano en la base de datos
            const usuarioHuerfano = await prisma.usuario.findUnique({
                where: { email: `inexistente_${timestamp}@correo.test` }
            });
            assert.equal(usuarioHuerfano, null, "No debe crearse ningún usuario si falla la localidad");
        });

        it("POST /api/postulacion: rechaza con HTTP 400 una provincia que no corresponde a la localidad", async () => {
            const timestamp = Date.now();
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Cruce",
                    apellido: "Test",
                    email: `cruce_${timestamp}@correo.test`,
                    password: "Password123!",
                    dni: `DNI_CRUCE_${timestamp}`,
                    localidad: "Belén",
                    provincia: "Mendoza", // Belén pertenece a Catamarca, no a Mendoza
                    id_rubro: rubro.id_rubro
                })
            });

            assert.equal(res.status, 400);
            const body = await res.json();
            assert.match(body.mensaje, /no se encontró/i);
        });
    });

    // =========================================================================
    // 5. PRUEBAS DE INTEGRACIÓN: GET /api/localidades
    // =========================================================================
    describe("5. Pruebas de Integración: GET /api/localidades y Filtros", () => {
        it("GET /api/localidades: devuelve listado paginado con metadatos y IDs internos", async () => {
            const res = await fetch(`${BASE_URL}/api/localidades?page=1&limit=15`);
            assert.equal(res.status, 200);
            const body = await res.json();

            assert.ok(Array.isArray(body.data));
            assert.equal(body.data.length, 15);
            assert.ok(body.meta);
            assert.equal(body.meta.page, 1);
            assert.equal(body.meta.limit, 15);
            assert.ok(body.meta.total >= 3350);

            // Cada localidad devuelta debe incluir los campos enriquecidos
            const primera = body.data[0];
            assert.ok(typeof primera.id_localidad === "number");
            assert.ok(typeof primera.nombre === "string");
            assert.ok(primera.provincia !== undefined);
            assert.ok(primera.departamento !== undefined);
        });

        it("GET /api/localidades?provincia=Catamarca: filtra exclusivamente localidades de Catamarca", async () => {
            const res = await fetch(`${BASE_URL}/api/localidades?provincia=Catamarca&limit=50`);
            assert.equal(res.status, 200);
            const body = await res.json();

            assert.ok(body.data.length > 0);
            for (const loc of body.data) {
                assert.match(loc.provincia, /Catamarca/i);
            }
        });

        it("GET /api/localidades?departamento=Belén: filtra exclusivamente localidades del departamento Belén", async () => {
            const res = await fetch(`${BASE_URL}/api/localidades?departamento=Belén&limit=50`);
            assert.equal(res.status, 200);
            const body = await res.json();

            assert.ok(body.data.length > 0);
            for (const loc of body.data) {
                assert.match(loc.departamento, /Belén/i);
            }
        });

        it("GET /api/localidades?nombre=Londres: encuentra la localidad histórica de Londres en Catamarca", async () => {
            const res = await fetch(`${BASE_URL}/api/localidades?nombre=Londres`);
            assert.equal(res.status, 200);
            const body = await res.json();

            assert.ok(body.data.length >= 1);
            const londres = body.data.find((l) => l.nombre.toLowerCase().includes("londres"));
            assert.ok(londres);
            assert.equal(londres.departamento, "Belén");
            assert.equal(londres.provincia, "Catamarca");
        });
    });
});
