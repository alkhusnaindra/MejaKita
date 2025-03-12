-- CreateEnum
CREATE TYPE "StatusMeja" AS ENUM ('TERSEDIA', 'DIPESAN');

-- CreateEnum
CREATE TYPE "MetodeBayar" AS ENUM ('OFFLINE', 'ONLINE');

-- CreateEnum
CREATE TYPE "StatusBayar" AS ENUM ('PENDING', 'LUNAS', 'DIBATALKAN');

-- CreateEnum
CREATE TYPE "KategoriMenu" AS ENUM ('MAKANAN', 'MINUMAN');

-- CreateTable
CREATE TABLE "Meja" (
    "id" SERIAL NOT NULL,
    "uuid" TEXT NOT NULL,
    "status" "StatusMeja" NOT NULL DEFAULT 'TERSEDIA',

    CONSTRAINT "Meja_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Menu" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,
    "deskripsi" TEXT,
    "harga" INTEGER NOT NULL,
    "gambar" TEXT,
    "Kategori" "KategoriMenu" NOT NULL,

    CONSTRAINT "Menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pesanan" (
    "id" SERIAL NOT NULL,
    "mejaId" INTEGER NOT NULL,
    "totalHarga" INTEGER NOT NULL,
    "metodeBayar" "MetodeBayar" NOT NULL,
    "statusBayar" "StatusBayar" NOT NULL,
    "midtransOrderId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Pesanan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PesananItem" (
    "id" SERIAL NOT NULL,
    "pesananId" INTEGER NOT NULL,
    "menuId" INTEGER NOT NULL,
    "jumlah" INTEGER NOT NULL,
    "subtotal" INTEGER NOT NULL,

    CONSTRAINT "PesananItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Meja_uuid_key" ON "Meja"("uuid");

-- AddForeignKey
ALTER TABLE "Pesanan" ADD CONSTRAINT "Pesanan_mejaId_fkey" FOREIGN KEY ("mejaId") REFERENCES "Meja"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PesananItem" ADD CONSTRAINT "PesananItem_pesananId_fkey" FOREIGN KEY ("pesananId") REFERENCES "Pesanan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PesananItem" ADD CONSTRAINT "PesananItem_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
