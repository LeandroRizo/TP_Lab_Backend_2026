if (process.loadEnvFile) {
    try {
        process.loadEnvFile();
    } catch {
        // Si el archivo .env ya fue cargado o no existe en producción, se continúa con process.env
    }
}

const JWT_SECRET = process.env.JWT_SECRET;

if (!JWT_SECRET || JWT_SECRET.trim() === "") {
    console.error("ERROR CRÍTICO: La variable de entorno obligatoria 'JWT_SECRET' no está definida. Deteniendo el arranque del servidor.");
    process.exit(1);
}

export const config = {
    jwtSecret: JWT_SECRET,
    port: process.env.PORT || 3000,
    databaseUrl: process.env.DATABASE_URL
};

export default config;
