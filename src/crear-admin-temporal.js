
import bcrypt from "bcrypt";
import prisma from "./prisma.js";

try {
  const passwordHash = await bcrypt.hash("AdminTemporal123!", 10);

  let rol = await prisma.rol.findFirst({
    where: {
      nombre: { equals: "Administrador", mode: "insensitive" }
    }
  });

  if (!rol) {
    rol = await prisma.rol.create({
      data: {
        nombre: "Administrador",
        descripcion: "Administrador temporal para pruebas"
      }
    });
  }

  const admin = await prisma.usuario.upsert({
    where: { email: "admin.prueba@example.com" },
    update: {
      passwordHash,
      id_rol: rol.id_rol,
      activo: true
    },
    create: {
      nombre: "Admin Prueba",
      email: "admin.prueba@example.com",
      passwordHash,
      id_rol: rol.id_rol,
      activo: true
    },
    select: {
      id_usuario: true,
      email: true,
      id_rol: true,
      activo: true
    }
  });

  console.log("Administrador de prueba creado:", admin);
} catch (error) {
  console.error(error);
} finally {
  await prisma.$disconnect();
}
