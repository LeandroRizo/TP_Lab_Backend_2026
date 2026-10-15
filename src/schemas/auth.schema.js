import { z } from "zod";

export const registroSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    // ATENCIÓN (Criterio 1.2): La contraseña NO se recorta con trim()
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres")
});

export const loginSchema = z.object({
    email: z.string().trim().email("El formato del email no es válido"),
    // ATENCIÓN (Criterio 1.2): La contraseña NO se recorta con trim()
    password: z.string().min(1, "La contraseña es obligatoria")
});
