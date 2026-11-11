import { z } from "zod";

/**
 * Esquema Zod para validar parámetros de ruta con identificadores numéricos enteros positivos.
 */
export const idParamSchema = z.object({
    id: z.coerce.number().int("El identificador debe ser un número entero").positive("El identificador debe ser un entero positivo")
});

/**
 * Esquema Zod para validar parámetros de ruta con identificadores de usuario en formato UUID.
 */
export const idUsuarioParamSchema = z.object({
    id: z.string().uuid("El identificador de usuario debe ser un UUID válido")
});
