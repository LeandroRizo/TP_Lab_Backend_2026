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

// Criterio 6: Postulación pública
export const postulacionSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    apellido: z.string().trim().min(1, "El apellido es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    // La contraseña NO se recorta con trim()
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres"),
    dni: z.string().trim().min(1, "El DNI es obligatorio"),
    telefono: z.string().trim().optional(),
    direccion: z.string().trim().optional(),
    descripcion: z.string().trim().optional(),
    instagram: z.string().trim().optional(),
    id_localidad: z.coerce.number().int().positive("La localidad es obligatoria"),
    id_rubro: z.coerce.number().int().positive("El rubro es obligatorio"),
    observaciones: z.string().trim().optional()
});
