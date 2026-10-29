import { z } from "zod";

export const standQuerySchema = z.object({
    numero: z.coerce.number().int().optional(),
    id_pabellon: z.coerce.number().int().optional(),
    pabellon: z.string().trim().optional(),
    id_zona: z.coerce.number().int().optional(),
    zona: z.string().trim().optional(),
    sector: z.string().trim().optional(),
    estado: z.enum(["DISPONIBLE", "OCUPADO", "LIBRE", "disponible", "ocupado", "libre"]).optional(),
    sortBy: z.enum(["numero", "created_at"]).default("numero"),
    order: z.enum(["asc", "desc"]).default("asc"),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(10)
});
