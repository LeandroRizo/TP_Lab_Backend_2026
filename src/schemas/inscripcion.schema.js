import { z } from "zod";

export const inscripcionSchema = z.object({
    id_artesano: z.coerce.number().int(),
    id_stand: z.coerce.number().int().optional(),
    anio: z.coerce.number().int(),
    fecha_solicitud: z.coerce.date(),
    fecha_resolucion: z.coerce.date().optional(),
    estado: z.string().trim(),
    motivo_rechazo: z.string().trim().optional(),
    observaciones: z.string().trim().optional()
});
