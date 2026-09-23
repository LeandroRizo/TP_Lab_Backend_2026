-- CreateTable
CREATE TABLE "Artesano" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "rubro" TEXT NOT NULL,
    "localidad" TEXT NOT NULL,

    CONSTRAINT "Artesano_pkey" PRIMARY KEY ("id")
);
