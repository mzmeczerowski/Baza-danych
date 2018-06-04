USE [KlubRozrywki]
GO
/****** Object:  Table [dbo].[Artysci]    Script Date: 04.06.2018 16:56:57 ******/
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
/****** Object:  Table [dbo].[Dostawcy]    Script Date: 04.06.2018 16:56:58 ******/
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
/****** Object:  Table [dbo].[Impreza]    Script Date: 04.06.2018 16:56:58 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impreza_artysci]    Script Date: 04.06.2018 16:56:58 ******/
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
/****** Object:  Table [dbo].[Impreza_pracownicy]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Kasa]    Script Date: 04.06.2018 16:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kasa](
	[id_kasa] [tinyint] IDENTITY(1,1) NOT NULL,
	[stan] [money] NOT NULL,
	[czy_aktywna] [bit] NULL,
 CONSTRAINT [PK_Kasa] PRIMARY KEY CLUSTERED 
(
	[id_kasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kasa_Pracownicy]    Script Date: 04.06.2018 16:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kasa_Pracownicy](
	[id_kasa] [tinyint] NOT NULL,
	[id_pracownik] [int] NOT NULL,
 CONSTRAINT [PK_Kasa_Pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC,
	[id_kasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategorie]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Pracownicy]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Premia]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Produkty]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[StanowiskaPracy]    Script Date: 04.06.2018 16:56:59 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StanowiskaUslug]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Urlopy]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Usługa]    Script Date: 04.06.2018 16:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usługa](
	[id_usluga] [int] IDENTITY(1,1) NOT NULL,
	[rodzaj_uslugi] [varchar](20) NOT NULL,
	[cena] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Usługa] PRIMARY KEY CLUSTERED 
(
	[id_usluga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wyplata]    Script Date: 04.06.2018 16:56:59 ******/
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
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 04.06.2018 16:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[id_zamowienie] [int] IDENTITY(1,1) NOT NULL,
	[ilosc] [tinyint] NOT NULL,
	[id_produkt] [int] NULL,
	[promocja] [float] NULL,
	[id_stanowisko] [int] NULL,
	[id_kasa] [tinyint] NOT NULL,
	[data_zamowienia] [datetime] NOT NULL,
	[id_impreza] [int] NULL,
 CONSTRAINT [PK_SzczegolySprzedazy] PRIMARY KEY CLUSTERED 
