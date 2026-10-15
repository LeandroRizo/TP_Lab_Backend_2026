-- AlterTable
ALTER TABLE "Usuario" ADD COLUMN     "nombre" TEXT NOT NULL DEFAULT '',
ALTER COLUMN "id_rol" SET DEFAULT 2;

-- CreateTable
CREATE TABLE "TokenRevocado" (
    "jti" TEXT NOT NULL,
    "venceEn" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TokenRevocado_pkey" PRIMARY KEY ("jti")
);
