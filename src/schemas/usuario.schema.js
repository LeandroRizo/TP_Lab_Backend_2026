import { z } from "zod";

export const usuarioSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    passwordHash: z.string().optional(),
    id_rol: z.coerce.number().int().optional()
});
