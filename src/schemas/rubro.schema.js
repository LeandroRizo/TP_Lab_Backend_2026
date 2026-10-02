import { z } from "zod";

export const rubroSchema = z.object({
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional()
});
