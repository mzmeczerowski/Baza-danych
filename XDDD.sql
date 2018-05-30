USE [KlubRozrywki]
GO
/****** Object:  Table [dbo].[Artysci]    Script Date: 30.05.2018 10:30:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artysci](
	[id_artysta] [int] NOT NULL,
	[nazwa] [varchar](20) NOT NULL,
	[kontakt] [varchar](20) NULL,
	[profesja] [varchar](20) NULL,
	[placa] [money] NOT NULL,
 CONSTRAINT [PK_Artysci] PRIMARY KEY CLUSTERED 
(
	[id_artysta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dostawcy]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dostawcy](
	[id_dostawca] [int] NOT NULL,
	[Nazwa] [varchar](30) NOT NULL,
	[Telefon] [varchar](15) NULL,
	[Adres] [varchar](20) NULL,
	[Miasto] [varchar](20) NULL,
	[Wojewodztwo] [varchar](20) NULL,
	[Kraj] [varchar](20) NULL,
	[KodPocztowy] [nchar](6) NULL,
 CONSTRAINT [PK_Dostawcy] PRIMARY KEY CLUSTERED 
(
	[id_dostawca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impreza]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza](
	[id_impreza] [int] NOT NULL,
	[nazwaImprezy] [varchar](20) NOT NULL,
	[id_pracownik] [int] NOT NULL,
	[data_imprezy] [date] NOT NULL,
	[id_artysta] [int] NULL,
	[cena_wejsciowki] [money] NULL,
 CONSTRAINT [PK_Impreza] PRIMARY KEY CLUSTERED 
(
	[id_impreza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impreza_artysci]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza_artysci](
	[id_artysta] [int] NOT NULL,
	[id_impreza] [int] NOT NULL,
 CONSTRAINT [PK_Impreza_artysci] PRIMARY KEY CLUSTERED 
(
	[id_artysta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impreza_pracownicy]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Impreza_pracownicy](
	[id_impreza] [int] NOT NULL,
	[id_pracownicy] [int] NOT NULL,
 CONSTRAINT [PK_Impreza_pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_pracownicy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kasa]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kasa](
	[id_kasa] [tinyint] NOT NULL,
	[id_pracownik] [int] NOT NULL,
	[stan] [money] NULL,
	[czy_aktywna] [bit] NULL,
 CONSTRAINT [PK_Kasa] PRIMARY KEY CLUSTERED 
(
	[id_kasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategorie]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategorie](
	[id_kategoria] [int] NOT NULL,
	[nazwa_kategorii] [varchar](20) NOT NULL,
	[opis] [text] NOT NULL,
 CONSTRAINT [PK_Kategorie] PRIMARY KEY CLUSTERED 
(
	[id_kategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pracownicy]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pracownicy](
	[id_pracownik] [int] NOT NULL,
	[imie] [varchar](20) NOT NULL,
	[nazwisko] [varchar](20) NOT NULL,
	[adres] [varchar](20) NULL,
	[miasto] [varchar](20) NULL,
	[wojewodztwo] [varchar](20) NULL,
	[KodPocztowy] [char](6) NULL,
	[obywatelstwo] [varchar](20) NULL,
	[zdjecie] [image] NULL,
	[stanowisko] [varchar](20) NOT NULL,
	[data_zatrudnienia] [date] NULL,
 CONSTRAINT [PK_Pracownicy] PRIMARY KEY CLUSTERED 
(
	[id_pracownik] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Premia]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Premia](
	[id_premii] [int] NOT NULL,
	[odsetek_premii] [float] NULL,
	[opis] [nchar](10) NULL,
 CONSTRAINT [PK_Premia] PRIMARY KEY CLUSTERED 
(
	[id_premii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produkty]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produkty](
	[id_produkt] [int] NOT NULL,
	[nazwa_produktu] [varchar](30) NOT NULL,
	[cena] [money] NULL,
	[id_kategoria] [int] NOT NULL,
	[producent] [varchar](50) NULL,
	[stan_magazyn] [int] NULL,
	[gramatura] [float] NULL,
	[id_dostawca] [int] NOT NULL,
 CONSTRAINT [PK_Produkty] PRIMARY KEY CLUSTERED 
(
	[id_produkt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StanowiskaPracy]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StanowiskaPracy](
	[stanowisko] [varchar](20) NOT NULL,
	[stavka_godzinowa] [money] NOT NULL,
	[opis] [text] NULL,
 CONSTRAINT [PK_StanowiskaPracy] PRIMARY KEY CLUSTERED 
(
	[stanowisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StanowiskaUslug]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StanowiskaUslug](
	[id_stanowisko] [int] NOT NULL,
	[czy_wolne] [bit] NOT NULL,
	[procent_zuzycia] [tinyint] NULL,
 CONSTRAINT [PK_StanowiskaUslug] PRIMARY KEY CLUSTERED 
(
	[id_stanowisko] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Urlopy]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Urlopy](
	[id_pracownik] [int] NOT NULL,
	[od_kiedy] [date] NOT NULL,
	[do_kiedy] [date] NOT NULL,
 CONSTRAINT [PK_Urlopy] PRIMARY KEY CLUSTERED 
(
	[od_kiedy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usługa]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usługa](
	[id_usluga] [int] NOT NULL,
	[rodzaj_uslugi] [varchar](20) NOT NULL,
	[cena] [varchar](20) NOT NULL,
	[id_stanowisko] [int] NOT NULL,
 CONSTRAINT [PK_Usługa] PRIMARY KEY CLUSTERED 
(
	[id_usluga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wejsciowki]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wejsciowki](
	[id_imprezy] [int] NOT NULL,
	[cena] [money] NOT NULL,
	[ilosc] [smallint] NOT NULL,
	[id_zamowienie] [int] NOT NULL,
 CONSTRAINT [PK_Wejsciowki] PRIMARY KEY CLUSTERED 
(
	[id_imprezy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wyplata]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wyplata](
	[id_pracownik] [int] NOT NULL,
	[data_wyplaty] [date] NOT NULL,
	[ilosc_godzin] [int] NOT NULL,
	[suma] [money] NOT NULL,
	[id_premia] [int] NULL,
 CONSTRAINT [PK_Wyplata] PRIMARY KEY CLUSTERED 
(
	[data_wyplaty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 30.05.2018 10:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[id_zamowienie] [int] NOT NULL,
	[ilosc] [tinyint] NOT NULL,
	[cena_za_sztuke] [money] NOT NULL,
	[id_produkt] [int] NULL,
	[promocja] [float] NULL,
	[id_usluga] [int] NULL,
	[id_kasa] [tinyint] NOT NULL,
	[data_zamowienia] [datetime] NOT NULL,
	[id_impreza] [int] NULL,
 CONSTRAINT [PK_SzczegolySprzedazy] PRIMARY KEY CLUSTERED 
(
	[id_zamowienie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Impreza]  WITH CHECK ADD  CONSTRAINT [FK_Impreza_Wejsciowki] FOREIGN KEY([id_impreza])
REFERENCES [dbo].[Wejsciowki] ([id_imprezy])
GO
ALTER TABLE [dbo].[Impreza] CHECK CONSTRAINT [FK_Impreza_Wejsciowki]
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
ALTER TABLE [dbo].[Kasa]  WITH CHECK ADD  CONSTRAINT [FK_Kasa_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Kasa] CHECK CONSTRAINT [FK_Kasa_Pracownicy]
GO
ALTER TABLE [dbo].[Pracownicy]  WITH CHECK ADD  CONSTRAINT [FK_Pracownicy_StanowiskaPracy] FOREIGN KEY([stanowisko])
REFERENCES [dbo].[StanowiskaPracy] ([stanowisko])
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
ALTER TABLE [dbo].[Urlopy]  WITH CHECK ADD  CONSTRAINT [FK_Urlopy_Pracownicy] FOREIGN KEY([id_pracownik])
REFERENCES [dbo].[Pracownicy] ([id_pracownik])
GO
ALTER TABLE [dbo].[Urlopy] CHECK CONSTRAINT [FK_Urlopy_Pracownicy]
GO
ALTER TABLE [dbo].[Usługa]  WITH CHECK ADD  CONSTRAINT [FK_Usługa_StanowiskaUslug] FOREIGN KEY([id_stanowisko])
REFERENCES [dbo].[StanowiskaUslug] ([id_stanowisko])
GO
ALTER TABLE [dbo].[Usługa] CHECK CONSTRAINT [FK_Usługa_StanowiskaUslug]
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
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_Usługa] FOREIGN KEY([id_usluga])
REFERENCES [dbo].[Usługa] ([id_usluga])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_Usługa]
GO
