-- AlterTable
ALTER TABLE "Localidad" ADD COLUMN     "departamento" TEXT,
ADD COLUMN     "id_georef" TEXT,
ADD COLUMN     "latitud" DOUBLE PRECISION,
ADD COLUMN     "longitud" DOUBLE PRECISION,
ADD COLUMN     "provincia" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Localidad_id_georef_key" ON "Localidad"("id_georef");

-- CreateIndex
CREATE INDEX "Localidad_provincia_idx" ON "Localidad"("provincia");

-- CreateIndex
CREATE INDEX "Localidad_departamento_idx" ON "Localidad"("departamento");

-- CreateIndex
CREATE INDEX "Localidad_nombre_idx" ON "Localidad"("nombre");
