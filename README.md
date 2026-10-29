# Poncho Digital — API Backend 2026 (TP_Lab_Backend_2026)

Backend integral para la gestión de postulaciones, artesanos, productos, stands, inscripciones y reportes de la **Fiesta Nacional e Internacional del Poncho**.

## Alumnos

- **Leandro Lopez Rizo** — MU: 331
- **Maximiliano Braga** — MU: 328

---

## 1. Tecnologías y Requisitos

- **Node.js**: Versión `24.20.0 TLS` (compatible con Node.js `>= 20.x LTS` / ESM).
- **Express**: `5.x` (`5.2.1`).
- **Base de Datos**: PostgreSQL.
- **ORM**: Prisma ORM (`6.x` con driver adapter pg).
- **Validación de Datos**: Zod (`4.x`).
- **Autenticación y Criptografía**: JSON Web Tokens (`jsonwebtoken`) y `bcrypt` (10 rondas de salting).
- **Testing**: Test runner nativo de Node.js (`node:test` y `node:assert/strict`).

---

## 2. Configuración del Entorno (.env.example)

Crear un archivo `.env` en la raíz del proyecto tomando como referencia `.env.example`:

```env
PORT=3000
DATABASE_URL="postgresql://USUARIO:PASSWORD@localhost:5432/poncho_digital?schema=public"
JWT_SECRET="clave_secreta_jwt_poncho_2026_super_segura_min_32_caracteres"
NODE_ENV=development
```

> [!IMPORTANT]
> Si la variable `JWT_SECRET` no está definida o está vacía, el módulo `src/config/env.js` detiene de inmediato el arranque del servidor con código de salida 1 por seguridad.

---

## 3. Instalación y Base de Datos

```bash
# 1. Instalar dependencias del proyecto
npm install

# 2. Generar el cliente de Prisma
npx prisma generate

# 3. Aplicar migraciones existentes en PostgreSQL
npx prisma migrate deploy

# (Opcional en desarrollo) Sincronizar esquema y seed:
# npx prisma db push
```

---

## 4. Ejecución del Servidor

```bash
# Modo producción / estándar
npm start

# Modo desarrollo con auto-reload (watch)
npm run dev
```

El servidor quedará escuchando en `http://localhost:3000`.

---

## 5. Documentación Interactiva (Swagger / OpenAPI)

La API cuenta con documentación viva e interactiva basada en OpenAPI 3.0:

- **Swagger UI**: [http://localhost:3000/api-docs](http://localhost:3000/api-docs) (o `/docs`)
- **Especificación JSON**: [http://localhost:3000/api-docs/swagger.json](http://localhost:3000/api-docs/swagger.json)

Permite autenticar interactivamente mediante el botón **Authorize** con formato `Bearer <token>` y probar todos los endpoints de la API.

---

## 6. Pruebas Automatizadas

El proyecto incluye una suite de pruebas automatizadas reproducibles que cubren el 100% de los flujos obligatorios de seguridad, roles, postulaciones, productos propios, filtros de stands, ubicación y reportes:

```bash
npm test
```

### Cobertura de pruebas:
- `tests/01_auth_seguridad.test.js`: Registro, login, cuenta inactiva 401, token anterior 401, rol incorrecto 403, acceso anónimo 401 y logout por revocación selectiva de jti.
- `tests/02_productos_propiedad.test.js`: Consultas públicas, alta con identidad de artesano autenticada, listado de mis productos, actualización/eliminación de producto propio, y rechazo 404 para producto ajeno o inexistente.
- `tests/03_postulaciones.test.js`: Postulación pública transaccional (PENDIENTE), imposibilidad de operar productos como postulante, aprobación por admin (cambio a ARTESANO), rechazo/modificación sin cambio de rol, rechazo de resolución duplicada (409) y validación de estados admitidos.
- `tests/04_cuentas_admin.test.js`: Creación de administradores, activación/desactivación de cuentas (booleano validado) e imposibilidad de desactivar al último administrador activo (409 con protección de concurrencia).
- `tests/05_stands_filtros_ubicacion.test.js`: Filtros por pabellón, sector/zona y estado (DISPONIBLE/OCUPADO), endpoint de ubicación con coordenadas JSON y asignación de artesano a stand.
- `tests/06_reportes_tendencias_prisma.test.js`: Reportes administrativos consolidados, middleware de registro de búsquedas de visitantes, estadísticas de tendencias y traducción de errores Prisma (P2002 -> 409, P2025 -> 404).

---

## 7. Colección de Postman

El archivo `poncho_digital_postman_collection.json` ubicado en la raíz del repositorio contiene todos los endpoints organizados en carpetas:
1. Autenticación y Perfil
2. Postulaciones y Resolución
3. Gestión de Cuentas (Solo ADMIN)
4. Productos y Propiedad
5. Stands, Ubicaciones y Asignación
6. Reportes y Tendencias
7. Entidades Auxiliares (Categorías, Localidades, Rubros, Pabellones, Zonas, Roles)

---

## 8. Arquitectura y Reglas de Negocio

- **Arquitectura en Capas**: `Ruta → Middleware → Validador Zod → Controlador → Servicio → Prisma ORM`.
- **Orden de Middlewares**: `autenticar` → `contextoUsuario` → `autorizarRoles` → `validarEsquema` → `controlador`.
- **Manejo Centralizado de Errores**: `src/middlewares/errorHandler.js` intercepta errores personalizados, traduce códigos Prisma (`P2002` a `409 Conflict`, `P2025` a `404 Not Found`) y evita la fuga de información sensible.
