-- AlterTable
ALTER TABLE "Usuario" ADD COLUMN "nombre" TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE "Usuario" ALTER COLUMN "id_rol" SET DEFAULT 2;
