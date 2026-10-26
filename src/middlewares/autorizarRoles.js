// Criterio 3: Middleware reutilizable de autorización por rol.
// Admite varios roles y responde 403 si ninguno coincide.
// Orden en ruta: autenticación → cuenta → rol → validación → controlador.
export const autorizarRoles = (...rolesPermitidos) => {
    return (req, res, next) => {
        if (!req.contextoUsuario) {
            return res.status(401).json({
                mensaje: "Credenciales inválidas"
            });
        }

        const rolUsuario = req.contextoUsuario.rol;

        const tienePermiso = rolesPermitidos.some(
            rolPermitido => rolPermitido.toLowerCase() === rolUsuario.toLowerCase()
        );

        if (!tienePermiso) {
            return res.status(403).json({
                mensaje: "No tiene permisos para realizar esta acción"
            });
        }

        next();
    };
};
