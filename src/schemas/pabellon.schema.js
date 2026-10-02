import { z } from "zod";

export const pabellonSchema = z.object({
    numero: z.coerce.number().int(),
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional()
});
