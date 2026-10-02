import { z } from "zod";

export const artesanoSchema = z.object({
    id_usuario: z.string().trim(),
    nombre: z.string().trim(),
    apellido: z.string().trim(),
    dni: z.string().trim(),
    telefono: z.string().trim().optional(),
    direccion: z.string().trim().optional(),
    descripcion: z.string().trim().optional(),
    instagram: z.string().trim().optional(),
    id_localidad: z.coerce.number().int(),
    id_rubro: z.coerce.number().int()
});
