import { z } from "zod";

// El hashing de contraseñas se realiza en el servidor; nunca se acepta passwordHash desde el cliente
export const usuarioSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres"),
    id_rol: z.coerce.number().int().positive().optional(),
    activo: z.boolean().optional()
}).strict();

export const usuarioActualizarSchema = usuarioSchema.partial().strict();
