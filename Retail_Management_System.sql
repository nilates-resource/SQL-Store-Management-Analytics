CREATE DATABASE Magaza
USE Magaza

SET DATEFORMAT dmy; 

CREATE TABLE UrunTurlerý(
	ID INT PRIMARY KEY IDENTITY(1,1),
	TurAdi VARCHAR(100) not null
)

CREATE TABLE Tedarikciler(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Adi VARCHAR(100),
	Soyadi VARCHAR(100),
	TelefonNosu CHAR(11) unique not null,
	Sehri VARCHAR(200) 
)

CREATE TABLE Urunler(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Adi VARCHAR(100) not null,
	Markasi VARCHAR(100) not null,
	Rengi VARCHAR(50),
	Fiyatý FLOAT CHECK (Fiyatý > 0) not null,
	Maliyeti INT DEFAULT 0,
	UrunTuruID INT FOREIGN KEY REFERENCES UrunTurlerý(ID),
	TedarikciID INT FOREIGN KEY REFERENCES Tedarikciler(ID)
	)

CREATE TABLE CalisanGorevi(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Gorev VARCHAR(100)
)

CREATE TABLE Calisanlar(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Adi VARCHAR(100),
	Soyadi VARCHAR(100),
	TelefonNosu CHAR(11) unique,
	TcKimlik CHAR(11) unique not null,
	CalisanGoreviID INT FOREIGN KEY REFERENCES CalisanGorevi(ID)
)

CREATE TABLE Musteri(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Adi VARCHAR(100),
	Soyadi VARCHAR(100),
	TelefonNosu CHAR(11) unique,
	AldigiUrunID INT FOREIGN KEY REFERENCES Urunler(ID),
	ToplamSepetTutarý FLOAT DEFAULT 0 CHECK (ToplamSepetTutarý >= 0)
)

CREATE TABLE Stok(
	ID INT PRIMARY KEY IDENTITY(1,1),
	TedarikciID INT FOREIGN KEY REFERENCES Tedarikciler(ID),
	UrunTuRUID INT FOREIGN KEY REFERENCES UrunTurlerý(ID),
	UrunID INT FOREIGN KEY REFERENCES Urunler(ID),
	Miktar INT DEFAULT 0 CHECK(Miktar >= 0),
	IslemTuru BIT, 
	ToplamUrunSayisi INT CHECK (ToplamUrunSayisi >= 0),
	GirisZamani smalldatetime DEFAULT GETDATE() NOT NULL,
	CikisZamani smalldatetime DEFAULT GETDATE()
)

CREATE TABLE Satis(
	ID INT PRIMARY KEY IDENTITY(1,1),
	SatisTarihi datetime DEFAULT GETDATE(),
	UrunID INT FOREIGN KEY REFERENCES Urunler(ID),
	MusteriID INT FOREIGN KEY REFERENCES Musteri(ID),
	Miktar INT DEFAULT 0 NOT NULL CHECK (Miktar >= 0)
)

CREATE TABLE GiderTurleri(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Adi VARCHAR(50) NOT NULL,
	GiderTarihi DATE,
	FaturaNo INT unique,
	FirmaAdi VARCHAR(50) not null,
	MalzemeMiktari INT CHECK (MalzemeMiktari >= 0)
)

CREATE TABLE Giderler(
	ID INT PRIMARY KEY IDENTITY(1,1),
	UrunID INT FOREIGN KEY REFERENCES Urunler(ID),
	GiderTuruID INT FOREIGN KEY REFERENCES GiderTurleri(ID),
	Tutar FLOAT NOT NULL CHECK (Tutar >= 0 ),
	Tarih DATE DEFAULT GETDATE(),
	Aciklama VARCHAR(200)
)


INSERT INTO UrunTurlerý
VALUES
('Ruj'),
('Dudak Kalemi'),
('Maskara'),
('Eyeliner'),
('Ruj')

INSERT INTO Tedarikciler(Adi, Soyadi, TelefonNosu, Sehri)
VALUES
('Nil', 'Ateþ', 5533333333, 'Ýstanbul'),
('Can', 'Ateþ', 5533333321, 'Ýstanbul'),
('Deniz', 'Kara', 5544444444, 'Sakarya'),
('Kübra', 'Saner', 5543333333, 'Adana'),
('Ýrem', 'Özdemir', 5535885858, 'Sivas');

