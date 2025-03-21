/*
  Warnings:

  - You are about to drop the column `Kategori` on the `Menu` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Pesanan` table. All the data in the column will be lost.
  - You are about to drop the column `metodeBayar` on the `Pesanan` table. All the data in the column will be lost.
  - You are about to drop the column `midtransOrderId` on the `Pesanan` table. All the data in the column will be lost.
  - You are about to drop the column `statusBayar` on the `Pesanan` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Pesanan` table. All the data in the column will be lost.
  - Added the required column `kategoriId` to the `Menu` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "StatusPesanan" AS ENUM ('DIPROSES', 'SELESAI', 'DIBATALKAN');

-- CreateEnum
CREATE TYPE "MetodePembayaran" AS ENUM ('OFFLINE', 'ONLINE');

-- CreateEnum
CREATE TYPE "StatusPembayaran" AS ENUM ('PENDING', 'SUCCESS', 'FAILED');

-- AlterTable
ALTER TABLE "Menu" DROP COLUMN "Kategori",
ADD COLUMN     "kategoriId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Pesanan" DROP COLUMN "createdAt",
DROP COLUMN "metodeBayar",
DROP COLUMN "midtransOrderId",
DROP COLUMN "statusBayar",
DROP COLUMN "updatedAt",
ADD COLUMN     "status" "StatusPesanan" NOT NULL DEFAULT 'DIPROSES';

-- DropEnum
DROP TYPE "KategoriMenu";

-- DropEnum
DROP TYPE "MetodeBayar";

-- DropEnum
DROP TYPE "StatusBayar";

-- CreateTable
CREATE TABLE "KategoriMenu" (
    "id" SERIAL NOT NULL,
    "nama" TEXT NOT NULL,

    CONSTRAINT "KategoriMenu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pembayaran" (
    "id" SERIAL NOT NULL,
    "pesananId" INTEGER NOT NULL,
    "metode" "MetodePembayaran" NOT NULL,
    "status" "StatusPembayaran" NOT NULL DEFAULT 'PENDING',
    "midtransId" TEXT
);

-- CreateIndex
CREATE UNIQUE INDEX "Pembayaran_pesananId_key" ON "Pembayaran"("pesananId");

-- CreateIndex
CREATE UNIQUE INDEX "Pembayaran_metode_key" ON "Pembayaran"("metode");

-- AddForeignKey
ALTER TABLE "Menu" ADD CONSTRAINT "Menu_kategoriId_fkey" FOREIGN KEY ("kategoriId") REFERENCES "KategoriMenu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pembayaran" ADD CONSTRAINT "Pembayaran_pesananId_fkey" FOREIGN KEY ("pesananId") REFERENCES "Pesanan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
