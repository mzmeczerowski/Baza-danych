CREATE DATABASE [KlubRozrywkiProjekt]
GO
USE [KlubRozrywkiProjekt]
GO
/****** Object:  UserDefinedFunction [dbo].[czy_wolne_stanowisko]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[czy_wolne_stanowisko](@id_usluga INT)
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @Wynik VARCHAR(50)
IF EXISTS (SELECT czy_wolne FROM StanowiskaUslug WHERE id_usluga=@id_usluga AND czy_wolne = 1 ) 
SET @Wynik='Jest wolne stanowisko'
ELSE
SET @Wynik='Nie ma wolnego stanowiska'
RETURN @Wynik
END

GO
/****** Object:  UserDefinedFunction [dbo].[Ile_kosztowali_artysci]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Ile_kosztowali_artysci] (@odKiedy DATE, @doKiedy DATE)
RETURNS FLOAT
AS
BEGIN 
RETURN (SELECT SUM(A.placa) FROM Artysci A
JOIN Impreza_artysci IA ON A.id_artysta = IA.id_artysta 
JOIN Impreza I ON IA.id_impreza = I.id_impreza 			
WHERE I.data_imprezy BETWEEN @odKiedy AND @doKiedy)  
END

GO
/****** Object:  UserDefinedFunction [dbo].[ilosc_w_danym_dniu]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ilosc_w_danym_dniu](@id_produktu INT, @Data DATE )
RETURNS INT
AS 
BEGIN
DECLARE @Ilosc INT
SET @Ilosc = (SELECT SUM(ilosc) FROM Zamowienia WHERE id_produkt = @id_produktu AND (CAST(data_zamowienia AS DATE)) = @Data)
RETURN @Ilosc
END

GO
/****** Object:  UserDefinedFunction [dbo].[na_ilu_imprezach]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE FUNCTION [dbo].[na_ilu_imprezach] (@id_artysta INT )
 RETURNS INT
 AS
 BEGIN
 DECLARE @Ile INT
 SET @Ile = (SELECT COUNT(*) FROM Impreza_artysci WHERE id_artysta = @id_artysta)
 RETURN @Ile
 END

GO
/****** Object:  UserDefinedFunction [dbo].[najlepsza_usluga]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[najlepsza_usluga](@od date, @do date)
RETURNS VARCHAR(20)
BEGIN
RETURN
(SELECT rodzaj_uslugi FROM
(SELECT top 1 US.rodzaj_uslugi, count(ZA.id_zamowienie) AS ilosc FROM Usluga AS US
JOIN StanowiskaUslug AS SUS ON US.id_usluga = SUS.id_usluga
JOIN Zamowienia AS ZA ON SUS.id_stanowisko = ZA.id_stanowisko
 WHERE ZA.data_zamowienia >= @OD AND ZA.data_zamowienia <= @DO
 GROUP BY US.rodzaj_uslugi
 order by ilosc desc
 ) AS X
 )
END

GO
/****** Object:  UserDefinedFunction [dbo].[najlepszy_produkt]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[najlepszy_produkt](@miesiac date)
returns varchar(20)
BEGIN
RETURN (SELECT nazwa_produktu FROM (SELECT TOP 1 P.nazwa_produktu, SUM(Z.ilosc * P.cena_za_porcje) AS obrut FROM Produkty AS P
JOIN Zamowienia AS Z ON P.id_produkt = Z.id_produkt
WHERE MONTH(Z.data_zamowienia) = MONTH(@miesiac)
GROUP BY P.nazwa_produktu
ORDER BY obrut DESC
) AS X
)
END

GO
/****** Object:  UserDefinedFunction [dbo].[obrot_kasy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION	[dbo].[obrot_kasy](@id_kasa INT, @data DATE)
RETURNS FLOAT
AS
BEGIN
DECLARE @Ilosc_usluga FLOAT
DECLARE @Ilosc_produkt FLOAT

SET @Ilosc_produkt = (SELECT SUM( Z.ilosc * P.cena_za_porcje) 
Sumka FROM Zamowienia Z JOIN Produkty P ON Z.id_produkt=P.id_produkt 
WHERE Z.id_kasa= @id_kasa AND CAST(Z.data_zamowienia AS DATE) = @data) 
IF @Ilosc_produkt IS NULL
	SET @Ilosc_produkt = 0

SET @Ilosc_usluga = (SELECT SUM(Z.ilosc * U.cena) 
Sumka FROM Zamowienia Z JOIN StanowiskaUslug SU ON Z.id_stanowisko=SU.id_stanowisko 
JOIN Usluga U On SU.id_usluga= U.id_usluga
WHERE Z.id_kasa= @id_kasa AND CAST(Z.data_zamowienia AS DATE) = @data)
IF @Ilosc_usluga IS NULL
	SET @Ilosc_usluga = 0

RETURN @Ilosc_usluga + @Ilosc_produkt
END

GO
/****** Object:  UserDefinedFunction [dbo].[stan]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[stan](@nazwaproduktu VARCHAR(30))
RETURNS INT
BEGIN
RETURN (SELECT [stan_magazyn(w kg)] FROM Produkty WHERE nazwa_produktu = @nazwaproduktu)
END

GO
/****** Object:  UserDefinedFunction [dbo].[stan_kas]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[stan_kas]()
RETURNS FLOAT
AS
BEGIN
RETURN (select SUM(stan) from Kasa)
END

GO
/****** Object:  UserDefinedFunction [dbo].[zapelnienie_stanowiska_pracy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[zapelnienie_stanowiska_pracy](@id_stanowisko INT)
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) FROM Pracownicy WHERE id_stanowisko = @id_stanowisko)
END

GO
/****** Object:  UserDefinedFunction [dbo].[zarobki_kategorii]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[zarobki_kategorii](@id_kategoria INT)
RETURNS FLOAT
AS
BEGIN
RETURN (SELECT SUM(Z.ilosc * P.cena_za_porcje) FROM Produkty P JOIN Zamowienia Z 
ON P.id_produkt = Z.id_produkt WHERE P.id_kategoria = @id_kategoria)
END

GO
/****** Object:  Table [dbo].[Wyplata]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wyplata](
	[id_pracownik] [int] NOT NULL,
	[data_wyplaty] [date] NOT NULL,
	[ilosc_godzin] [int] NOT NULL,
	[id_premia] [int] NULL,
 CONSTRAINT [PK_wyplata] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC,
	[data_wyplaty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[wyplaty]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[wyplaty](@data DATE)
RETURNS TABLE AS
RETURN (SELECT * FROM Wyplata WHERE data_wyplaty = @data)

GO
/****** Object:  Table [dbo].[Impreza_pracownicy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza_pracownicy](
	[id_impreza] [int] NOT NULL,
	[id_pracownik] [int] NOT NULL,
 CONSTRAINT [PK_Impreza_pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC,
	[id_impreza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pracownicy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pracownicy](
	[id_pracownik] [int] IDENTITY(1,1) NOT NULL,
	[imie] [varchar](20) NOT NULL,
	[nazwisko] [varchar](20) NOT NULL,
	[ulica] [varchar](20) NULL,
	[nr_domu] [varchar](5) NULL,
	[miasto] [varchar](20) NULL,
	[wojewodztwo] [varchar](20) NULL,
	[KodPocztowy] [char](6) NULL,
	[obywatelstwo] [varchar](20) NULL,
	[id_stanowisko] [int] NOT NULL,
	[data_zatrudnienia] [date] NULL,
 CONSTRAINT [PK_Pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[kto_na_imprezie]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[kto_na_imprezie](@id_imprezy int)
RETURNS TABLE AS
RETURN (SELECT p.imie, p.nazwisko FROM Pracownicy as p
join Impreza_pracownicy as imp ON p.id_pracownik = imp.id_pracownik
where imp.id_impreza = @id_imprezy)

GO
/****** Object:  Table [dbo].[Produkty]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produkty](
	[id_produkt] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_produktu] [varchar](30) NOT NULL,
	[cena_za_porcje] [money] NULL,
	[id_kategoria] [int] NOT NULL,
	[producent] [varchar](50) NULL,
	[stan_magazyn(w kg)] [float] NULL,
	[gramatura_porcji] [float] NULL,
	[id_dostawca] [int] NOT NULL,
 CONSTRAINT [PK_Produkty] PRIMARY KEY CLUSTERED 
(
	[id_produkt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[produkty_dostawcy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[produkty_dostawcy](@id_dostawcy INT)
RETURNS TABLE AS
RETURN (SELECT * FROM Produkty
WHERE id_dostawca = @id_dostawcy)
GO
/****** Object:  Table [dbo].[Urlopy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Urlopy](
	[id_pracownik] [int] NOT NULL,
	[od_kiedy] [date] NOT NULL,
	[do_kiedy] [date] NOT NULL,
 CONSTRAINT [FK_Urlopy] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC,
	[od_kiedy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[dostepni_pracownicy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION	[dbo].[dostepni_pracownicy]()
RETURNS TABLE AS
RETURN (SELECT imie, nazwisko 
FROM Pracownicy 
WHERE id_pracownik NOT IN (SELECT id_pracownik FROM Urlopy where od_kiedy <= getdate() and do_kiedy >=getdate()))
GO
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[id_zamowienie] [int] IDENTITY(1,1) NOT NULL,
	[ilosc] [tinyint] NOT NULL,
	[id_produkt] [int] NULL,
	[id_stanowisko] [int] NULL,
	[id_kasa] [tinyint] NOT NULL,
	[data_zamowienia] [datetime] NOT NULL,
 CONSTRAINT [PK_SzczegolySprzedazy] PRIMARY KEY CLUSTERED 
(
	[id_zamowienie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kasa]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kasa](
	[id_kasa] [tinyint] IDENTITY(1,1) NOT NULL,
	[stan] [money] NOT NULL,
	[czy_aktywna] [bit] NULL,
	[id_pracownik] [int] NOT NULL,
 CONSTRAINT [PK_Kasa] PRIMARY KEY CLUSTERED 
(
	[id_kasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[pracownik_miesiaca]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[pracownik_miesiaca](@data DATE)
RETURNS table
AS
RETURN
(SELECT TOP 1 p.id_pracownik, SUM(pr.cena_za_porcje * z.ilosc) AS Suma FROM Pracownicy p
JOIN Kasa k ON p.id_pracownik = k.id_pracownik
JOIN Zamowienia z ON k.id_kasa = z.id_kasa
JOIN Produkty pr ON z.id_produkt = pr.id_produkt
where month(z.data_zamowienia) = month(@data)
GROUP BY p.id_pracownik
ORDER BY Suma DESC)

GO
/****** Object:  Table [dbo].[Artysci]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artysci](
	[id_artysta] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [varchar](20) NOT NULL,
	[kontakt] [int] NULL,
	[profesja] [varchar](20) NULL,
	[placa] [money] NOT NULL,
 CONSTRAINT [PK_Artysci] PRIMARY KEY CLUSTERED 
(
	[id_artysta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impreza_artysci]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza_artysci](
	[id_artysta] [int] NOT NULL,
	[id_impreza] [int] NOT NULL,
 CONSTRAINT [PK_Impreza_artysci] PRIMARY KEY CLUSTERED 
(
	[id_impreza] ASC,
	[id_artysta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[nie_byli_na_imprezie]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[nie_byli_na_imprezie]
AS
SELECT A.nazwa, A.kontakt FROM Artysci AS A FULL JOIN Impreza_artysci AS IA ON A.id_artysta = IA.id_artysta
WHERE IA.id_impreza IS NULL
GO
/****** Object:  Table [dbo].[Impreza]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza](
	[id_impreza] [int] IDENTITY(1,1) NOT NULL,
	[nazwaImprezy] [varchar](20) NOT NULL,
	[data_imprezy] [date] NOT NULL,
	[cena_wejsciowki] [money] NULL,
 CONSTRAINT [PK_Impreza] PRIMARY KEY CLUSTERED 
(
	[id_impreza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[data_imprezy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StanowiskaPracy]    Script Date: 11.06.2018 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StanowiskaPracy](
	[id_stanowisko] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_stanowiska] [varchar](20) NOT NULL,
	[stawka_godzinowa] [money] NOT NULL,
	[opis] [text] NULL,
 CONSTRAINT [PK_StanowiskaPracy] PRIMARY KEY CLUSTERED 
(
	[id_stanowisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nazwa_stanowiska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[pracownicy_na_imprezie_artysty]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[pracownicy_na_imprezie_artysty] (@id_artysta INT)
RETURNS TABLE
AS
RETURN (
SELECT P.imie,P.nazwisko,SP.nazwa_stanowiska,I.nazwaImprezy,A.nazwa FROM StanowiskaPracy SP 
JOIN Pracownicy P ON SP.id_stanowisko=P.id_stanowisko
JOIN Impreza_pracownicy IP ON P.id_pracownik=IP.id_pracownik
JOIN Impreza I ON IP.id_impreza=I.id_impreza
JOIN Impreza_artysci IA ON I.id_impreza=IA.id_impreza
JOIN Artysci A ON IA.id_artysta= A.id_artysta
 WHERE A.id_artysta = @id_artysta
 )

GO
/****** Object:  UserDefinedFunction [dbo].[Najczesciej_kupowany_produkt]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Najczesciej_kupowany_produkt](@odKiedy DATE, @doKiedy DATE)
RETURNS TABLE
AS
RETURN (
SELECT  Z.id_produkt,P.nazwa_produktu, SUM(ilosc) ilosc_sprzedanych 
FROM Produkty P JOIN Zamowienia Z ON P.id_produkt=Z.id_produkt 
WHERE Z.data_zamowienia BETWEEN  @odKiedy AND @doKiedy
GROUP BY Z.id_produkt,P.nazwa_produktu
)

GO
/****** Object:  View [dbo].[sprzedane_produkty_w_ostatnim_msc]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sprzedane_produkty_w_ostatnim_msc]
AS
SELECT  Z.id_produkt,P.nazwa_produktu, SUM(ilosc) ilosc_sprzedanych 
FROM Produkty P JOIN Zamowienia Z ON P.id_produkt=Z.id_produkt 
WHERE Z.data_zamowienia BETWEEN  CAST(GETDATE()-30 AS DATE) AND CAST(GETDATE() AS DATE)
GROUP BY Z.id_produkt,P.nazwa_produktu

GO
/****** Object:  UserDefinedFunction [dbo].[pracownicy_z_miasta]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[pracownicy_z_miasta] (@miasto VARCHAR(20))
RETURNS TABLE
AS
RETURN (
SELECT imie,nazwisko,nazwa_stanowiska,stawka_godzinowa FROM Pracownicy P JOIN StanowiskaPracy SP ON P.id_stanowisko=SP.id_stanowisko
WHERE miasto = @miasto
)

GO
/****** Object:  UserDefinedFunction [dbo].[Artysta_a_pracownicy]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Artysta_a_pracownicy] (@id_artysta INT)
RETURNS TABLE
AS
RETURN (
SELECT P.* FROM Pracownicy P JOIN Impreza_pracownicy IMP ON P.id_pracownik = IMP.id_pracownik
JOIN Impreza I ON IMP.id_impreza = I.id_impreza
JOIN Impreza_artysci IA ON I.id_impreza = IA.id_artysta
WHERE IA.id_artysta = @id_artysta
)

GO
/****** Object:  UserDefinedFunction [dbo].[zarabiaja_wiecej_niz]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[zarabiaja_wiecej_niz](@placa MONEY)
RETURNS TABLE
AS
RETURN 
(SELECT P.imie,P.nazwisko,S.stawka_godzinowa,S.nazwa_stanowiska FROM Pracownicy P JOIN StanowiskaPracy S ON P.id_stanowisko=S.id_stanowisko
WHERE S.stawka_godzinowa > @placa)

GO
/****** Object:  Table [dbo].[Premia]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Premia](
	[id_premii] [int] IDENTITY(1,1) NOT NULL,
	[odsetek_premii] [float] NULL,
	[opis] [nvarchar](100) NULL,
 CONSTRAINT [PK_Premia] PRIMARY KEY CLUSTERED 
(
	[id_premii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[kto_mial_premie]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[kto_mial_premie](@id_premia INT)
RETURNS TABLE
AS
RETURN (
SELECT P.imie,P.nazwisko,W.data_wyplaty,PR.id_premii,PR.opis FROM Pracownicy P 
JOIN Wyplata W ON P.id_pracownik = W.id_pracownik 
JOIN Premia PR ON W.id_premia = PR.id_premii
WHERE PR.id_premii = @id_premia
)

GO
/****** Object:  Table [dbo].[Dostawcy]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dostawcy](
	[id_dostawca] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [varchar](30) NOT NULL,
	[Telefon] [varchar](15) NULL,
	[Ulica] [varchar](20) NULL,
	[Nr] [varchar](6) NULL,
	[Miasto] [varchar](20) NULL,
	[Wojewodztwo] [varchar](20) NULL,
	[Kraj] [varchar](20) NULL,
	[KodPocztowy] [char](6) NULL,
 CONSTRAINT [PK_Dostawcy] PRIMARY KEY CLUSTERED 
(
	[id_dostawca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategorie]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategorie](
	[id_kategoria] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_kategorii] [varchar](20) NOT NULL,
	[opis] [text] NULL,
 CONSTRAINT [PK_Kategorie] PRIMARY KEY CLUSTERED 
(
	[id_kategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StanowiskaUslug]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StanowiskaUslug](
	[id_stanowisko] [int] IDENTITY(1,1) NOT NULL,
	[czy_wolne] [bit] NOT NULL,
	[id_usluga] [int] NOT NULL,
 CONSTRAINT [PK_StanowiskaUslug] PRIMARY KEY CLUSTERED 
(
	[id_stanowisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usluga]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usluga](
	[id_usluga] [int] IDENTITY(1,1) NOT NULL,
	[rodzaj_uslugi] [varchar](20) NOT NULL,
	[cena] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Usluga] PRIMARY KEY CLUSTERED 
(
	[id_usluga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Kasa] ADD  DEFAULT ((300)) FOR [stan]
GO
ALTER TABLE [dbo].[Impreza_artysci]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_artysci_Artysci] FOREIGN KEY([id_artysta])
REFERENCES [dbo].[Artysci] ([id_artysta])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Impreza_artysci] CHECK CONSTRAINT [FK_Impreza_artysci_Artysci]
GO
ALTER TABLE [dbo].[Impreza_artysci]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_artysci_Impreza] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Impreza] ([id_impreza])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Impreza_artysci] CHECK CONSTRAINT [FK_Impreza_artysci_Impreza]
GO
ALTER TABLE [dbo].[Impreza_pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_pracownicy_Impreza] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Impreza] ([id_impreza])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Impreza_pracownicy] CHECK CONSTRAINT [FK_Impreza_pracownicy_Impreza]
GO
ALTER TABLE [dbo].[Impreza_pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_pracownicy_Pracownicy] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Impreza_pracownicy] CHECK CONSTRAINT [FK_Impreza_pracownicy_Pracownicy]
GO
ALTER TABLE [dbo].[Kasa]  WITH CHECK ADD  CONSTRAINT [FK_Kasa_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Kasa] CHECK CONSTRAINT [FK_Kasa_Pracownicy]
GO
ALTER TABLE [dbo].[Pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Pracownicy_StanowiskaPracy] FOREIGN KEY([id_stanowisko])
REFERENCES [dbo].[StanowiskaPracy] ([id_stanowisko])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pracownicy] CHECK CONSTRAINT [FK_Pracownicy_StanowiskaPracy]
GO
ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_Dostawcy] FOREIGN KEY([id_dostawca])
REFERENCES [dbo].[Dostawcy] ([id_dostawca])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_Dostawcy]
GO
ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_Kategorie] FOREIGN KEY([id_kategoria])
REFERENCES [dbo].[Kategorie] ([id_kategoria])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_Kategorie]
GO
ALTER TABLE [dbo].[StanowiskaUslug]  WITH CHECK ADD  CONSTRAINT [FK_StanowiskaUslug_Usluga] FOREIGN KEY([id_usluga])
REFERENCES [dbo].[Usluga] ([id_usluga])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StanowiskaUslug] CHECK CONSTRAINT [FK_StanowiskaUslug_Usluga]
GO
ALTER TABLE [dbo].[Urlopy]  WITH CHECK ADD  CONSTRAINT [FK_Urlopy_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Urlopy] CHECK CONSTRAINT [FK_Urlopy_Pracownicy]
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD  CONSTRAINT [FK_Wyplata_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wyplata] CHECK CONSTRAINT [FK_Wyplata_Pracownicy]
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD  CONSTRAINT [FK_Wyplata_Premia] FOREIGN KEY([id_premia])
REFERENCES [dbo].[Premia] ([id_premii])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wyplata] CHECK CONSTRAINT [FK_Wyplata_Premia]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_SzczegolySprzedazy_Produkty] FOREIGN KEY([id_produkt])
REFERENCES [dbo].[Produkty] ([id_produkt])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_SzczegolySprzedazy_Produkty]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_Kasa] FOREIGN KEY([id_kasa])
REFERENCES [dbo].[Kasa] ([id_kasa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_Kasa]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_StanowiskaUslug] FOREIGN KEY([id_stanowisko])
REFERENCES [dbo].[StanowiskaUslug] ([id_stanowisko])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_StanowiskaUslug]
GO
ALTER TABLE [dbo].[Artysci]  WITH CHECK ADD CHECK  (([placa]>(100)))
GO
ALTER TABLE [dbo].[StanowiskaPracy]  WITH CHECK ADD CHECK  (([stawka_godzinowa]>=(10)))
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD CHECK  (([ilosc_godzin]<(500)))
GO
/****** Object:  StoredProcedure [dbo].[Dodaj_urlop]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dodaj_urlop] (@id_pracownik INT, @na_ile_dni INT)
AS
IF @na_ile_dni < 1
	RAISERROR('Nie mozna dac urlopu na 0 lub mniej dni',1,1)
ELSE 
BEGIN
DECLARE @doKiedy DATE
SET @doKiedy = (SELECT GETDATE() + @na_ile_dni)
INSERT INTO Urlopy VALUES (@id_pracownik,CAST(GETDATE() AS DATE),@doKiedy)
END
GO
/****** Object:  StoredProcedure [dbo].[DodajPracownika]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajPracownika] (@data_wyplaty DATE)
AS
IF (SELECT TOP 1 data_imprezy FROM Impreza Order by id_impreza DESC ) > GETDATE()
BEGIN
DECLARE @id_pracownik INT
SET @id_pracownik = (SELECT TOP 1 id_pracownik FROM Wyplata WHERE data_wyplaty = @data_wyplaty ORDER BY ilosc_godzin )
DECLARE @id_impreza INT
SET @id_impreza = (SELECT TOP 1 id_impreza FROM Impreza ORDER BY id_impreza DESC)
IF NOT EXISTS (SELECT id_pracownik FROM Impreza_pracownicy WHERE id_pracownik = @id_pracownik AND id_impreza = @id_impreza)
INSERT INTO Impreza_pracownicy VALUES (@id_impreza,@id_pracownik)
ELSE
PRINT 'Pracownik jest juz na imprezie'
END
ELSE
PRINT 'Nie ma nastepnej imprezy w bazie'
---przyklad--
EXEC DodajPracownika '2018-06-01'
GO
/****** Object:  StoredProcedure [dbo].[przyznaj_premie]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
----PROCEDUR NR 3
------------------PRZYZNANIE PREMI PRACOWNIKOWI------------------
CREATE PROC [dbo].[przyznaj_premie]
@id_pracownik INT,
@id_premii INT
AS
UPDATE Wyplata
SET id_premia = @id_premii
WHERE id_pracownik = @id_pracownik AND MONTH(data_wyplaty) = MONTH(GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[sprzedaj_towar]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---PROCEDUR NR 1
------------------SPRZEDARZ TOWARU------------------
CREATE PROC [dbo].[sprzedaj_towar]
@id_towar INT,
@ilosc INT,
@kasa INT
AS
IF @ilosc < 0
BEGIN
	RAISERROR('Nie moze sprzedac ujemnej ilosci towaru',1,1)
	ROLLBACK
END
INSERT INTO Zamowienia(ilosc, id_produkt, id_kasa, data_zamowienia)
VALUES (@ilosc, @id_towar, @kasa, getdate())
GO
/****** Object:  StoredProcedure [dbo].[sprzedaj_usluge]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sprzedaj_usluge] 
@id_stanowisko INT,
@ilosc INT,
@kasa INT
AS
IF @ilosc < 0
	RAISERROR('Nie moze zamowic ujemnej ilosci uslugi',1,1)
ELSE 
BEGIN
IF EXISTS (SELECT czy_wolne FROM StanowiskaUslug WHERE id_stanowisko=@id_stanowisko AND czy_wolne = 1 ) 
BEGIN
print ('Jest wolne stanowisko')
INSERT INTO Zamowienia(ilosc, id_stanowisko, id_kasa, data_zamowienia)
VALUES (@ilosc, @id_stanowisko, @kasa, getdate())
END
ELSE
print ('stanowisko jest zajęte')
END
GO
/****** Object:  StoredProcedure [dbo].[Zamowienie_towaru]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Zamowienie_towaru](@id_produkt INT ,@ilosc FLOAT)
AS
IF @ilosc < 0
BEGIN
	RAISERROR('Nie moze zamowic ujemnej ilosci towaru',1,1)
END
ELSE
BEGIN
UPDATE Produkty
SET [stan_magazyn(w kg)] = [stan_magazyn(w kg)] + @ilosc
WHERE id_produkt = @id_produkt
END
GO
/****** Object:  StoredProcedure [dbo].[zatrudnienie_pracownika]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[zatrudnienie_pracownika]
@imie varchar(20),
@nazwisko varchar(20),
@ulica varchar(40),
@nr_domu int,
@misato varchar(30),
@wojewodztwo varchar(30),
@kod_pocztowy int,
@obywatelstwo varchar(20),
@id_stanowisko INT,
@data_zatrudnienia date
AS
IF @id_stanowisko = 11
PRINT 'Nie mozna dodac szefa'
ELSE
INSERT INTO Pracownicy VALUES
(@imie, @nazwisko, @ulica, @nr_domu, @misato,
@wojewodztwo, @kod_pocztowy, @obywatelstwo, @id_stanowisko, @data_zatrudnienia)
GO
/****** Object:  StoredProcedure [dbo].[ZmienArtyste]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ZmienArtyste] (@nazwa VARCHAR(20),@kontakt INT, @profesja VARCHAR(20), @placa MONEY, @id_impreza INT, @id_artysta INT)
AS
INSERT INTO Artysci VALUES (@nazwa,@kontakt,@profesja,@placa)
UPDATE Impreza_artysci
SET id_artysta = (SELECT TOP 1 id_artysta FROM Artysci ORDER BY id_artysta DESC)
WHERE id_impreza = @id_impreza AND id_artysta = @id_artysta
--przyklad--
EXEC ZmienArtyste Marianek,664855555,Piosenkarz,3000,2,4
SELECT * FROM Artysci JOIN Impreza_artysci ON Artysci.id_artysta=Impreza_artysci.id_artysta
GO
/****** Object:  StoredProcedure [dbo].[zwieksz_zarobki]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[zwieksz_zarobki] (@procent FLOAT,@id_stanowisko INT)
AS
UPDATE StanowiskaPracy
SET stawka_godzinowa = stawka_godzinowa + (stawka_godzinowa * @procent)/100
WHERE id_stanowisko = @id_stanowisko
----Przyklad-----
EXEC zwieksz_zarobki 20,11
GO
/****** Object:  StoredProcedure [dbo].[zwolnij_pracownika]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[zwolnij_pracownika]
@id_pracownik INT
AS
IF EXISTS (SELECT id_pracownik FROM Pracownicy WHERE id_pracownik = @id_pracownik)
DELETE Pracownicy
WHERE id_pracownik = @id_pracownik
ELSE
PRINT('Nie ma takiego pracownika')
GO
/****** Object:  StoredProcedure [dbo].[ZwolnijStanowisko]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ZwolnijStanowisko] (@nrStanowiska INT)
AS
IF (SELECT czy_wolne FROM StanowiskaUslug WHERE id_stanowisko = @nrStanowiska) = 0 
BEGIN
UPDATE StanowiskaUslug
SET czy_wolne = 1
WHERE id_stanowisko = @nrStanowiska
END
ELSE
PRINT 'Stanowisko jest wolne!!!'  ---Przy probie wykonanie tego na wolnym stanowisku wyskakuje komunikat ---
---przyklad---
EXEC ZwolnijStanowisko 3
SELECT * FROM StanowiskaUslug
GO
/****** Object:  Trigger [dbo].[dodaj_kase]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------Po dodaniu kasy przelewa jej 200 zl z kasy w ktorej jest najwiecej pieniedzy (jesli jest wiecej niz 300) ---------
CREATE TRIGGER [dbo].[dodaj_kase] ON [dbo].[Kasa]
AFTER INSERT
AS
BEGIN 
DECLARE @id_kasa TINYINT
SET @id_kasa = (SELECT TOP 1 id_kasa FROM Kasa ORDER BY stan)
IF (SELECT stan FROM Kasa WHERE id_kasa = @id_kasa) >= 300
BEGIN
	UPDATE Kasa
	SET stan += 200
	WHERE id_kasa = (SELECT id_kasa FROM inserted)
	UPDATE Kasa
	SET stan -=200
	WHERE id_kasa = @id_kasa
END
ELSE 
BEGIN
	PRINT 'W zadnej kasie nie ma wiecej niz 300zl '
	ROLLBACK
END
END
GO
ALTER TABLE [dbo].[Kasa] ENABLE TRIGGER [dodaj_kase]
GO
/****** Object:  Trigger [dbo].[czy_jest_inny_pracownik]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[czy_jest_inny_pracownik] ON [dbo].[Pracownicy]
AFTER DELETE
AS
BEGIN
DECLARE @stanowisko INT
SET @stanowisko = (SELECT id_stanowisko FROM deleted)
IF EXISTS (SELECT P.id_pracownik FROM Pracownicy P LEFT JOIN deleted D
ON P.id_pracownik = D.id_pracownik WHERE P.id_stanowisko = @stanowisko AND D.id_pracownik IS NULL)
PRINT 'Usunieto pracownika ! Sa jeszcze pracownincy na to stanowisko'
ELSE
PRINT 'SZUKAJ NOWEGO PRACOWNIKA'
END
GO
ALTER TABLE [dbo].[Pracownicy] ENABLE TRIGGER [czy_jest_inny_pracownik]
GO
/****** Object:  Trigger [dbo].[premia_swiateczna]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----przyznanie premi swiątecznej-----------------------------
CREATE TRIGGER [dbo].[premia_swiateczna] ON [dbo].[Wyplata]
AFTER INSERT
AS
IF DATEPART(MONTH, (SELECT data_wyplaty FROM inserted)) = 12
BEGIN
UPDATE Wyplata
SET id_premia = 3 --Premia świąteczna
WHERE MONTH(data_wyplaty) = 12
END
GO
ALTER TABLE [dbo].[Wyplata] ENABLE TRIGGER [premia_swiateczna]
GO
/****** Object:  Trigger [dbo].[czyszczenie_pamieci]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
---------usuwanie starszych zamówień niż 5 lat--------------------
CREATE TRIGGER [dbo].[czyszczenie_pamieci] ON [dbo].[Zamowienia]
AFTER INSERT
AS
WHILE (SELECT MIN(data_zamowienia) FROM Zamowienia) < GETDATE()-YEAR(5)
BEGIN
DELETE Zamowienia
WHERE data_zamowienia = (SELECT MIN(DATA_ZAMOWIENIA) FROM ZAMOWIENIA WHERE data_zamowienia < GETDATE()-YEAR(5))
PRINT 'Z TABELI ZAMOWIENIA ZOSTAŁ USUNIĘTY REKORD STARSZY NIŻ 5 LAT'
END
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [czyszczenie_pamieci]
GO
/****** Object:  Trigger [dbo].[gdy_malo]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------Przy zamowieniu czegos czego jest mniej niż 5 kg w magazynie wyskakuje komunikat=----
CREATE TRIGGER [dbo].[gdy_malo] ON [dbo].[Zamowienia]
AFTER INSERT
AS
BEGIN
IF (SELECT id_produkt from inserted) IS NOT NULL
BEGIN
	DECLARE @id_produktu INT
	DECLARE @stan_magazyn FLOAT
	SET @id_produktu = (SELECT id_produkt FROM inserted)
	SET @stan_magazyn = (SELECT [stan_magazyn(w kg)] FROM Produkty WHERE id_produkt = @id_produktu)
	IF  @stan_magazyn < 5
		PRINT 'DOMÓW PRODUKT ! JEST GO TYLKO' + CAST(@stan_magazyn AS VARCHAR(50)) + ' kg'
	END
END
INSERT INTO Zamowienia VALUES (3,25,NULL,1,GETDATE())
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [gdy_malo]
GO
/****** Object:  Trigger [dbo].[powrot_do_stanu_pierwotnego]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------Powrót do stanu pierwotnego kasy i magazynu-----------------------------------------
CREATE TRIGGER [dbo].[powrot_do_stanu_pierwotnego] ON [dbo].[Zamowienia]
AFTER DELETE
AS
BEGIN
IF (SELECT id_produkt FROM deleted) IS NOT NULL
BEGIN
DECLARE @nowe table (ilosc int, id_kasa int, cena money)
insert into @nowe SELECT del.ilosc, del.id_kasa, pro.cena_za_porcje
FROM deleted as del join Produkty as pro on del.id_produkt = pro.id_produkt

UPDATE Kasa SET stan-=(select ilosc*cena from @nowe)
WHERE id_kasa = (SELECT id_kasa FROM @nowe)

DECLARE @Ilosc FLOAT
SET @Ilosc = (SELECT ilosc FROM deleted) * (SELECT gramatura_porcji FROM Produkty as P JOIN deleted as del ON P.id_produkt = del.id_produkt )/1000
UPDATE Produkty
SET [stan_magazyn(w kg)] += @Ilosc
WHERE id_produkt = (SELECT id_produkt FROM deleted)
END

IF (SELECT id_stanowisko FROM deleted) IS NOT NULL
BEGIN
DECLARE @nowe1 table (ilosc int, id_kasa int, cena money)
insert into @nowe1 SELECT del.ilosc, del.id_kasa, usl.cena
FROM deleted as del
join StanowiskaUslug as sta on del.id_stanowisko = sta.id_stanowisko
join Usluga as usl on sta.id_usluga = usl.id_usluga

UPDATE Kasa SET stan-=(select ilosc*cena from @nowe1)
WHERE id_kasa = (SELECT id_kasa FROM @nowe1)
END
END
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [powrot_do_stanu_pierwotnego]
GO
/****** Object:  Trigger [dbo].[stan_Kasy]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---Trigger Stan Kasy ---
CREATE TRIGGER [dbo].[stan_Kasy] on [dbo].[Zamowienia]
AFTER INSERT 
AS
BEGIN
IF (SELECT id_produkt FROM inserted) IS NOT NULL
BEGIN
DECLARE @nowe table (ilosc int, id_kasa int, cena money)
insert into @nowe SELECT ins.ilosc, ins.id_kasa, pro.cena_za_porcje
FROM inserted as ins join Produkty as pro on ins.id_produkt = pro.id_produkt

UPDATE Kasa SET stan+=(select ilosc*cena from @nowe)
WHERE id_kasa = (SELECT id_kasa FROM @nowe)
END
IF (SELECT id_stanowisko FROM inserted) IS NOT NULL
BEGIN
DECLARE @nowe1 table (ilosc int, id_kasa int, cena money)
insert into @nowe1 SELECT ins.ilosc, ins.id_kasa, usl.cena
FROM inserted as ins
join StanowiskaUslug as sta on ins.id_stanowisko = sta.id_stanowisko
join Usluga as usl on sta.id_usluga = usl.id_usluga

UPDATE Kasa SET stan+=(select ilosc*cena from @nowe1)
WHERE id_kasa = (SELECT id_kasa FROM @nowe1)
END
END
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [stan_Kasy]
GO
/****** Object:  Trigger [dbo].[stan_magazynu]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------Wyzwalacz aktualizujacy stan magazynu po zakupie --------
CREATE TRIGGER [dbo].[stan_magazynu] ON [dbo].[Zamowienia]
AFTER INSERT
AS
BEGIN
IF (SELECT id_produkt FROM inserted) IS NOT NULL
BEGIN
DECLARE @Ilosc FLOAT
SET @Ilosc = (SELECT ilosc FROM inserted) * (SELECT gramatura_porcji FROM Produkty P JOIN inserted I ON P.id_produkt=I.id_produkt )/1000
UPDATE Produkty
SET [stan_magazyn(w kg)] = [stan_magazyn(w kg)] - @Ilosc
WHERE id_produkt = (SELECT id_produkt FROM inserted)
PRINT 'Produkt sprzedano poprawnie'
END 
END
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [stan_magazynu]
GO
/****** Object:  Trigger [dbo].[wlacz_kase]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 ------Włacza kase gdy chce sie z niej cos zamowic
 CREATE TRIGGER [dbo].[wlacz_kase] ON [dbo].[Zamowienia]
AFTER INSERT
AS
BEGIN
DECLARE @id_kasa TINYINT
SET @id_kasa = (SELECT id_kasa FROM inserted)
IF (SELECT czy_aktywna FROM Kasa WHERE id_kasa = @id_kasa) = 0
BEGIN
UPDATE Kasa
SET czy_aktywna = 1
WHERE id_kasa = @id_kasa
PRINT 'Kasa zostala uruchomiona'
END
END 
INSERT INTO Zamowienia VALUES (3,9,NULL,3,GETDATE())
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [wlacz_kase]
GO
/****** Object:  Trigger [dbo].[zajete]    Script Date: 11.06.2018 12:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------Wyzwalacz zmieniajacy stan satnowiska po zamowieniu *jesli jest juz zajete nie pozwala na zakup -------------
CREATE TRIGGER [dbo].[zajete] ON [dbo].[Zamowienia]
AFTER INSERT
AS
BEGIN
IF (SELECT id_stanowisko FROM inserted) IS NOT NULL 
BEGIN
	IF (SELECT S.czy_wolne FROM StanowiskaUslug S join inserted I ON S.id_stanowisko=I.id_stanowisko) = 1
	BEGIN
	UPDATE StanowiskaUslug
	SET czy_wolne = 0
	WHERE id_stanowisko = (SELECT id_stanowisko FROM inserted)
	PRINT 'Stanowisko zostalo zajete'
	END
	ELSE
	PRINT 'Stanowisko jest juz zajete'
END
END
GO
ALTER TABLE [dbo].[Zamowienia] ENABLE TRIGGER [zajete]
GO
