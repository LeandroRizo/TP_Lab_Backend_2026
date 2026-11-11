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

const { postulacionSchema } = await import("../src/schemas/auth.schema.js");
const { artesanoSchema } = await import("../src/schemas/artesano.schema.js");
const { resolverRubroPorNombre } = await import("../src/services/rubro.service.js");
const { normalizarTexto } = await import("../src/utils/normalizarTexto.js");

describe("08. Resolución de Rubros por Nombre y Normalización", () => {
    let adminToken;
    let rubroTextil;
    let rubroCeramica;
    let rubroOrfebreria;
    let rubroCuero;
    let localidadBelen;

    before(async () => {
        await limpiarBaseDeDatos();
        const tokens = await obtenerUsuariosPrueba();
        adminToken = tokens.adminToken;

        // Asegurar rubros maestros de prueba únicos
        rubroTextil = await prisma.rubro.findFirst({
            where: { nombre: { contains: "Textil", mode: "insensitive" } }
        });
        if (!rubroTextil) {
            rubroTextil = await prisma.rubro.create({ data: { nombre: "Textil", descripcion: "Tejidos tradicionales" } });
        }

        rubroCeramica = await prisma.rubro.findFirst({
            where: { nombre: { contains: "Cerámica", mode: "insensitive" } }
        });
        if (!rubroCeramica) {
            rubroCeramica = await prisma.rubro.create({ data: { nombre: "Cerámica", descripcion: "Alfarería tradicional" } });
        }

        rubroOrfebreria = await prisma.rubro.findFirst({
            where: { nombre: { contains: "Orfebrería", mode: "insensitive" } }
        });
        if (!rubroOrfebreria) {
            rubroOrfebreria = await prisma.rubro.create({ data: { nombre: "Orfebrería y Platería", descripcion: "Joyería y plata" } });
        }

        rubroCuero = await prisma.rubro.findFirst({
            where: { nombre: { contains: "Cuero", mode: "insensitive" } }
        });
        if (!rubroCuero) {
            rubroCuero = await prisma.rubro.create({ data: { nombre: "Cuero y Talabartería", descripcion: "Trabajos en cuero" } });
        }

        localidadBelen = await prisma.localidad.findFirst({
            where: { nombre: { contains: "Belén", mode: "insensitive" } }
        });
        if (!localidadBelen) {
            localidadBelen = await prisma.localidad.create({
                data: {
                    id_georef: "10028010",
                    nombre: "Belén",
                    departamento: "Belén",
                    provincia: "Catamarca",
                    latitud: -27.65,
                    longitud: -67.03
                }
            });
        }
    });

    after(async () => {
        await cerrarEntornoPrueba();
    });

    // =========================================================================
    // 1. PRUEBAS UNITARIAS: FUNCIÓN resolverRubroPorNombre
    // =========================================================================
    describe("1. Pruebas Unitarias: resolverRubroPorNombre", () => {
        it("1.1: 'Textil', 'TEXTIL', 'textil' y ' Téxtil ' resuelven al mismo rubro Textil", async () => {
            const variantes = ["Textil", "TEXTIL", "textil", " Téxtil ", "  textil  "];
            for (const v of variantes) {
                const res = await resolverRubroPorNombre(v);
                assert.ok(res, `Fallo en variante '${v}'`);
                assert.equal(res.id_rubro, rubroTextil.id_rubro);
                assert.equal(res.nombre, "Textil");
            }
        });

        it("1.2: 'Cerámica', 'ceramica' y 'CERÁMICA' resuelven al rubro Cerámica", async () => {
            const variantes = ["Cerámica", "ceramica", "CERÁMICA", "  Ceramica  "];
            for (const v of variantes) {
                const res = await resolverRubroPorNombre(v);
                assert.ok(res);
                assert.equal(res.id_rubro, rubroCeramica.id_rubro);
            }
        });

        it("1.3: 'Orfebrería' y 'Orfebrería y Platería' resuelven a 'Orfebrería y Platería'", async () => {
            const res1 = await resolverRubroPorNombre("Orfebrería");
            assert.equal(res1.id_rubro, rubroOrfebreria.id_rubro);

            const res2 = await resolverRubroPorNombre("Orfebrería y Platería");
            assert.equal(res2.id_rubro, rubroOrfebreria.id_rubro);

            const res3 = await resolverRubroPorNombre("  orfebreria  ");
            assert.equal(res3.id_rubro, rubroOrfebreria.id_rubro);
        });

        it("1.4: 'Cuero' y 'Cuero y Talabartería' resuelven a 'Cuero y Talabartería'", async () => {
            const res = await resolverRubroPorNombre("Cuero");
            assert.equal(res.id_rubro, rubroCuero.id_rubro);
        });

        it("1.5: Rubro inexistente 'Madera' arroja error con statusCode 400", async () => {
            await assert.rejects(
                async () => await resolverRubroPorNombre("Madera"),
                (err) => {
                    assert.equal(err.statusCode, 400);
                    assert.match(err.message, /No se encontró el rubro 'Madera'/i);
                    return true;
                }
            );
        });

        it("1.6: Rubro vacío o solo espacios arroja error 400", async () => {
            await assert.rejects(
                async () => await resolverRubroPorNombre(""),
                (err) => err.statusCode === 400
            );
            await assert.rejects(
                async () => await resolverRubroPorNombre("   "),
                (err) => err.statusCode === 400
            );
        });
    });

    // =========================================================================
    // 2. PRUEBAS UNITARIAS: ESQUEMAS ZOD (postulacionSchema y artesanoSchema)
    // =========================================================================
    describe("2. Pruebas Unitarias de Esquemas Zod", () => {
        it("2.1: postulacionSchema acepta 'rubro' como string", () => {
            const res = postulacionSchema.safeParse({
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana@test.com",
                password: "Password123!",
                dni: "28100999",
                localidad: "Belén",
                provincia: "Catamarca",
                rubro: "Textil"
            });
            assert.equal(res.success, true);
        });

        it("2.2: postulacionSchema mantiene compatibilidad con 'id_rubro' numérico", () => {
            const res = postulacionSchema.safeParse({
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana@test.com",
                password: "Password123!",
                dni: "28100998",
                id_localidad: 1,
                id_rubro: 1
            });
            assert.equal(res.success, true);
        });

        it("2.3: postulacionSchema rechaza rubro vacío o solo espacios", () => {
            const res1 = postulacionSchema.safeParse({
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana@test.com",
                password: "Password123!",
                dni: "28100997",
                localidad: "Belén",
                provincia: "Catamarca",
                rubro: ""
            });
            assert.equal(res1.success, false);

            const res2 = postulacionSchema.safeParse({
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana@test.com",
                password: "Password123!",
                dni: "28100997",
                localidad: "Belén",
                provincia: "Catamarca",
                rubro: "   "
            });
            assert.equal(res2.success, false);
        });

        it("2.4: postulacionSchema rechaza cuando no se envía ni 'rubro' ni 'id_rubro'", () => {
            const res = postulacionSchema.safeParse({
                nombre: "Ana",
                apellido: "Gómez",
                email: "ana@test.com",
                password: "Password123!",
                dni: "28100996",
                localidad: "Belén",
                provincia: "Catamarca"
            });
            assert.equal(res.success, false);
            assert.ok(res.error.issues.some((i) => i.path.includes("rubro")));
        });

        it("2.5: artesanoSchema acepta 'rubro' por nombre", () => {
            const res = artesanoSchema.safeParse({
                id_usuario: "11111111-1111-1111-1111-111111111111",
                nombre: "Pedro",
                apellido: "Soria",
                dni: "30111222",
                localidad: "Belén",
                provincia: "Catamarca",
                rubro: "Cerámica"
            });
            assert.equal(res.success, true);
        });
    });

    // =========================================================================
    // 3. PRUEBAS DE INTEGRACIÓN: POST /api/postulacion CON RESOLUCIÓN DE RUBRO
    // =========================================================================
    describe("3. Pruebas de Integración: POST /api/postulacion", () => {
        it("3.1: Registro con rubro 'Textil' resuelve id_rubro correspondiente y persiste en BD", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Carlos Alberto",
                    apellido: "Gómez",
                    email: "carlos.rubro.textil@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100201",
                    telefono: "3835401122",
                    direccion: "San Martín 450",
                    descripcion: "Tejedor tradicional en telar criollo",
                    instagram: "@belen_tejidos",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "Textil",
                    observaciones: "Postulación para stand"
                })
            });

            assert.equal(res.status, 201);
            const json = await res.json();
            assert.equal(json.artesano.id_rubro, rubroTextil.id_rubro);

            // Verificación directa en base de datos
            const artesanoBD = await prisma.artesano.findUnique({
                where: { id_artesano: json.artesano.id_artesano },
                include: { rubro: true }
            });
            assert.ok(artesanoBD);
            assert.equal(artesanoBD.id_rubro, rubroTextil.id_rubro);
            assert.equal(artesanoBD.rubro.nombre, "Textil");
        });

        it("3.2: Registro con rubro 'TEXTIL' en mayúsculas resuelve id_rubro de Textil", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Rosa",
                    apellido: "Medina",
                    email: "rosa.rubro.textil.mayus@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100202",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "TEXTIL"
                })
            });

            assert.equal(res.status, 201);
            const json = await res.json();
            assert.equal(json.artesano.id_rubro, rubroTextil.id_rubro);
        });

        it("3.3: Registro con rubro '  Téxtil  ' (con acento y espacios adicionales) resuelve id_rubro de Textil", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Elena",
                    apellido: "Páez",
                    email: "elena.rubro.espacios@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100203",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "   Téxtil   "
                })
            });

            assert.equal(res.status, 201);
            const json = await res.json();
            assert.equal(json.artesano.id_rubro, rubroTextil.id_rubro);
        });

        it("3.4: Registro con rubro 'Orfebrería' resuelve id_rubro de 'Orfebrería y Platería'", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Martín",
                    apellido: "Platero",
                    email: "martin.orfebreria@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100204",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "Orfebrería"
                })
            });

            assert.equal(res.status, 201);
            const json = await res.json();
            assert.equal(json.artesano.id_rubro, rubroOrfebreria.id_rubro);
        });

        it("3.5: Registro con rubro inexistente 'Madera' responde con HTTP 400 Bad Request", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Lucas",
                    apellido: "Carpintero",
                    email: "lucas.madera@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100205",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "Madera"
                })
            });

            assert.equal(res.status, 400);
            const json = await res.json();
            assert.match(json.error || json.mensaje || "", /No se encontró el rubro 'Madera'/i);
        });

        it("3.6: Registro con rubro vacío responde con HTTP 400 Bad Request por validación Zod", async () => {
            const res = await fetch(`${BASE_URL}/api/postulacion`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    nombre: "Lucas",
                    apellido: "SinRubro",
                    email: "lucas.sinrubro@ponchodigital.com",
                    password: "Password123!",
                    dni: "28100206",
                    localidad: "Belén",
                    provincia: "Catamarca",
                    rubro: "   "
                })
            });

            assert.equal(res.status, 400);
        });
    });

    // =========================================================================
    // 4. PRUEBAS DE INTEGRACIÓN: MODIFICACIÓN DE ARTESANO CON NOMBRE DE RUBRO
    // =========================================================================
    describe("4. Pruebas de Integración: PUT /api/artesanos/:id", () => {
        let artesanoCreado;

        before(async () => {
            const rolArtesano = await prisma.rol.findFirst({
                where: { nombre: { equals: "Artesano", mode: "insensitive" } }
            });

            const u = await prisma.usuario.create({
                data: {
                    nombre: "Usuario Artesano Actualizable",
                    email: "artesano.actualizable@ponchodigital.com",
                    passwordHash: "hash123",
                    id_rol: rolArtesano.id_rol,
                    activo: true
                }
            });

            artesanoCreado = await prisma.artesano.create({
                data: {
                    id_usuario: u.id_usuario,
                    nombre: "Joaquín",
                    apellido: "Ramos",
                    dni: "29999001",
                    id_localidad: localidadBelen.id_localidad,
                    id_rubro: rubroTextil.id_rubro
                }
            });
        });

        it("4.1: Admin modifica el rubro de un artesano enviando el nombre 'Cerámica'", async () => {
            const res = await fetch(`${BASE_URL}/api/artesanos/${artesanoCreado.id_artesano}`, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${adminToken}`
                },
                body: JSON.stringify({
                    id_usuario: artesanoCreado.id_usuario,
                    nombre: "Joaquín",
                    apellido: "Ramos",
                    dni: "29999001",
                    id_localidad: localidadBelen.id_localidad,
                    rubro: "Cerámica"
                })
            });

            assert.equal(res.status, 200);
            const json = await res.json();
            const idRubroDevuelto = json.id_rubro ?? json.data?.id_rubro;
            assert.equal(idRubroDevuelto, rubroCeramica.id_rubro);

            // Verificar en base de datos
            const actualizado = await prisma.artesano.findUnique({
                where: { id_artesano: artesanoCreado.id_artesano }
            });
            assert.equal(actualizado.id_rubro, rubroCeramica.id_rubro);
        });

        it("4.2: Admin intenta modificar con rubro inexistente 'Plásticos' y recibe HTTP 400", async () => {
            const res = await fetch(`${BASE_URL}/api/artesanos/${artesanoCreado.id_artesano}`, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${adminToken}`
                },
                body: JSON.stringify({
                    id_usuario: artesanoCreado.id_usuario,
                    nombre: "Joaquín",
                    apellido: "Ramos",
                    dni: "29999001",
                    id_localidad: localidadBelen.id_localidad,
                    rubro: "Plásticos"
                })
            });

            assert.equal(res.status, 400);
        });
    });
});
