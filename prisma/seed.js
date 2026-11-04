import path from "node:path";
import { fileURLToPath } from "node:url";
import bcrypt from "bcrypt";
import prisma from "../src/prisma.js";

const BCRYPT_SALT_ROUNDS = 10;

export async function ejecutarSeed(env = process.env) {
    const emailAdmin = env.SEED_ADMIN_EMAIL?.trim();
    const passwordAdmin = env.SEED_ADMIN_PASSWORD;
    const emailArtesano = env.SEED_ARTESANO_EMAIL?.trim();
    const passwordArtesano = env.SEED_ARTESANO_PASSWORD;

    const faltantes = [];
    if (!emailAdmin) faltantes.push("SEED_ADMIN_EMAIL");
    if (!passwordAdmin || passwordAdmin.length < 6) faltantes.push("SEED_ADMIN_PASSWORD (mínimo 6 caracteres)");
    if (!emailArtesano) faltantes.push("SEED_ARTESANO_EMAIL");
    if (!passwordArtesano || passwordArtesano.length < 6) faltantes.push("SEED_ARTESANO_PASSWORD (mínimo 6 caracteres)");

    if (faltantes.length > 0) {
        throw new Error(
            `Configuración de seed incompleta. Faltan o son inválidas las siguientes variables de entorno obligatorias: ${faltantes.join(", ")}`
        );
    }

    // 1. Roles base
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

    // 2. Localidades iniciales
    const localidadesIniciales = [
        "San Fernando del Valle de Catamarca",
        "Belén",
        "Santa María",
        "Tinogasta",
        "Andalgalá",
        "Valle Viejo"
    ];

    let primeraLocalidad = null;
    for (const nombreLoc of localidadesIniciales) {
        let loc = await prisma.localidad.findFirst({
            where: { nombre: { equals: nombreLoc, mode: "insensitive" } }
        });
        if (!loc) {
            loc = await prisma.localidad.create({ data: { nombre: nombreLoc } });
        }
        if (!primeraLocalidad) primeraLocalidad = loc;
    }

    // 3. Rubros artesanales iniciales
    const rubrosIniciales = [
        { nombre: "Textil", descripcion: "Tejidos tradicionales en fibra de vicuña, llama y oveja" },
        { nombre: "Cerámica", descripcion: "Alfarería y cerámica arqueológica y contemporánea" },
        { nombre: "Cestería y Fibra Vegetal", descripcion: "Tejidos en simbol, palma y totora" },
        { nombre: "Orfebrería y Platería", descripcion: "Joyería en plata, alpaca y rodocrosita" },
        { nombre: "Cuero y Talabartería", descripcion: "Trabajos tradicionales en cuero crudo y curtido" }
    ];

    let primerRubro = null;
    for (const rub of rubrosIniciales) {
        let item = await prisma.rubro.findFirst({
            where: { nombre: { equals: rub.nombre, mode: "insensitive" } }
        });
        if (!item) {
            item = await prisma.rubro.create({ data: rub });
        }
        if (!primerRubro) primerRubro = item;
    }

    // 4. Categorías de productos iniciales
    const categoriasIniciales = [
        { nombre: "Ponchos y Mantas", descripcion: "Prendas mayores tejidas en telar criollo" },
        { nombre: "Chales y Bufandas", descripcion: "Accesorios textiles artesanales" },
        { nombre: "Piezas de Cerámica", descripcion: "Vasijas, cuencos y esculturas en barro cocido" },
        { nombre: "Joyería en Rodocrosita", descripcion: "Anillos, dijes y aros con piedra nacional" }
    ];

    let primeraCategoria = null;
    for (const cat of categoriasIniciales) {
        let item = await prisma.categoria.findFirst({
            where: { nombre: { equals: cat.nombre, mode: "insensitive" } }
        });
        if (!item) {
            item = await prisma.categoria.create({ data: cat });
        }
        if (!primeraCategoria) primeraCategoria = item;
    }

    // 5. Pabellones, Zonas y Stands iniciales
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

    for (const numStand of [101, 102, 103]) {
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

    // 6. Cuenta Administradora de demostración (sin sobrescribir contraseña si ya existe)
    let adminUser = await prisma.usuario.findUnique({
        where: { email: emailAdmin },
        select: { id_usuario: true, nombre: true, email: true, id_rol: true, activo: true }
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
            },
            select: { id_usuario: true, nombre: true, email: true, id_rol: true, activo: true }
        });
    }

    // 7. Cuenta Artesano de demostración con solicitud aprobada y producto publicado (sin sobrescribir contraseña si ya existe)
    let artesanoUser = await prisma.usuario.findUnique({
        where: { email: emailArtesano },
        include: { artesano: true }
    });

    if (!artesanoUser) {
        const passwordHash = await bcrypt.hash(passwordArtesano, BCRYPT_SALT_ROUNDS);
        let dniDemo = "24888999";
        const dniOcupado = await prisma.artesano.findUnique({ where: { dni: dniDemo } });
        if (dniOcupado) {
            dniDemo = `24888999_${Date.now()}`;
        }

        artesanoUser = await prisma.usuario.create({
            data: {
                nombre: "Rosaura Quiroga",
                email: emailArtesano,
                passwordHash,
                id_rol: rolesMap["Artesano"].id_rol,
                activo: true,
                artesano: {
                    create: {
                        nombre: "Rosaura",
                        apellido: "Quiroga",
                        dni: dniDemo,
                        telefono: "3835401122",
                        direccion: "Calle San Martín 240, Belén",
                        descripcion: "Maestra tejedora en telar criollo con más de 20 años de trayectoria en la Fiesta del Poncho.",
                        instagram: "@rosaura.tejidos.belen",
                        id_localidad: primeraLocalidad.id_localidad,
                        id_rubro: primerRubro.id_rubro
                    }
                }
            },
            include: { artesano: true }
        });
    } else if (!artesanoUser.artesano) {
        let dniDemo = "24888999";
        const dniOcupado = await prisma.artesano.findUnique({ where: { dni: dniDemo } });
        if (dniOcupado) {
            dniDemo = `24888999_${Date.now()}`;
        }

        const perfilArtesano = await prisma.artesano.create({
            data: {
                id_usuario: artesanoUser.id_usuario,
                nombre: "Rosaura",
                apellido: "Quiroga",
                dni: dniDemo,
                telefono: "3835401122",
                direccion: "Calle San Martín 240, Belén",
                descripcion: "Maestra tejedora en telar criollo con más de 20 años de trayectoria en la Fiesta del Poncho.",
                instagram: "@rosaura.tejidos.belen",
                id_localidad: primeraLocalidad.id_localidad,
                id_rubro: primerRubro.id_rubro
            }
        });
        artesanoUser.artesano = perfilArtesano;
    }

    const idArtesanoDemo = artesanoUser.artesano.id_artesano;

    const solicitudExistente = await prisma.solicitud.findFirst({
        where: { id_artesano: idArtesanoDemo }
    });
    if (!solicitudExistente) {
        await prisma.solicitud.create({
            data: {
                id_artesano: idArtesanoDemo,
                estado: "APROBADA",
                observaciones: "Solicitud aprobada en carga inicial"
            }
        });
    }

    const productoExistente = await prisma.producto.findFirst({
        where: {
            id_artesano: idArtesanoDemo,
            nombre: "Poncho Catamarqueño de Llama"
        }
    });
    if (!productoExistente) {
        await prisma.producto.create({
            data: {
                id_artesano: idArtesanoDemo,
                id_categoria: primeraCategoria.id_categoria,
                nombre: "Poncho Catamarqueño de Llama",
                descripcion: "Poncho tradicional tejido a mano con lana hilada a huso y teñido con tintes naturales.",
                precio: 185000
            }
        });
    }

    return {
        admin: {
            id_usuario: adminUser.id_usuario,
            email: adminUser.email
        },
        artesano: {
            id_usuario: artesanoUser.id_usuario,
            email: artesanoUser.email,
            id_artesano: idArtesanoDemo
        }
    };
}

const rutaActual = fileURLToPath(import.meta.url);
const esEjecucionDirecta = process.argv[1] && path.resolve(process.argv[1]) === path.resolve(rutaActual);

if (esEjecucionDirecta) {
    console.log("Iniciando seed idempotente de Poncho Digital...");
    ejecutarSeed()
        .then(() => {
            console.log("Seed completado exitosamente.");
        })
        .catch((err) => {
            console.error("Error durante la ejecución del seed:", err.message);
            process.exit(1);
        })
        .finally(async () => {
            await prisma.$disconnect();
        });
}
