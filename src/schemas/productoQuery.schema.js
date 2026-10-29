import { z } from "zod";

export const productoQuerySchema = z.object({
    nombre: z.string().trim().optional(),
    id_categoria: z.coerce.number().int().optional(),
    id_artesano: z.coerce.number().int().optional(),
    precioMin: z.coerce.number().positive().optional(),
    precioMax: z.coerce.number().positive().optional(),
    sortBy: z.enum(["nombre", "precio", "created_at"]).default("nombre"),
    order: z.enum(["asc", "desc"]).default("asc"),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(10)
});
