import { z } from "zod";

export const categoriaSchema = z.object({
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional()
});
