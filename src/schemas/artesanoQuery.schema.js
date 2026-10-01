import { z } from "zod";

export const artesanoQuerySchema = z.object({
    localidad: z.string().trim().optional(),
    rubro: z.string().trim().optional(),

    sortBy: z
        .enum(["nombre", "apellido", "rubro", "localidad"])
        .default("nombre"),

    order: z
        .enum(["asc", "desc"])
        .default("asc"),

    page: z.coerce
        .number()
        .int()
        .positive()
        .default(1),

    limit: z.coerce
        .number()
        .int()
        .positive()
        .max(100)
        .default(10)
});