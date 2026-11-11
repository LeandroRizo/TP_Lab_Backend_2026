import { z } from "zod";
import { registroSchema, loginSchema, postulacionSchema } from "../schemas/auth.schema.js";
import { crearAdminSchema, estadoCuentaSchema } from "../schemas/cuenta.schema.js";
import { artesanoSchema } from "../schemas/artesano.schema.js";
import { productoSchema, productoActualizarSchema } from "../schemas/producto.schema.js";
import { standSchema } from "../schemas/stand.schema.js";
import { resolverSolicitudSchema, asignarStandSchema } from "../schemas/solicitud.schema.js";
import { categoriaSchema } from "../schemas/categoria.schema.js";
import { localidadSchema } from "../schemas/localidad.schema.js";
import { rubroSchema } from "../schemas/rubro.schema.js";
import { pabellonSchema } from "../schemas/pabellon.schema.js";
import { zonaSchema } from "../schemas/zona.schema.js";
import { rolSchema } from "../schemas/rol.schema.js";
import { inscripcionSchema } from "../schemas/inscripcion.schema.js";
import { usuarioSchema, usuarioActualizarSchema } from "../schemas/usuario.schema.js";

// Criterio 1.2: Entradas convertidas desde los validadores con z.toJSONSchema(..., { target: "openapi-3.0", io: "input" })
export const esquemas = {
    // --- Esquemas de Entrada (desde Zod) ---
    RegistroEntrada: z.toJSONSchema(registroSchema, { target: "openapi-3.0", io: "input" }),
    LoginEntrada: z.toJSONSchema(loginSchema, { target: "openapi-3.0", io: "input" }),
    PostulacionEntrada: z.toJSONSchema(postulacionSchema, { target: "openapi-3.0", io: "input" }),
    CrearAdminEntrada: z.toJSONSchema(crearAdminSchema, { target: "openapi-3.0", io: "input" }),
    EstadoCuentaEntrada: z.toJSONSchema(estadoCuentaSchema, { target: "openapi-3.0", io: "input" }),
    ArtesanoEntrada: z.toJSONSchema(artesanoSchema, { target: "openapi-3.0", io: "input" }),
    ProductoEntrada: z.toJSONSchema(productoSchema, { target: "openapi-3.0", io: "input" }),
    ProductoActualizarEntrada: z.toJSONSchema(productoActualizarSchema, { target: "openapi-3.0", io: "input" }),
    StandEntrada: z.toJSONSchema(standSchema, { target: "openapi-3.0", io: "input" }),
    AsignarStandEntrada: z.toJSONSchema(asignarStandSchema, { target: "openapi-3.0", io: "input" }),
    ResolverSolicitudEntrada: z.toJSONSchema(resolverSolicitudSchema, { target: "openapi-3.0", io: "input" }),
    CategoriaEntrada: z.toJSONSchema(categoriaSchema, { target: "openapi-3.0", io: "input" }),
    LocalidadEntrada: z.toJSONSchema(localidadSchema, { target: "openapi-3.0", io: "input" }),
    RubroEntrada: z.toJSONSchema(rubroSchema, { target: "openapi-3.0", io: "input" }),
    PabellonEntrada: z.toJSONSchema(pabellonSchema, { target: "openapi-3.0", io: "input" }),
    ZonaEntrada: z.toJSONSchema(zonaSchema, { target: "openapi-3.0", io: "input" }),
    RolEntrada: z.toJSONSchema(rolSchema, { target: "openapi-3.0", io: "input" }),
    InscripcionEntrada: z.toJSONSchema(inscripcionSchema, { target: "openapi-3.0", io: "input", unrepresentable: "any" }),
    UsuarioEntrada: z.toJSONSchema(usuarioSchema, { target: "openapi-3.0", io: "input" }),
    UsuarioActualizarEntrada: z.toJSONSchema(usuarioActualizarSchema, { target: "openapi-3.0", io: "input" }),

    // --- Esquemas de Respuesta y Errores (con properties y required coherentes con los DTOs reales) ---
    ErrorApi: {
        type: "object",
        required: ["mensaje"],
        properties: {
            mensaje: {
                type: "string",
                description: "Descripción legible de la causa del error"
            },
            errores: {
                type: "array",
                description: "Detalle opcional de errores de validación por campo",
                items: {
                    type: "object",
                    properties: {
                        path: { type: "array", items: { type: "string" } },
                        message: { type: "string" }
                    }
                }
            }
        },
        example: {
            mensaje: "No tiene permisos para realizar esta acción"
        }
    },

    MetaPaginacion: {
        type: "object",
        required: ["total", "page", "limit", "totalPages", "hasNextPage", "hasPreviousPage"],
        properties: {
            total: { type: "integer", example: 25 },
            page: { type: "integer", example: 1 },
            limit: { type: "integer", example: 10 },
            totalPages: { type: "integer", example: 3 },
            hasNextPage: { type: "boolean", example: true },
            hasPreviousPage: { type: "boolean", example: false }
        }
    },

    UsuarioPublico: {
        type: "object",
        required: ["id_usuario", "nombre", "email", "id_rol", "activo"],
        properties: {
            id_usuario: { type: "string", format: "uuid", example: "a1b2c3d4-e5f6-7890-abcd-ef1234567890" },
            nombre: { type: "string", example: "Rosaura Quiroga" },
            email: { type: "string", format: "email", example: "artesano.belen@ponchodigital.gob.ar" },
            id_rol: { type: "integer", example: 3 },
            activo: { type: "boolean", example: true },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" },
            rol: {
                type: "object",
                required: ["id_rol", "nombre"],
                properties: {
                    id_rol: { type: "integer", example: 3 },
                    nombre: { type: "string", example: "Artesano" },
                    descripcion: { type: "string", nullable: true, example: "Artesano aprobado y habilitado para publicar productos" }
                }
            },
            artesano: {
                type: "object",
                nullable: true,
                required: ["id_artesano", "nombre", "apellido", "dni"],
                properties: {
                    id_artesano: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Rosaura" },
                    apellido: { type: "string", example: "Quiroga" },
                    dni: { type: "string", example: "24888999" }
                }
            }
        }
    },

    LoginRespuesta: {
        type: "object",
        required: ["token", "usuario"],
        properties: {
            token: { type: "string", description: "Token JWT firmado con HS256" },
            usuario: { $ref: "#/components/schemas/UsuarioPublico" }
        }
    },

    ArtesanoPublicoRespuesta: {
        type: "object",
        required: ["id_artesano", "nombre", "apellido", "id_localidad", "id_rubro"],
        properties: {
            id_artesano: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Rosaura" },
            apellido: { type: "string", example: "Quiroga" },
            descripcion: { type: "string", nullable: true, example: "Tejedora tradicional de vicuña y llama" },
            instagram: { type: "string", nullable: true, example: "@rosaura.tejidos.belen" },
            id_localidad: { type: "integer", example: 1 },
            id_rubro: { type: "integer", example: 1 },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" },
            localidad: {
                type: "object",
                nullable: true,
                properties: {
                    id_localidad: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Belén" }
                }
            },
            rubro: {
                type: "object",
                nullable: true,
                properties: {
                    id_rubro: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Textil" },
                    descripcion: { type: "string", nullable: true }
                }
            }
        }
    },

    ArtesanoRespuesta: {
        type: "object",
        required: ["id_artesano", "id_usuario", "nombre", "apellido", "dni", "id_localidad", "id_rubro"],
        properties: {
            id_artesano: { type: "integer", example: 1 },
            id_usuario: { type: "string", format: "uuid" },
            nombre: { type: "string", example: "Rosaura" },
            apellido: { type: "string", example: "Quiroga" },
            dni: { type: "string", example: "24888999" },
            telefono: { type: "string", nullable: true, example: "3835401122" },
            direccion: { type: "string", nullable: true, example: "Calle San Martín 240, Belén" },
            descripcion: { type: "string", nullable: true, example: "Tejedora tradicional de vicuña y llama" },
            instagram: { type: "string", nullable: true, example: "@rosaura.tejidos.belen" },
            id_localidad: { type: "integer", example: 1 },
            id_rubro: { type: "integer", example: 1 },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" }
        }
    },

    ListaArtesanosRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/ArtesanoPublicoRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    ProductoRespuesta: {
        type: "object",
        required: ["id_producto", "id_artesano", "id_categoria", "nombre", "precio"],
        properties: {
            id_producto: { type: "integer", example: 10 },
            id_artesano: { type: "integer", example: 1 },
            id_categoria: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Poncho de Vicuña Tradicional" },
            descripcion: { type: "string", nullable: true, example: "Tejido en telar criollo artesanal" },
            precio: { type: "number", example: 250000 },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" },
            artesano: { $ref: "#/components/schemas/ArtesanoPublicoRespuesta" }
        }
    },

    ListaProductosRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/ProductoRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    StandRespuesta: {
        type: "object",
        required: ["id_stand", "id_zona", "numero"],
        properties: {
            id_stand: { type: "integer", example: 1 },
            id_zona: { type: "integer", example: 1 },
            numero: { type: "integer", example: 101 },
            descripcion: { type: "string", nullable: true, example: "Stand esquina central" },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" },
            zona: {
                type: "object",
                nullable: true,
                properties: {
                    id_zona: { type: "integer", example: 1 },
                    id_pabellon: { type: "integer", example: 1 },
                    numero: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Sector Norte - Textil" },
                    pabellon: {
                        type: "object",
                        properties: {
                            id_pabellon: { type: "integer", example: 1 },
                            numero: { type: "integer", example: 1 },
                            nombre: { type: "string", example: "Pabellón Peregrina Zárate" }
                        }
                    }
                }
            }
        }
    },

    ListaStandsRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/StandRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    StandUbicacionRespuesta: {
        type: "object",
        required: ["id_stand", "numero", "pabellon", "sector", "coordenadas", "estado"],
        properties: {
            id_stand: { type: "integer", example: 1 },
            numero: { type: "integer", example: 101 },
            descripcion: { type: "string", nullable: true, example: "Stand artesanal N° 101" },
            estado: { type: "string", enum: ["DISPONIBLE", "OCUPADO"], example: "DISPONIBLE" },
            artesano: {
                type: "object",
                nullable: true,
                required: ["id_artesano", "nombre", "apellido"],
                properties: {
                    id_artesano: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Rosaura" },
                    apellido: { type: "string", example: "Quiroga" }
                }
            },
            pabellon: {
                type: "object",
                nullable: true,
                required: ["id_pabellon", "numero", "nombre"],
                properties: {
                    id_pabellon: { type: "integer", example: 1 },
                    numero: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Pabellón Peregrina Zárate" }
                }
            },
            sector: {
                type: "object",
                nullable: true,
                required: ["id_zona", "numero", "nombre"],
                properties: {
                    id_zona: { type: "integer", example: 1 },
                    numero: { type: "integer", example: 1 },
                    nombre: { type: "string", example: "Sector Norte - Textil" }
                }
            },
            coordenadas: {
                type: "object",
                required: ["lat", "lng", "x", "y"],
                properties: {
                    lat: { type: "number", example: -28.46868 },
                    lng: { type: "number", example: -65.78187 },
                    x: { type: "integer", example: 1312 },
                    y: { type: "integer", example: 95 }
                }
            }
        }
    },

    SolicitudRespuesta: {
        type: "object",
        required: ["id_solicitud", "id_artesano", "estado"],
        properties: {
            id_solicitud: { type: "integer", example: 1 },
            id_artesano: { type: "integer", example: 1 },
            estado: { type: "string", enum: ["PENDIENTE", "APROBADA", "RECHAZADA", "MODIFICACION"], example: "PENDIENTE" },
            motivo_rechazo: { type: "string", nullable: true },
            observaciones: { type: "string", nullable: true },
            created_at: { type: "string", format: "date-time" },
            updated_at: { type: "string", format: "date-time" }
        }
    },

    ListaSolicitudesRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/SolicitudRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    PostulacionRespuesta: {
        type: "object",
        required: ["usuario", "artesano", "solicitud"],
        properties: {
            usuario: { $ref: "#/components/schemas/UsuarioPublico" },
            artesano: { $ref: "#/components/schemas/ArtesanoRespuesta" },
            solicitud: { $ref: "#/components/schemas/SolicitudRespuesta" }
        }
    },

    // --- Esquemas de respuesta para Catálogos Auxiliares y Operaciones de Feria ---
    RolRespuesta: {
        type: "object",
        required: ["id_rol", "nombre", "created_at", "updated_at"],
        properties: {
            id_rol: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Administrador" },
            descripcion: { type: "string", nullable: true, example: "Administrador general de la plataforma Poncho Digital" },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.882Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.882Z" }
        }
    },

    ListaRolesRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/RolRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    CategoriaRespuesta: {
        type: "object",
        required: ["id_categoria", "nombre", "created_at", "updated_at"],
        properties: {
            id_categoria: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Ponchos y Mantas" },
            descripcion: { type: "string", nullable: true, example: "Prendas mayores tejidas en telar criollo" },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.892Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.892Z" }
        }
    },

    ListaCategoriasRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/CategoriaRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    LocalidadRespuesta: {
        type: "object",
        required: ["id_localidad", "nombre", "created_at", "updated_at"],
        properties: {
            id_localidad: { type: "integer", example: 1 },
            id_georef: { type: "string", nullable: true, example: "10007010" },
            nombre: { type: "string", example: "San Fernando del Valle de Catamarca" },
            departamento: { type: "string", nullable: true, example: "Capital" },
            provincia: { type: "string", nullable: true, example: "Catamarca" },
            latitud: { type: "number", nullable: true, example: -28.46957 },
            longitud: { type: "number", nullable: true, example: -65.78524 },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:59.597Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:59.597Z" }
        }
    },

    ListaLocalidadesRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/LocalidadRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    RubroRespuesta: {
        type: "object",
        required: ["id_rubro", "nombre", "created_at", "updated_at"],
        properties: {
            id_rubro: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Textil" },
            descripcion: { type: "string", nullable: true, example: "Tejidos tradicionales en fibra de vicuña, llama y oveja" },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.885Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.885Z" }
        }
    },

    ListaRubrosRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/RubroRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    PabellonRespuesta: {
        type: "object",
        required: ["id_pabellon", "numero", "nombre", "created_at", "updated_at"],
        properties: {
            id_pabellon: { type: "integer", example: 1 },
            numero: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Pabellón Peregrina Zárate" },
            descripcion: { type: "string", nullable: true, example: "Pabellón central de artesanos textiles y tradicionales" },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.896Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.896Z" }
        }
    },

    ListaPabellonesRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/PabellonRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    ZonaRespuesta: {
        type: "object",
        required: ["id_zona", "id_pabellon", "numero", "nombre", "created_at", "updated_at"],
        properties: {
            id_zona: { type: "integer", example: 1 },
            id_pabellon: { type: "integer", example: 1 },
            numero: { type: "integer", example: 1 },
            nombre: { type: "string", example: "Sector Norte - Textil" },
            descripcion: { type: "string", nullable: true, example: "Sector destinado a tejedores tradicionales" },
            created_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.899Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-08T23:05:23.899Z" }
        }
    },

    ListaZonasRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/ZonaRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    InscripcionRespuesta: {
        type: "object",
        required: [
            "id_inscripcion",
            "id_artesano",
            "anio",
            "fecha_solicitud",
            "estado",
            "created_at",
            "updated_at"
        ],
        properties: {
            id_inscripcion: { type: "integer", example: 1 },
            id_artesano: { type: "integer", example: 1 },
            id_stand: { type: "integer", nullable: true, example: 1 },
            anio: { type: "integer", example: 2026 },
            fecha_solicitud: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.109Z" },
            fecha_resolucion: { type: "string", format: "date-time", nullable: true, example: "2026-11-09T00:37:30.109Z" },
            estado: { type: "string", enum: ["PENDIENTE", "APROBADA", "RECHAZADA"], example: "APROBADA" },
            motivo_rechazo: { type: "string", nullable: true },
            observaciones: { type: "string", nullable: true, example: "Asignación directa por administrador" },
            created_at: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.112Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.112Z" }
        }
    },

    ListaInscripcionesRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/InscripcionRespuesta" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    },

    AsignarStandRespuesta: {
        type: "object",
        required: [
            "id_inscripcion",
            "id_artesano",
            "id_stand",
            "anio",
            "fecha_solicitud",
            "estado",
            "created_at",
            "updated_at",
            "stand",
            "artesano"
        ],
        properties: {
            id_inscripcion: { type: "integer", example: 1 },
            id_artesano: { type: "integer", example: 1 },
            id_stand: { type: "integer", example: 1 },
            anio: { type: "integer", example: 2026 },
            fecha_solicitud: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.109Z" },
            fecha_resolucion: { type: "string", format: "date-time", nullable: true, example: "2026-11-09T00:37:30.109Z" },
            estado: { type: "string", enum: ["APROBADA", "RECHAZADA", "PENDIENTE"], example: "APROBADA" },
            motivo_rechazo: { type: "string", nullable: true },
            observaciones: { type: "string", nullable: true, example: "Asignación directa por administrador" },
            created_at: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.112Z" },
            updated_at: { type: "string", format: "date-time", example: "2026-11-09T00:37:30.112Z" },
            stand: { $ref: "#/components/schemas/StandRespuesta" },
            artesano: { $ref: "#/components/schemas/ArtesanoRespuesta" }
        }
    },

    ListaUsuariosRespuesta: {
        type: "object",
        required: ["data", "meta"],
        properties: {
            data: {
                type: "array",
                items: { $ref: "#/components/schemas/UsuarioPublico" }
            },
            meta: { $ref: "#/components/schemas/MetaPaginacion" }
        }
    }
};

export default esquemas;
