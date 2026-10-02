import { z } from "zod";

export const localidadSchema = z.object({
    nombre: z.string().trim()
});
