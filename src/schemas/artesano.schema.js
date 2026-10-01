import { z } from "zod";

export const artesanoSchema = z.object({
    nombre: z.string().trim().min(1),
    apellido: z.string().trim().min(1),
    rubro: z.string().trim().min(1),
    localidad: z.string().trim().min(1)
});