INSERT INTO Urunler (Adi, Markasi, Rengi, Fiyatý)
VALUES
('Russian Red', 'Romand', 'Kýrmýzý', 1500),
('Latte', 'Tarte', 'Kahverengi', 1200),
('Black', 'YSL', 'Siyah', 2700),
('Onyx', 'Beaulis', 'Siyah', 200),
('Red', 'Maybelline', 'Kýrmýzý', 600);

INSERT INTO CalisanGorevi (Gorev)
VALUES
('Satýþ'),
('Kasa'),
('Depo'),
('Düzen'),
('Satýþ');

INSERT INTO Calisanlar (Adi, Soyadi, TelefonNosu, TcKimlik)
VALUES
('Ezgi', 'Yýldýrým', 05553988854, 51515151522),
('Nisan', 'Yalnýz',  05317551515, 14144444141),
('Ayþe', 'Erman',   05374848758, 15121333121),
('Berrak','Kara',   05383877753, 14111554112),
('Yiðit', 'Egeli',  05341231145, 45454879444);


INSERT INTO Musteri (Adi, Soyadi, TelefonNosu, ToplamSepetTutarý)
VALUES
('Zeynep', 'Aydýn', '05551234567', 850),
('Egemen', 'Topuz', '05559874562', 1200),
('Merve', 'Yýldýz', '05557894561', 450),
('Ceren', 'Yalçýn', '05558741236', 1750),
('Efe', 'Arslan', '05559881122', 410)

INSERT INTO Stok (UrunID, UrunTuruID, TedarikciID, Miktar, IslemTuru, ToplamUrunSayisi, GirisZamani, CikisZamani)
VALUES
(1, 1, 1, 1700, 1, 78, '20250421', '20250422'),
(2, 2, 2, 200, 2, 20, '20251104', '20251204'),
(3, 3, 3, 500, 1, 50, '20251005', '20251201'),
(4, 4, 4, 300, 2, 55, '20250911', '20251009'),
(5, 5, 5, 700, 1, 73, '20250803', '20251130');

INSERT INTO Satis (UrunID, MusteriID, SatisTarihi, Miktar)
VALUES
(1, 1, 2025-07-07, 700),
(2, 2 ,2025-12-05, 800),
(3, 3, 2025-09-17, 850),
(4, 4,2025-04-28, 940),
(5, 5,2025-06-19, 684)


INSERT INTO GiderTurleri (Adi, GiderTarihi, FaturaNo, FirmaAdi, MalzemeMiktari)
VALUES
('Kira',        '2025-11-05', 101, 'Dükkan Sahibi', 0),
('Elektrik',    '2025-12-10', 102, 'Belediye', 0),
('Su',          '2025-11-12', 103, 'ÝSKÝ', 0),
('Ambalaj',     '2025-10-15', 104, 'Ambalajcý', 500),
('Temizlik',    '2025-10-17', 105, 'Temizlik Þirketi', 120);


INSERT INTO Giderler (UrunID , GiderTuruID,Tutar, Tarih, Aciklama)
VALUES
(1, 1, 25000, '2025-01-05', 'Aylýk maðaza kirasý'),
(2, 2, 1800,  '2025-01-10', 'Elektrik faturasý'),
(3, 3, 450,   '2025-01-12', 'Su faturasý'),
(4, 4, 3500,  '2025-01-15', 'Ambalaj malzemesi alýmý'),
(5, 5, 900,   '2025-01-17', 'Maðaza temizlik gideri');

CREATE VIEW vw_EnCokSatilanUrunu
AS
SELECT
    U.ID,
    U.Adi,
    U.Markasi,
    U.Rengi,
    U.Fiyatý,
    SUM(S.Miktar) AS ToplamSatis
FROM Urunler U
JOIN Satis S ON U.ID = S.UrunID
GROUP BY 
    U.ID,
    U.Adi,
    U.Markasi,
    U.Rengi,
    U.Fiyatý;

select * from vw_EnCokSatilanUrunu


