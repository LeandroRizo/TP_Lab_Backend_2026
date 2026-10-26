import { z } from "zod";

export const resolverSolicitudSchema = z.object({
    estado: z.string().trim().min(1, "El estado es obligatorio"),
    motivo_rechazo: z.string().trim().optional(),
    observaciones: z.string().trim().optional()
});

export const asignarStandSchema = z.object({
    id_artesano: z.coerce.number().int().positive("El ID del artesano es obligatorio"),
    id_stand: z.coerce.number().int().positive("El ID del stand es obligatorio").optional()
});

export const solicitudQuerySchema = z.object({
    estado: z.string().trim().optional(),
    sortBy: z.enum(["created_at", "estado"]).default("created_at"),
    order: z.enum(["asc", "desc"]).default("desc"),
    page: z.coerce.number().int().positive().default(1),
    limit: z.coerce.number().int().positive().max(100).default(10)
});
