import { z } from "zod";

export const artesanoSchema = z.object({
    id_usuario: z.string().trim().min(1, "El ID de usuario es obligatorio"),
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    apellido: z.string().trim().min(1, "El apellido es obligatorio"),
    dni: z.string().trim().min(1, "El DNI es obligatorio"),
    telefono: z.string().trim().optional(),
    direccion: z.string().trim().optional(),
    descripcion: z.string().trim().optional(),
    instagram: z.string().trim().optional(),
    id_localidad: z.coerce.number().int().positive("La localidad es obligatoria"),
    id_rubro: z.coerce.number().int().positive("El rubro es obligatorio")
}).strict();
