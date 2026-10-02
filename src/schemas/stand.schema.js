import { z } from "zod";

export const standSchema = z.object({
    id_zona: z.coerce.number().int(),
    numero: z.coerce.number().int(),
    descripcion: z.string().trim().optional()
});
