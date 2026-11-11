import { z } from "zod";

export const registroSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    // ATENCIÓN (Criterio 1.2): La contraseña NO se recorta con trim()
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres")
}).strict();

export const loginSchema = z.object({
    email: z.string().trim().email("El formato del email no es válido"),
    // ATENCIÓN (Criterio 1.2): La contraseña NO se recorta con trim()
    password: z.string().min(1, "La contraseña es obligatoria")
}).strict();

// Criterio 6: Postulación pública (no incluye rol, activo ni estado)
// Permite indicar localidad y provincia por nombre normalizable o por id_localidad numérico
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
    id_localidad: z.coerce.number().int().positive("El ID de localidad debe ser un entero positivo").optional(),
    localidad: z.string().trim().min(1, "El nombre de la localidad no puede estar vacío").optional(),
    provincia: z.string().trim().min(1, "El nombre de la provincia no puede estar vacío").optional(),
    id_rubro: z.coerce.number().int().positive("El ID de rubro debe ser un entero positivo").optional(),
    rubro: z.string().trim().min(1, "El nombre del rubro no puede estar vacío").optional(),
    observaciones: z.string().trim().optional()
}).strict().superRefine((data, ctx) => {
    if (data.localidad && !data.provincia) {
        ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Si se indica la localidad por nombre, la provincia es obligatoria",
            path: ["provincia"]
        });
    }
    if (data.provincia && !data.localidad) {
        ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Si se indica la provincia, la localidad es obligatoria",
            path: ["localidad"]
        });
    }
    if (!data.id_localidad && (!data.localidad || !data.provincia)) {
        ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Debe indicar la localidad (mediante localidad y provincia o id_localidad)",
            path: ["localidad"]
        });
    }
    if (!data.id_rubro && !data.rubro) {
        ctx.addIssue({
            code: z.ZodIssueCode.custom,
            message: "Debe indicar el rubro (mediante el nombre del rubro o id_rubro)",
            path: ["rubro"]
        });
    }
});