CREATE VIEW vw_SonAltiAyGelenUrunler
AS
SELECT 
	U.ID,
    U.Adi,
    S.Miktar,
    S.GirisZamani
FROM Stok S
JOIN Urunler U ON S.UrunID = U.ID
WHERE S.GirisZamani >= DATEADD(MONTH, -6, GETDATE());

SELECT * FROM vw_SonAltiAyGelenUrunler


CREATE VIEW vw_MusteriToplamHarcama
AS
SELECT 
    M.Adi,
    M.Soyadi,
    SUM(S.Miktar * U.Fiyatý) AS ToplamHarcama
FROM Musteri M
JOIN Satis S ON M.ID = S.MusteriID
JOIN Urunler U ON S.UrunID = U.ID
GROUP BY M.Adi, M.Soyadi;

SELECT * FROM vw_MusteriToplamHarcama


CREATE VIEW vw_StokGirisleri
AS
SELECT
	U.Adi AS UrunAdi,
	S.Miktar,
	S.GirisZamani
FROM Stok S
JOIN Urunler U ON S.UrunID = U.ID
WHERE S.IslemTuru = 1

SELECT * FROM vw_StokGirisleri

CREATE VIEW vw_EnFazlaOdemeYapilanFirma
AS
SELECT 
    GT.FirmaAdi,
    SUM(G.Tutar) AS ToplamOdeme
FROM Giderler G
JOIN GiderTurleri GT ON G.GiderTuruID = GT.ID
GROUP BY GT.FirmaAdi;

SELECT * FROM vw_EnFazlaOdemeYapilanFirma

TRUNCATE TABLE UrunTurleri
TRUNCATE TABLE Tedarikci
TRUNCATE TABLE Urunler
TRUNCATE TABLE CalisanGorevi
TRUNCATE TABLE Calisanlar
TRUNCATE TABLE Musteri
TRUNCATE TABLE Stok
TRUNCATE TABLE Satis
TRUNCATE TABLE GiderTurleri
TRUNCATE TABLE Giderler

SELECT 
    CONVERT(date, S.SatisTarihi) AS SatisGunu,
    SUM((U.Fiyatý - U.Maliyeti) * S.Miktar) AS GunlukKar
FROM Satis S
JOIN Urunler U ON S.UrunID = U.ID
GROUP BY CONVERT(date, S.SatisTarihi)
ORDER BY SatisGunu;


SELECT 
    AVG(AylikKar) AS OrtalamaAylikKar
FROM (
    SELECT 
        YEAR(S.SatisTarihi) AS Yil,
        MONTH(S.SatisTarihi) AS Ay,
        SUM((U.Fiyatý - U.Maliyeti) * S.Miktar) AS AylikKar
    FROM Satis S
    JOIN Urunler U ON S.UrunID = U.ID
    GROUP BY YEAR(S.SatisTarihi), MONTH(S.SatisTarihi)
) AS AylikKarTablosu;


SELECT 
    U.ID,
    U.Adi AS UrunAdi,
    U.Markasi,
    U.Fiyatý AS SatisFiyati,
    U.Maliyeti AS Maliyet,
    (U.Fiyatý - U.Maliyeti) AS KarZarar
FROM Urunler U
WHERE (U.Fiyatý - U.Maliyeti) < 0;


SELECT 
    U.ID,
    U.Adi AS UrunAdi,
    U.Markasi,
    SUM(S.Miktar) AS ToplamSatis
FROM Satis S
JOIN Urunler U ON S.UrunID = U.ID
GROUP BY U.ID, U.Adi, U.Markasi
HAVING SUM(S.Miktar) = (
    SELECT MAX(UrunSatis)
    FROM (
        SELECT SUM(Miktar) AS UrunSatis
        FROM Satis
        GROUP BY UrunID
    ) AS T
);


CREATE PROCEDURE sp_UrunGuncelle
	@UrunID INT,
	@YeniAdi VARCHAR(100),
	@YeniMarkasi VARCHAR(100),
	@YeniRengi VARCHAR(50),
	@YeniFiyatý INT,
	@YeniMaliyeti INT
