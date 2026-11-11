import { limpiarTokensRevocados } from "../services/auth.service.js";

// Criterio 2.7: Tarea periódica que borra registros con venceEn <= ahora
export const iniciarLimpiezaRevocaciones = (intervaloMs = 30 * 60 * 1000) => {
    // Ejecución inicial al arrancar el servidor
    limpiarTokensRevocados()
        .then((resultado) => {
            console.log(`[Limpieza de Tokens] Ejecución inicial: ${resultado.count} tokens eliminados.`);
        })
        .catch((error) => {
            console.error("[Limpieza de Tokens] Error en ejecución inicial:", error);
        });

    // Programación periódica (por defecto cada 30 minutos)
    const temporizador = setInterval(async () => {
        try {
            const resultado = await limpiarTokensRevocados();
            if (resultado && resultado.count > 0) {
                console.log(`[Limpieza de Tokens] Periódica: ${resultado.count} tokens eliminados.`);
            }
        } catch (error) {
            console.error("[Limpieza de Tokens] Error en tarea periódica:", error);
        }
    }, intervaloMs);

    // Evita que el temporizador impida que Node.js termine si no hay más tareas pendientes
    if (temporizador.unref) {
        temporizador.unref();
    }

    return temporizador;
};
