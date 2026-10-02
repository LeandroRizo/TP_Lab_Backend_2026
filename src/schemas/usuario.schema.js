import { z } from "zod";

export const usuarioSchema = z.object({
    email: z.string().trim(),
    passwordHash: z.string().trim(),
    id_rol: z.coerce.number().int()
});