AS
BEGIN
	UPDATE Urunler
	SET Adi = @YeniAdi,
		Markasi = @YeniMarkasi,
		Rengi = @YeniRengi,
		Fiyatý = @YeniFiyatý,
		Maliyeti = @YeniMaliyeti
	WHERE ID = @UrunID;
	PRINT 'Ürün bilgileri baþarýyla güncellendi';
END;

EXEC sp_UrunGuncelle
	@UrunID = 3,
	@YeniAdi = 'Göz kalemi',
	@YeniMarkasi = 'Dior',
	@YeniRengi = 'Mavi',
	@YeniFiyatý = 2500,
	@YeniMaliyeti = 1200;

CREATE PROCEDURE sp_CalisanEkle
	@Adi VARCHAR(100),
	@Soyadi VARCHAR(100),
	@TelefonNosu CHAR(11),
	@TcKimlik CHAR(11)
AS
BEGIN
	INSERT INTO Calisanlar (Adi, Soyadi, TelefonNosu, TcKimlik)
	VALUES (@Adi, @Soyadi, @TelefonNosu, @TcKimlik);
	PRINT 'Yeni çalýþan baþarýyla eklendi.';
END;

EXEC sp_CalisanEkle
	@Adi = 'Meliha',
	@Soyadi = 'Peri',
	@TelefonNosu = 05534564747,
	@TcKimlik = 14231487594;

CREATE PROCEDURE sp_MusteriSil
	@MusteriID INT
AS 
BEGIN
	DELETE FROM Musteri
	WHERE ID = @MusteriID;
	PRINT 'Müþteri baþarýyla silindi';
END;

EXEC sp_MusteriSil
	@MusteriID = 4;

CREATE PROCEDURE sp_GiderleriGetir
	@GiderID INT
AS
BEGIN
	SELECT g.ID AS GiderID,
		gt.Adi AS GiderTuruAdi,
		gt.FaturaNo,
		gt.FirmaAdi,
		g.Tutar,
		g.Tarih
	FROM Giderler g
	JOIN GiderTurleri gt ON g.GiderTuruID = gt.ID
	WHERE g.ID = @GiderID;
END;

EXEC sp_GiderleriGetir
	@GiderID = 7
	
CREATE PROCEDURE sp_CalisanGoreviEkleme
	@Gorev VARCHAR(100)
AS
BEGIN
	INSERT INTO CalisanGorevi (Gorev)
	VALUES (@Gorev);
END;

EXEC sp_CalisanGoreviEkleme
	@Gorev = 'Operasyoncu'

CREATE NONCLUSTERED INDEX IX_Calisanlar_TcKimlik
ON Calisanlar (TcKimlik);
SELECT ID, Adi, Soyadi, TelefonNosu, TcKimlik
FROM Calisanlar
WHERE TCKimlik = '14144444141'

CREATE NONCLUSTERED INDEX IX_Musteri_TelefonNosu
ON Musteri (TelefonNosu)
SELECT ID, Adi, Soyadi, TelefonNosu
FROM Musteri
WHERE TelefonNosu = '05559874562'

CREATE NONCLUSTERED INDEX IX_Stok_GirisTarihi
ON Stok (GirisZamani);
SELECT ID, UrunID, GirisZamani
FROM Stok
WHERE GirisZamani BETWEEN '2025-06-01' and '2025-12-01'

CREATE NONCLUSTERED INDEX IX_Calisanlar_Gorev_Adi
ON Calisanlar (CalisanGoreviID, Adi);
SELECT C.Adi AS CalisanAdi
FROM Calisanlar C
INNER JOIN CalisanGorevi CG ON C.CalisanGoreviID = CG.ID
WHERE CG.Gorev = 'Satýþ';


----BOÞ DÖNERSE
UPDATE Calisanlar
SET CalisanGoreviID = 1   -- Satýþ
WHERE ID IN (1, 5, 6, 10, 11, 15);
----
CREATE NONCLUSTERED INDEX IX_TedarikcininSehri
ON Tedarikciler (Sehri);
SELECT ID, Adi, Soyadi, TelefonNosu, Sehri
FROM Tedarikciler
WHERE Sehri = 'Ýstanbul'
