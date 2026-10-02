import { z } from "zod";

export const zonaSchema = z.object({
    id_pabellon: z.coerce.number().int(),
    numero: z.coerce.number().int(),
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional()
});
