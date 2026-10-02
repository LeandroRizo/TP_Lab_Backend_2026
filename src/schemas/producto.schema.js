import { z } from "zod";

export const productoSchema = z.object({
    id_artesano: z.coerce.number().int(),
    id_categoria: z.coerce.number().int(),
    nombre: z.string().trim(),
    descripcion: z.string().trim().optional(),
    precio: z.coerce.number()
});
