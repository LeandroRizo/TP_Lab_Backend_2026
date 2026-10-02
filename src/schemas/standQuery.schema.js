import { z } from "zod";

export const standQuerySchema = z.object({
    numero: z.coerce.number().int().optional(),
    sortBy: z.enum(["numero"]).default("numero"),
    order: z.enum(["asc", "desc"]).default("asc"),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(10)
});
