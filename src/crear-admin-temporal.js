// Script administrativo auxiliar sin credenciales embebidas.
// Delega en las variables de entorno SEED_ADMIN_EMAIL y SEED_ADMIN_PASSWORD.
import { ejecutarSeed } from "../prisma/seed.js";
import prisma from "./prisma.js";

try {
    const resultado = await ejecutarSeed();
    console.log("Verificación de cuenta administradora completada:", resultado.admin);
} catch (error) {
    console.error("Error al verificar cuenta administradora:", error.message);
    process.exitCode = 1;
} finally {
    await prisma.$disconnect();
}
