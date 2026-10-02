import { z } from "zod";

export const rolSchema = z.object({
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional()
});
