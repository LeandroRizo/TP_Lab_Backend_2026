import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import bcrypt from "bcrypt";
import { PrismaClient } from "@prisma/client";
import { normalizarTexto } from "../src/utils/normalizarTexto.js";

const BCRYPT_SALT_ROUNDS = 10;
const prisma = new PrismaClient();

export async function ejecutarSeedExposicion(env = process.env) {
    const emailAdmin = env.SEED_ADMIN_EMAIL?.trim() || "admin@ponchodigital.gob.ar";
    const passwordAdmin = env.SEED_ADMIN_PASSWORD || "Admin1234!";

    console.log(`[Seed Exposición] Conectado a la base de datos: ${process.env.DATABASE_URL}`);
    console.log(`[Seed Exposición] Configurando administrador: ${emailAdmin}`);

    // 1. Roles del sistema (Postulante, Administrador, Artesano)
    const rolesIniciales = [
        { nombre: "Postulante", descripcion: "Usuario registrado o postulante pendiente de evaluación" },
        { nombre: "Administrador", descripcion: "Administrador general de la plataforma Poncho Digital" },
        { nombre: "Artesano", descripcion: "Artesano aprobado y habilitado para publicar productos" }
    ];

    const rolesMap = {};
    for (const r of rolesIniciales) {
        let rol = await prisma.rol.findFirst({
            where: { nombre: { equals: r.nombre, mode: "insensitive" } }
        });
        if (!rol) {
            rol = await prisma.rol.create({ data: r });
        }
        rolesMap[r.nombre] = rol;
    }
    console.log(`[Seed Exposición] Roles verificados/creados: ${Object.keys(rolesMap).join(", ")}`);

    // 2. Catálogo Oficial de Localidades (Georef INDEC / IGN)
    const dirData = path.resolve("prisma/data");
    let rutaLocalidades = null;

    if (fs.existsSync(dirData)) {
        const archivos = fs.readdirSync(dirData);
        for (const f of archivos) {
            const rutaCompleta = path.join(dirData, f);
            if (f === "localidades.json") {
                rutaLocalidades = rutaCompleta;
                break;
            }
            if (f.endsWith(".json")) {
                try {
                    const contenido = fs.readFileSync(rutaCompleta, "utf-8");
                    if (contenido.includes('"localidades"') && contenido.includes('"categoria"')) {
                        rutaLocalidades = rutaCompleta;
                        break;
                    }
                } catch {
                    // ignorar errores de lectura
                }
            }
        }
    }

    if (rutaLocalidades && fs.existsSync(rutaLocalidades)) {
        const rawJson = JSON.parse(fs.readFileSync(rutaLocalidades, "utf-8"));
        const listaBruta = rawJson.localidades || [];

        // Conservar "Localidad simple" y "Componente de localidad compuesta", excluir "Entidad"
        const localidadesValidas = listaBruta.filter((l) => l.categoria !== "Entidad");

        const registrosGeoref = localidadesValidas.map((l) => ({
            id_georef: String(l.id),
            nombre: l.nombre.trim(),
            departamento: l.departamento?.nombre ? l.departamento.nombre.trim() : null,
            provincia: l.provincia?.nombre ? l.provincia.nombre.trim() : null,
            latitud: l.centroide?.lat != null ? Number(l.centroide.lat) : null,
            longitud: l.centroide?.lon != null ? Number(l.centroide.lon) : null
        }));

        const conteoActual = await prisma.localidad.count();
        if (conteoActual === 0) {
            console.log(`[Seed Exposición] Importando ${registrosGeoref.length} localidades de Georef...`);
            const BATCH_SIZE = 500;
            for (let i = 0; i < registrosGeoref.length; i += BATCH_SIZE) {
                const lote = registrosGeoref.slice(i, i + BATCH_SIZE);
                await prisma.localidad.createMany({
                    data: lote,
                    skipDuplicates: true
                });
            }
            console.log(`[Seed Exposición] Localidades Georef importadas exitosamente.`);
        } else {
            console.log(`[Seed Exposición] Localidades ya existentes (${conteoActual}). No se duplican.`);
        }
    }

    // 3. Rubros artesanales oficiales
    const rubrosIniciales = [
        { nombre: "Textil", descripcion: "Tejidos tradicionales en fibra de vicuña, llama y oveja" },
        { nombre: "Cerámica", descripcion: "Alfarería y cerámica arqueológica y contemporánea" },
        { nombre: "Cestería y Fibra Vegetal", descripcion: "Tejidos en simbol, palma y totora" },
        { nombre: "Orfebrería y Platería", descripcion: "Joyería en plata, alpaca y rodocrosita" },
        { nombre: "Cuero y Talabartería", descripcion: "Trabajos tradicionales en cuero crudo y curtido" }
    ];

    for (const rub of rubrosIniciales) {
        const item = await prisma.rubro.findFirst({
            where: { nombre: { equals: rub.nombre, mode: "insensitive" } }
        });
        if (!item) {
            await prisma.rubro.create({ data: rub });
        }
    }
    console.log(`[Seed Exposición] Rubros artesanales verificados/creados.`);

    // 4. Categorías de productos
    const categoriasIniciales = [
        { nombre: "Ponchos y Mantas", descripcion: "Prendas mayores tejidas en telar criollo" },
        { nombre: "Chales y Bufandas", descripcion: "Accesorios textiles artesanales" },
        { nombre: "Piezas de Cerámica", descripcion: "Vasijas, cuencos y esculturas en barro cocido" },
        { nombre: "Joyería en Rodocrosita", descripcion: "Anillos, dijes y aros con piedra nacional" }
    ];

    for (const cat of categoriasIniciales) {
        const item = await prisma.categoria.findFirst({
            where: { nombre: { equals: cat.nombre, mode: "insensitive" } }
        });
        if (!item) {
            await prisma.categoria.create({ data: cat });
        }
    }
    console.log(`[Seed Exposición] Categorías de productos verificadas/creadas.`);

    // 5. Infraestructura Ferial: Pabellón, Zona y 5 Stands para la exposición
    let pabellon = await prisma.pabellon.findFirst({
        where: { nombre: { contains: "Peregrina", mode: "insensitive" } }
    });
    if (!pabellon) {
        pabellon = await prisma.pabellon.create({
            data: {
                numero: 1,
                nombre: "Pabellón Peregrina Zárate",
                descripcion: "Pabellón central de artesanos textiles y tradicionales"
            }
        });
    }

    let zona = await prisma.zona.findFirst({
        where: { id_pabellon: pabellon.id_pabellon, numero: 1 }
    });
    if (!zona) {
        zona = await prisma.zona.create({
            data: {
                id_pabellon: pabellon.id_pabellon,
                numero: 1,
                nombre: "Sector Norte - Textil",
                descripcion: "Sector destinado a tejedores tradicionales"
            }
        });
    }

    // Se precargan 5 stands (101 al 105) para asignar durante la exposición
    for (const numStand of [101, 102, 103, 104, 105]) {
        const existeStand = await prisma.stand.findFirst({
            where: { id_zona: zona.id_zona, numero: numStand }
        });
        if (!existeStand) {
            await prisma.stand.create({
                data: {
                    id_zona: zona.id_zona,
                    numero: numStand,
                    descripcion: `Stand artesanal N° ${numStand}`
                }
            });
        }
    }
    console.log(`[Seed Exposición] Infraestructura ferial (Pabellón, Zona y 5 Stands) verificada/creada.`);

    // 6. Única cuenta: Administrador General
    let adminUser = await prisma.usuario.findUnique({
        where: { email: emailAdmin }
    });

    if (!adminUser) {
        const passwordHash = await bcrypt.hash(passwordAdmin, BCRYPT_SALT_ROUNDS);
        adminUser = await prisma.usuario.create({
            data: {
                nombre: "Administrador Poncho Digital",
                email: emailAdmin,
                passwordHash,
                id_rol: rolesMap["Administrador"].id_rol,
                activo: true
            }
        });
        console.log(`[Seed Exposición] Cuenta Administrador creada exitosamente (${adminUser.email}).`);
    } else {
        console.log(`[Seed Exposición] Cuenta Administrador ya existente (${adminUser.email}). No se duplica.`);
    }

    // 7. Verificación de seguridad: CERO registros operativos precargados
    const conteoArtesanos = await prisma.artesano.count();
    const conteoSolicitudes = await prisma.solicitud.count();
    const conteoProductos = await prisma.producto.count();
    const conteoInscripciones = await prisma.inscripcion.count();
    const conteoUsuarios = await prisma.usuario.count();

    console.log(`[Seed Exposición] Estado operativo inicial:`);
    console.log(`  - Usuarios: ${conteoUsuarios} (solo el Administrador)`);
    console.log(`  - Artesanos: ${conteoArtesanos} (debe ser 0)`);
    console.log(`  - Solicitudes: ${conteoSolicitudes} (debe ser 0)`);
    console.log(`  - Productos: ${conteoProductos} (debe ser 0)`);
    console.log(`  - Inscripciones: ${conteoInscripciones} (debe ser 0)`);

    return {
        admin: {
            id_usuario: adminUser.id_usuario,
            email: adminUser.email
        },
        operativos: {
            artesanos: conteoArtesanos,
            solicitudes: conteoSolicitudes,
            productos: conteoProductos,
            inscripciones: conteoInscripciones
        }
    };
}

const rutaActual = fileURLToPath(import.meta.url);
const esEjecucionDirecta = process.argv[1] && path.resolve(process.argv[1]) === path.resolve(rutaActual);

if (esEjecucionDirecta) {
    ejecutarSeedExposicion()
        .then(() => {
            console.log("[Seed Exposición] Proceso finalizado con éxito.");
        })
        .catch((err) => {
            console.error("[Seed Exposición] Error en seed:", err);
            process.exit(1);
        })
        .finally(async () => {
            await prisma.$disconnect();
        });
}
