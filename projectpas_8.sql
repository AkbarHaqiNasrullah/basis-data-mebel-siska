CREATE DATABASE projectpas_8;

USE projectpas_8;

CREATE TABLE `projectpas_8`.`pekerja` (
  `id_pekerja` CHAR(6) NOT NULL,
  `nama_pekerja` VARCHAR(50) NOT NULL,
  `alamat` VARCHAR(200) NOT NULL,
  `jk` CHAR(1) NOT NULL,
  `tgl_lahir` CHAR(10) NOT NULL,
  `no_hp` CHAR(12) NOT NULL,
  PRIMARY KEY (`id_pekerja`));

CREATE TABLE `projectpas_8`.`toko` (
  `id_toko` CHAR(8) NOT NULL,
  `nama_toko` VARCHAR(50) NOT NULL,
  `no_telpon` CHAR(12) NOT NULL,
  `alamat` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_toko`));

CREATE TABLE `projectpas_8`.`produk` (
  `id_produk` CHAR(6) NOT NULL,
  `nama_produk` VARCHAR(50) NOT NULL,
  `jenis` VARCHAR(20) NOT NULL,
  `stok` INT(3) NOT NULL,
  `harga` CHAR(12) NOT NULL,
  PRIMARY KEY (`id_produk`));

CREATE TABLE `projectpas_8`.`pembelian` (
  `kd_pembelian` CHAR(6) NOT NULL,
  `id_pelanggan` CHAR(4) NOT NULL,
  `nama_produk` VARCHAR(50) NOT NULL,
  `jml_beli` INT(3) NOT NULL,
  `tgl_pembelian` CHAR(10) NOT NULL,
  `ekspedisi` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`kd_pembelian`));

CREATE TABLE `projectpas_8`.`pelanggan` (
  `id_pelanggan` CHAR(4) NOT NULL,
  `nama_pelanggan` VARCHAR(50) NOT NULL,
  `alamat` VARCHAR(200) NOT NULL,
  `no_hp` CHAR(12) NOT NULL,
  PRIMARY KEY (`id_pelanggan`));
  
INSERT INTO PEKERJA(id_pekerja, nama_pekerja, alamat, jk, tgl_lahir, no_hp)
	VALUES ("SKA001", "Aziz", "Jl. Sebengkok AL", "L", "20-07-85", "082246504327"),
		("SKA002", "Nia", "Jl. Rawasari", "P", "24-08-91", "081350382024"),
		("SKA003", "David", "Jl. Amal Baru", "L", "17-12-88", "085233264032"),
		("SKA004", "Nina", "Kampung Baru", "P", "06-04-94", "082165542031");

INSERT INTO TOKO(id_toko, nama_toko, no_telpon, alamat)
	VALUES ("TKSKA211", "Mebel Siska", "031 53170993", "Jl. Gunung Kerinci");
    
INSERT INTO PRODUK(id_produk, nama_produk, jenis, stok, harga)
	VALUES ("PS1241", "Pintu", "Merbau", "20", "850000"),
		("PS1242", "Lemari", "Jati", "15", "3000000"),
		("PS1243", "Meja", "Jati", "15", "1500000"),
		("PS1244", "Kursi", "Sungkai", "20", "600000"),
		("PS1245", "Kusen", "Meranti", "30", "310000");
        
INSERT INTO PEMBELIAN(kd_pembelian, id_pelanggan, nama_produk, jml_beli, tgl_pembelian, ekspedisi)
	VALUES ("B1876", "K508", "Pintu", "2", "07-05-22", "JNE"),
		("B1877", "K508", "Kusen", "2", "07-05-22", "JNE"),
		("B1880", "K510", "Lemari", "1", "07-05-22", "Langsung"),
		("B1881", "K510", "Meja", "1", "07-05-22", "Langsung"),
		("B1882", "K510", "Kursi", "4", "07-05-22", "Langsung"),
		("B1890", "K523", "Pintu", "1", "09-05-22", "Cargo"),
		("B1905", "K530", "Lemari", "2", "13-05-22", "Langsung"),
		("B1906", "K530", "Kursi", "2", "13-05-22", "Langsung");

INSERT INTO PELANGGAN(id_pelanggan, nama_pelanggan, alamat, no_hp)
	VALUES ("K508", "Waris", "Jl. Slamet Riyadi Kota Samarinda", "082246538963"),
		("K510", "Junaedi", "Jl. Gajah Mada Kota Tarakan", "081145790231"),
		("K523", "Sariyanti", "Jl. Jendral Sudirman Kota Makassar", "085287927651"),
		("K530", "Risna", "Jl. Mulawarman Kota Tarakan", "081298380504");


-- MODUL 7 (Subquery)
-- Scalar Subquery 
SELECT * FROM PRODUK 
WHERE jenis = (SELECT jenis FROM PRODUK WHERE id_produk = "PS1242");

SELECT * FROM PRODUK 
WHERE jenis = (SELECT jenis FROM PRODUK WHERE id_produk LIKE "%PS1242");


-- Multiple-Row Subquery 

-- Klausa IN
SELECT id_pelanggan, nama_pelanggan FROM PELANGGAN 
WHERE id_pelanggan IN (SELECT id_pelanggan FROM PEMBELIAN);

-- Klausa ANY
SELECT * FROM PRODUK
WHERE stok < ANY (SELECT stok FROM PRODUK WHERE harga = "600000");

-- Klausa ALL
SELECT * FROM PRODUK
WHERE stok < ALL (SELECT stok FROM PRODUK WHERE harga = "3000000");



-- MODUL 8 (Stored Procedure)
-- Query INSERT dalam Prosedur menggunakan Variabel dengan Parameter IN
DELIMITER //
 CREATE PROCEDURE Tambah_data_pelanggan(
    IN id_pelanggan CHAR(4),
    IN nama_pelanggan VARCHAR(50),
	IN alamat VARCHAR(200),
	IN no_hp CHAR(12)
   )
   BEGIN
   INSERT INTO PELANGGAN VALUES(id_pelanggan, nama_pelanggan, alamat, no_hp); 
 
   END //
DELIMITER ;
   
CALL Tambah_data_pelanggan("K540", "Aisyah", "Jl. Sei Brantas Kota Tarakan", "085230214582");

SELECT * FROM PELANGGAN;
