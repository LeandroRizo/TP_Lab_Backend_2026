import { z } from "zod";

export const usuarioQuerySchema = z.object({
    email: z.string().trim().optional(),
    sortBy: z.enum(["email"]).default("email"),
    order: z.enum(["asc", "desc"]).default("asc"),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(10)
});
