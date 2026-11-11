import prisma from "../prisma.js";

// Criterio 2: Middleware que consulta la cuenta con req.usuario.id tras autenticar.
// Deja rol y estado (activo) vigentes en req.contextoUsuario.
// Cuenta inexistente → 401; inactiva → 403.
export const contextoUsuario = async (req, res, next) => {
    try {
        const usuario = await prisma.usuario.findUnique({
            where: { id_usuario: req.usuario.id },
            include: { rol: true, artesano: true }
        });

        if (!usuario) {
            return res.status(401).json({
                mensaje: "Credenciales inválidas"
            });
        }

        if (!usuario.activo) {
            return res.status(403).json({
                mensaje: "Cuenta desactivada"
            });
        }

        req.contextoUsuario = {
            id_usuario: usuario.id_usuario,
            nombre: usuario.nombre,
            email: usuario.email,
            id_rol: usuario.id_rol,
            activo: usuario.activo,
            rol: usuario.rol.nombre,
            artesano: usuario.artesano
        };

        next();
    } catch (error) {
        next(error);
    }
};
