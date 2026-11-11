import { z } from "zod";

// Criterio 5, 1.6 y 2.3: El artesano del alta sale de la cuenta autenticada, nunca del body.
// Se usa .strict() para rechazar cualquier campo adicional inyectado (como artesanoId o id_artesano).
export const productoSchema = z.object({
    id_categoria: z.coerce.number().int().positive("La categoría es obligatoria"),
    nombre: z.string().trim().min(1, "El nombre del producto es obligatorio"),
    descripcion: z.string().trim().optional(),
    precio: z.coerce.number().positive("El precio debe ser un número positivo")
}).strict();

export const productoActualizarSchema = productoSchema.partial().strict();