(
	[id_zamowienie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Artysci] ON 

INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (1, N'Gromee', 601628520, N'DJ', 2000.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (2, N'Donguralesko', -210, N'Raper', 5000.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (3, N'DjOzzzii', -449, N'DJ', 1000.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (4, N'Koldas', -444, N'Raper', 3000.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (5, N'Mariuss', -500, N'DJ', 1300.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (6, N'Patryk Dargacz', -342, N'Piosenkarz', 8000.0000)
INSERT [dbo].[Artysci] ([id_artysta], [nazwa], [kontakt], [profesja], [placa]) VALUES (7, N'CokeSmokeDragWeed', -420, N'Piosenkarz', 3500.0000)
SET IDENTITY_INSERT [dbo].[Artysci] OFF
SET IDENTITY_INSERT [dbo].[Dostawcy] ON 

INSERT [dbo].[Dostawcy] ([id_dostawca], [Nazwa], [Telefon], [Ulica], [Nr], [Miasto], [Wojewodztwo], [Kraj], [KodPocztowy]) VALUES (1, N'SuperCompany', N'666-555-444', N'Dluga', N'33', N'Gdansk', N'Pomorskie', N'Polska', N'81-400')
INSERT [dbo].[Dostawcy] ([id_dostawca], [Nazwa], [Telefon], [Ulica], [Nr], [Miasto], [Wojewodztwo], [Kraj], [KodPocztowy]) VALUES (2, N'Detronix', N'622-255-422', N'Olbrzymia', N'11', N'Gdansk', N'Pomorskie', N'Polska', N'81-400')
INSERT [dbo].[Dostawcy] ([id_dostawca], [Nazwa], [Telefon], [Ulica], [Nr], [Miasto], [Wojewodztwo], [Kraj], [KodPocztowy]) VALUES (3, N'GoodAlko', N'666-555-444', N'Mistrza', N'3', N'Suwalki', N'Warminsko-Mazurskie', N'Polska', N'23-422')
INSERT [dbo].[Dostawcy] ([id_dostawca], [Nazwa], [Telefon], [Ulica], [Nr], [Miasto], [Wojewodztwo], [Kraj], [KodPocztowy]) VALUES (4, N'DeutcheAbend', N'41-42-444321', N'AdiStraSSE', NULL, N'Hagen', NULL, N'Niemcy', N'11-111')
SET IDENTITY_INSERT [dbo].[Dostawcy] OFF
SET IDENTITY_INSERT [dbo].[Impreza] ON 

INSERT [dbo].[Impreza] ([id_impreza], [nazwaImprezy], [data_imprezy], [cena_wejsciowki]) VALUES (1, N'Wielkie opijanie', CAST(N'2018-05-12' AS Date), 20.0000)
INSERT [dbo].[Impreza] ([id_impreza], [nazwaImprezy], [data_imprezy], [cena_wejsciowki]) VALUES (2, N'Donguralesko&Koldi', CAST(N'2018-05-19' AS Date), 30.0000)
INSERT [dbo].[Impreza] ([id_impreza], [nazwaImprezy], [data_imprezy], [cena_wejsciowki]) VALUES (3, N'Patricio Zenone', CAST(N'2018-05-26' AS Date), 25.0000)
INSERT [dbo].[Impreza] ([id_impreza], [nazwaImprezy], [data_imprezy], [cena_wejsciowki]) VALUES (4, N'Najpierw DINX', CAST(N'2018-06-02' AS Date), 15.0000)
SET IDENTITY_INSERT [dbo].[Impreza] OFF
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (5, 1)
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (2, 2)
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (4, 2)
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (6, 3)
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (1, 4)
INSERT [dbo].[Impreza_artysci] ([id_artysta], [id_impreza]) VALUES (7, 4)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (1, 1)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 1)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 1)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (2, 2)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 2)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (1, 3)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (2, 3)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 3)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (1, 4)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (2, 4)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 4)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 4)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (2, 5)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 5)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (2, 6)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (3, 6)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 6)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (1, 7)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 7)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 8)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (1, 9)
INSERT [dbo].[Impreza_pracownicy] ([id_impreza], [id_pracownik]) VALUES (4, 9)
SET IDENTITY_INSERT [dbo].[Kasa] ON 

INSERT [dbo].[Kasa] ([id_kasa], [stan], [czy_aktywna]) VALUES (1, 500.0000, 1)
INSERT [dbo].[Kasa] ([id_kasa], [stan], [czy_aktywna]) VALUES (2, 300.0000, 1)
INSERT [dbo].[Kasa] ([id_kasa], [stan], [czy_aktywna]) VALUES (3, 0.0000, 0)
INSERT [dbo].[Kasa] ([id_kasa], [stan], [czy_aktywna]) VALUES (4, 300.0000, 0)
SET IDENTITY_INSERT [dbo].[Kasa] OFF
INSERT [dbo].[Kasa_Pracownicy] ([id_kasa], [id_pracownik]) VALUES (1, 2)
INSERT [dbo].[Kasa_Pracownicy] ([id_kasa], [id_pracownik]) VALUES (1, 3)
INSERT [dbo].[Kasa_Pracownicy] ([id_kasa], [id_pracownik]) VALUES (3, 4)
INSERT [dbo].[Kasa_Pracownicy] ([id_kasa], [id_pracownik]) VALUES (2, 5)
SET IDENTITY_INSERT [dbo].[Kategorie] ON 

INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (1, N'Wodka', N'Alkohol 40 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (2, N'Whisky/Burboun', N'Alkohol 40 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (3, N'Gin', N'Alkohol 40 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (4, N'Piwo', N'Alkohol 5 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (5, N'Wino', N'Alkohol 12 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (6, N'Koniak', N'Alkohol 40 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (7, N'Brandy', N'Alkohol 36 % +++')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (8, N'Napoj gazowany', N'Bezalkoholowe')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (9, N'Napoj niegazowany', N'Bezalkoholowe')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (10, N'Drink', N'Alkoholowy')
INSERT [dbo].[Kategorie] ([id_kategoria], [nazwa_kategorii], [opis]) VALUES (11, N'Przekaski', N'Cos do jedzenia')
SET IDENTITY_INSERT [dbo].[Kategorie] OFF
SET IDENTITY_INSERT [dbo].[Pracownicy] ON 

INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (1, N'Jerzy', N'Reclaw', N'Blotna', N'3A/3', N'Koscierzyna', N'Pomorskie', N'83-400', N'Polskie', 11, CAST(N'2009-05-20' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (2, N'Marcel', N'Zmeczerowski', N'Niewidzialna', N'3', N'Koscierzyna', N'Pomorskie', N'83-400', N'Niemieckie', 11, CAST(N'2009-05-20' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (3, N'Gregor', N'Makeev', N'Sikorskiego', N'4A/5', N'Gdansk', N'Pomorskie', N'81-500', N'Rosyjskie', 2, CAST(N'2013-02-10' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (4, N'Marcin', N'Różalski', N'Sikorskiego', N'4B/10', N'Gdansk', N'Pomorskie', N'81-500', N'Polskie', 1, CAST(N'2015-11-09' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (5, N'Marcin', N'Węgielski', N'Banacha', N'4', N'Sopot', N'Pomorskie', N'81-111', N'Polskie', 1, CAST(N'2013-10-09' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (6, N'Wlodzimierz', N'Smolarek', N'Mecikalna', N'3', N'Gdansk', N'Pomorskie', N'81-500', N'Polskie', 1, CAST(N'2015-11-19' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (7, N'Bartek', N'Lewandowski', N'Latawcowa', N'14', N'Gdansk', N'Pomorskie', N'81-500', N'Polskie', 5, CAST(N'2017-03-04' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (8, N'Anna', N'Parkinson', N'Mecikalna', N'14', N'Gdansk', N'Pomorskie', N'81-500', N'Polskie', 4, CAST(N'2016-10-10' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (9, N'Hans-Georg', N'Speath', N'Gdynska', N'1A/33', N'Pruszcz Gdanski', N'Pomorskie', N'72-130', N'Niemieckie', 7, CAST(N'2011-11-19' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (10, N'Izu', N'Ugonoh', N'Superancka', N'1A/2', N'Gdansk', N'Pomorskie', N'81-500', N'Polskie ', 8, CAST(N'2015-10-05' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (11, N'Tomasz', N'Oswiecimski', N'Gazowa', N'3', N'Oswiecim', N'Malopolskie', N'44-444', NULL, 8, CAST(N'2015-10-05' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (12, N'Konrad', N'Mazowiecki', N'Walenrodzka', N'69', N'Kurachen', N'Pomorskie', N'33-415', N'Polskie', 12, CAST(N'2014-01-01' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (13, N'Marcin', N'Golota', N'Falentowska', N'22', N'Koscierzyna', N'Pomorskie ', N'83-400', N'Polskie ', 12, CAST(N'2017-01-04' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (14, N'Henio', N'Genio', N'Koscierzynska', N'8', N'Kartuzy', N'Pomorskie', N'83-333', N'Zydowska', 6, CAST(N'2011-05-10' AS Date))
INSERT [dbo].[Pracownicy] ([id_pracownik], [imie], [nazwisko], [ulica], [nr_domu], [miasto], [wojewodztwo], [KodPocztowy], [obywatelstwo], [id_stanowisko], [data_zatrudnienia]) VALUES (15, N'Hans', N'Jubilacki', N'Nieeee', N'213', N'Gdynia', N'Pomorskie', N'88-888', N'Polskie', 10, CAST(N'2013-10-11' AS Date))
SET IDENTITY_INSERT [dbo].[Pracownicy] OFF
SET IDENTITY_INSERT [dbo].[Premia] ON 

INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (1, 0.1, N'Premia za dobre sprawowanie')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (2, 0.15, N'Premia za wyniki sprzedazy')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (3, 0.15, N'Premia swiateczna')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (4, 0.2, N'Premia za zostanie pracownikiem miesiaca')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (5, 0.2, N'Premia menadzerska za kolejne 10000 polubien na facebooku')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (6, 0.25, N'Premia za szczegolnie wybitne zachowanie')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (7, 0.05, N'Premia dodatkowa')
INSERT [dbo].[Premia] ([id_premii], [odsetek_premii], [opis]) VALUES (8, 3, N'Premia za przepracowane 10 lat w firmie')
SET IDENTITY_INSERT [dbo].[Premia] OFF
SET IDENTITY_INSERT [dbo].[Produkty] ON 

INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (1, N'Zubrowka', 8.0000, 1, N'Polmos', 50, 50, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (2, N'Sobieski', 9.0000, 1, N'Polmos', 30, 50, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (3, N'Finlandia', 10.0000, 1, N'LuxuryVodka', 30, 50, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (4, N'Absolut', 10.0000, 1, N'RuterCompany', 30, 50, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (5, N'Grants', 12.0000, 2, N'GoodWhiskey', 30, 50, 4)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (6, N'Jhonnie Walker', 12.0000, 2, N'GoodWhiskey', 42, 50, 4)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (7, N'Jack Daniels', 14.0000, 2, N'AmericanWhiskey', 30, 50, 4)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (8, N'Chivas Regal', 18.0000, 2, N'GodDammit', 12, 50, 4)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (9, N'Lubuski', 10.0000, 3, N'Polmos', 30, 50, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (10, N'Lech', 8.0000, 4, N'Kompania Piwowarska', 200, 500, 1)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (11, N'Tyskie', 8.0000, 4, N'Kompania Piwowarska', 300, 500, 1)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (12, N'Żubr', 7.0000, 4, N'Kompania Piwowarska', 200, 500, 1)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (13, N'Grolsh', 12.0000, 4, N'DaBeast', 100, 400, 1)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (14, N'Carlo Rossi czerwone', 15.0000, 5, N'WineczkaKochane', 30, 150, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (15, N'Carlo Rossi biale', 15.0000, 5, N'WineczkaKochane', 30, 150, 3)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (16, N'Coca Cola', 5.0000, 8, N'CocaColaCompany', 200, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (17, N'Fanta', 5.0000, 8, N'CocaColaCompany', 100, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (18, N'Sprite', 5.0000, 8, N'CocaColaCompany', 100, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (19, N'Nestea', 5.0000, 9, N'CocaColaCompany', 100, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (20, N'Kropla Beskidu gaz', 4.0000, 8, N'CocaColaCompany', 100, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (21, N'Kropla Beskidu ngaz', 4.0000, 9, N'CocaColaCompany', 100, 200, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (22, N'Lays paprykowe', 8.0000, 11, N'Lays', 12, 120, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (23, N'Lays cebulkowe', 8.0000, 11, N'Lays', 12, 120, 2)
INSERT [dbo].[Produkty] ([id_produkt], [nazwa_produktu], [cena_za_porcje], [id_kategoria], [producent], [stan_magazyn(w kg)], [gramatura_porcji], [id_dostawca]) VALUES (24, N'Orzeszki', 6.0000, 11, N'Skurrr', 20, 200, 2)
SET IDENTITY_INSERT [dbo].[Produkty] OFF
SET IDENTITY_INSERT [dbo].[StanowiskaPracy] ON 

INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (1, N'Barman', 15.0000, N'Osoba najbardziej odpowiedzialna za bar w firmie, do jej obowiazkow nalezy miedzy innymi kontrola barmanow')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (2, N'Kasjer', 13.0000, N'Osoba ta zajmuje sie kasowaniem biletow przy wejsciu na koncert')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (3, N'Kelner', 13.0000, N'Kelnerzy i kelnerki dbaja o to by goscie VIP mieli wszystko czego sobie zapragna')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (4, N'Kierownik baru', 40.0000, N'Zadaniem tej osoby jest robienie drinkow oraz podawanie napojii oraz przekasek')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (5, N'Kierownik sali', 25.0000, N'Kierownik zajmuje sie organizacja sali')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (6, N'Konserwator', 13.0000, N'Konserwatorzy dbaja o to by wszystko dzialalo poprawnie')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (7, N'Menadzer', 25.0000, N'Menadzer zalatwia artystow a takze organizuje koncerty')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (8, N'Ochroniarz', 18.0000, N'Ochroniarze zapewniaja porządek i uniemozliwiaja przemoc')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (9, N'Pomocnik', 14.0000, N'Zajmuje sie innymi rzeczami')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (10, N'Sprzatacz', 12.0000, N'Osoba ta jest odpowiedzialna za czystosc w trakcie imprezy a takze po zamknieciu klubu')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (11, N'Szef', 100.0000, N'Szefa trzeba sluchac, nie ma na to rady')
INSERT [dbo].[StanowiskaPracy] ([id_stanowisko], [nazwa_stanowiska], [stawka_godzinowa], [opis]) VALUES (12, N'Zmywak', 12.0000, N'Zmywaki nie maja mocno odpowiedzialnej pracy, ale za to musza dbac w szczegolnosci o czystosc')
SET IDENTITY_INSERT [dbo].[StanowiskaPracy] OFF
SET IDENTITY_INSERT [dbo].[StanowiskaUslug] ON 

INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (1, 1, 1)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (2, 1, 1)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (3, 0, 1)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (4, 1, 2)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (5, 1, 2)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (6, 0, 3)
INSERT [dbo].[StanowiskaUslug] ([id_stanowisko], [czy_wolne], [id_usluga]) VALUES (7, 1, 3)
SET IDENTITY_INSERT [dbo].[StanowiskaUslug] OFF
INSERT [dbo].[Urlopy] ([id_pracownik], [od_kiedy], [do_kiedy]) VALUES (3, CAST(N'2018-03-09' AS Date), CAST(N'2018-03-18' AS Date))
INSERT [dbo].[Urlopy] ([id_pracownik], [od_kiedy], [do_kiedy]) VALUES (3, CAST(N'2018-06-01' AS Date), CAST(N'2018-06-03' AS Date))
INSERT [dbo].[Urlopy] ([id_pracownik], [od_kiedy], [do_kiedy]) VALUES (4, CAST(N'2018-04-11' AS Date), CAST(N'2018-04-14' AS Date))
INSERT [dbo].[Urlopy] ([id_pracownik], [od_kiedy], [do_kiedy]) VALUES (7, CAST(N'2018-05-19' AS Date), CAST(N'2018-05-25' AS Date))
INSERT [dbo].[Urlopy] ([id_pracownik], [od_kiedy], [do_kiedy]) VALUES (9, CAST(N'2018-05-20' AS Date), CAST(N'2018-05-23' AS Date))
SET IDENTITY_INSERT [dbo].[Usługa] ON 

INSERT [dbo].[Usługa] ([id_usluga], [rodzaj_uslugi], [cena]) VALUES (1, N'Bilard', N'15')
INSERT [dbo].[Usługa] ([id_usluga], [rodzaj_uslugi], [cena]) VALUES (2, N'Pilkarzyki', N'8')
INSERT [dbo].[Usługa] ([id_usluga], [rodzaj_uslugi], [cena]) VALUES (3, N'Darts', N'8')
SET IDENTITY_INSERT [dbo].[Usługa] OFF
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (1, CAST(N'2018-05-01' AS Date), 230, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (2, CAST(N'2018-05-01' AS Date), 189, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (2, CAST(N'2018-06-01' AS Date), 140, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (3, CAST(N'2018-05-01' AS Date), 230, 2)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (3, CAST(N'2018-06-01' AS Date), 230, 2)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (4, CAST(N'2018-05-01' AS Date), 110, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (4, CAST(N'2018-06-01' AS Date), 160, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (5, CAST(N'2018-05-01' AS Date), 40, 4)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (5, CAST(N'2018-06-01' AS Date), 133, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (6, CAST(N'2018-05-01' AS Date), 165, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (6, CAST(N'2018-06-01' AS Date), 165, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (7, CAST(N'2018-05-01' AS Date), 190, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (7, CAST(N'2018-06-01' AS Date), 190, 4)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (8, CAST(N'2018-05-01' AS Date), 170, 1)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (8, CAST(N'2018-06-01' AS Date), 160, NULL)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (9, CAST(N'2018-05-01' AS Date), 170, 1)
INSERT [dbo].[Wyplata] ([id_pracownik], [data_wyplaty], [ilosc_godzin], [id_premia]) VALUES (9, CAST(N'2018-06-01' AS Date), 160, NULL)
/****** Object:  Index [UQ__Impreza__D213CBA7BE98861F]    Script Date: 04.06.2018 16:57:00 ******/
ALTER TABLE [dbo].[Impreza] ADD UNIQUE NONCLUSTERED 
(
	[data_imprezy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Stanowis__A378BDF2475594EA]    Script Date: 04.06.2018 16:57:00 ******/
ALTER TABLE [dbo].[StanowiskaPracy] ADD UNIQUE NONCLUSTERED 
(
	[nazwa_stanowiska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Kasa] ADD  DEFAULT ((300)) FOR [stan]
GO
ALTER TABLE [dbo].[Impreza_artysci]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_artysci_Artysci] FOREIGN KEY([id_artysta])
REFERENCES [dbo].[Artysci] ([id_artysta])
GO
ALTER TABLE [dbo].[Impreza_artysci] CHECK CONSTRAINT [FK_Impreza_artysci_Artysci]
GO
ALTER TABLE [dbo].[Impreza_artysci]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_artysci_Impreza] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Impreza] ([id_impreza])
GO
ALTER TABLE [dbo].[Impreza_artysci] CHECK CONSTRAINT [FK_Impreza_artysci_Impreza]
GO
ALTER TABLE [dbo].[Impreza_pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_pracownicy_Impreza] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Impreza] ([id_impreza])
GO
ALTER TABLE [dbo].[Impreza_pracownicy] CHECK CONSTRAINT [FK_Impreza_pracownicy_Impreza]
GO
ALTER TABLE [dbo].[Impreza_pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_pracownicy_Pracownicy] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Impreza_pracownicy] CHECK CONSTRAINT [FK_Impreza_pracownicy_Pracownicy]
GO
ALTER TABLE [dbo].[Kasa_Pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Kasa_Pracownicy_Kasa] FOREIGN KEY([id_kasa])
REFERENCES [dbo].[Kasa] ([id_kasa])
GO
ALTER TABLE [dbo].[Kasa_Pracownicy] CHECK CONSTRAINT [FK_Kasa_Pracownicy_Kasa]
GO
ALTER TABLE [dbo].[Kasa_Pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Kasa_Pracownicy_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Kasa_Pracownicy] CHECK CONSTRAINT [FK_Kasa_Pracownicy_Pracownicy]
GO
ALTER TABLE [dbo].[Pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Pracownicy_StanowiskaPracy] FOREIGN KEY([id_stanowisko])
REFERENCES [dbo].[StanowiskaPracy] ([id_stanowisko])
GO
ALTER TABLE [dbo].[Pracownicy] CHECK CONSTRAINT [FK_Pracownicy_StanowiskaPracy]
GO
ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_Dostawcy] FOREIGN KEY([id_dostawca])
REFERENCES [dbo].[Dostawcy] ([id_dostawca])
GO
ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_Dostawcy]
GO
ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_Kategorie] FOREIGN KEY([id_kategoria])
REFERENCES [dbo].[Kategorie] ([id_kategoria])
GO
ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_Kategorie]
GO
ALTER TABLE [dbo].[StanowiskaUslug]  WITH CHECK ADD  CONSTRAINT [FK_StanowiskaUslug_Usługa] FOREIGN KEY([id_usluga])
REFERENCES [dbo].[Usługa] ([id_usluga])
GO
ALTER TABLE [dbo].[StanowiskaUslug] CHECK CONSTRAINT [FK_StanowiskaUslug_Usługa]
GO
ALTER TABLE [dbo].[Urlopy]  WITH CHECK ADD  CONSTRAINT [FK_Urlopy_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Urlopy] CHECK CONSTRAINT [FK_Urlopy_Pracownicy]
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD  CONSTRAINT [FK_Wyplata_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Wyplata] CHECK CONSTRAINT [FK_Wyplata_Pracownicy]
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD  CONSTRAINT [FK_Wyplata_Premia] FOREIGN KEY([id_premia])
REFERENCES [dbo].[Premia] ([id_premii])
GO
ALTER TABLE [dbo].[Wyplata] CHECK CONSTRAINT [FK_Wyplata_Premia]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_SzczegolySprzedazy_Produkty] FOREIGN KEY([id_produkt])
REFERENCES [dbo].[Produkty] ([id_produkt])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_SzczegolySprzedazy_Produkty]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_Kasa] FOREIGN KEY([id_kasa])
REFERENCES [dbo].[Kasa] ([id_kasa])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_Kasa]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_StanowiskaUslug] FOREIGN KEY([id_stanowisko])
REFERENCES [dbo].[StanowiskaUslug] ([id_stanowisko])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_StanowiskaUslug]
GO
ALTER TABLE [dbo].[Artysci]  WITH CHECK ADD CHECK  (([placa]>(100)))
GO
ALTER TABLE [dbo].[StanowiskaPracy]  WITH CHECK ADD CHECK  (([stawka_godzinowa]>=(10)))
GO
ALTER TABLE [dbo].[Wyplata]  WITH CHECK ADD CHECK  (([ilosc_godzin]<(500)))
GO
