import { z } from "zod";

// Criterio 5: El artesano del alta sale de la cuenta autenticada, nunca del body
export const productoSchema = z.object({
    id_categoria: z.coerce.number().int().positive("La categoría es obligatoria"),
    nombre: z.string().trim().min(1, "El nombre del producto es obligatorio"),
    descripcion: z.string().trim().optional(),
    precio: z.coerce.number().positive("El precio debe ser un número positivo"),
    id_artesano: z.coerce.number().int().optional() // Ignorado en el alta si viene en el body
});

export const productoActualizarSchema = productoSchema.partial();
