# Punto de Restauración — Base de Exposición (Poncho Digital)

Este directorio contiene el respaldo inicial en frío y el script de siembra estructural para la base de datos `poncho_digital_exposicion`.

---

## 1. Archivos Disponibles

1. **`poncho_digital_exposicion_inicial.sql`**:
   - Respaldo completo generado con `pg_dump` sobre la base de datos limpia `poncho_digital_exposicion`.
   - Incluye DDL completo (tablas, relaciones, claves foráneas, índices), secuencias autoincrementales, datos maestros (3.350 localidades de Georef, 5 rubros, 4 categorías, 1 pabellón, 1 zona, 5 stands) y la cuenta única de Administrador (`admin@ponchodigital.gob.ar`).
   - Tablas operativas (`Artesano`, `Solicitud`, `Producto`, `Inscripcion`): **0 registros** (totalmente vacías, secuencias sin consumir).

2. **`seed-exposicion.backup.js`**:
   - Copia de seguridad del script `prisma/seed-exposicion.js`.
   - Idempotente, utiliza el catálogo Georef de `prisma/data/` y no crea artesanos ni solicitudes previas.

---

## 2. Diferencia entre Restaurar el Backup vs Ejecutar la Seed

| Característica | Restaurar Backup (`.sql` vía `psql`) | Re-ejecutar Seed (`npm run seed:exposicion`) |
| :--- | :--- | :--- |
| **Mecanismo** | Reemplazo físico a nivel motor PostgreSQL (`DROP TABLE ... / CREATE TABLE ...`). | Inserción condicional a nivel aplicación mediante Prisma ORM (`findFirst` / `create`). |
| **Registros operativos previos** | **Elimina automáticamente** cualquier artesano, solicitud, producto o inscripción generados en ensayos previos, devolviendo la base a 0. | **No borra registros**. Si ya creaste artesanos o solicitudes en Postman, estos se conservan. |
| **Contadores de ID (`SERIAL` / `SEQUENCE`)** | **Restablece las secuencias al estado virgen**. El próximo artesano y la próxima solicitud recibirán garantizadamente el **ID 1**. | **No retrocede las secuencias**. Si se crearon registros y se borraron a mano, los IDs continuarán incrementándose. |
| **Velocidad** | Instantáneo (menos de 2 segundos para las 3.350 localidades). | Requiere procesamiento JavaScript e iteración en Prisma. |
| **Uso recomendado** | **Ideal para reiniciar los ensayos de la exposición desde cero en un solo comando.** | Ideal para inicializar la base por primera vez o poblar datos faltantes sin afectar tablas. |

---

## 3. Comandos de Restauración Rápida

### Opción A: Restaurar el Backup SQL (Recomendado para reiniciar ensayos)

Para reiniciar la base `poncho_digital_exposicion` a su estado virgen antes de una práctica de exposición:

```powershell
# En PowerShell (reemplazar <PASSWORD_PG> por la clave de tu motor PostgreSQL local)
$env:PGPASSWORD="<PASSWORD_PG>"
& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -h localhost -p 5432 -d poncho_digital_exposicion -f "backups\exposicion\poncho_digital_exposicion_inicial.sql"
```

### Opción B: Re-ejecutar la Seed mediante Node.js / Prisma

```powershell
npm run seed:exposicion
```
