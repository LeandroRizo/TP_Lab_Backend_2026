import { z } from "zod";

export const standSchema = z.object({
    id_zona: z.coerce.number().int().positive("La zona es obligatoria"),
    numero: z.coerce.number().int().positive("El número de stand debe ser positivo"),
    descripcion: z.string().trim().optional()
}).strict();
