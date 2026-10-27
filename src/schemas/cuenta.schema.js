import { z } from "zod";

// Criterio 7: Endpoints solo para admin - crear administradores y activar/desactivar cuentas
export const crearAdminSchema = z.object({
    nombre: z.string().trim().min(1, "El nombre es obligatorio"),
    email: z.string().trim().email("El formato del email no es válido"),
    // La contraseña no se recorta con trim()
    password: z.string().min(6, "La contraseña debe tener al menos 6 caracteres")
});

export const estadoCuentaSchema = z.object({
    activo: z.boolean({
        required_error: "El campo activo es obligatorio",
        invalid_type_error: "El campo activo debe ser un valor booleano (true o false)"
    })
});
