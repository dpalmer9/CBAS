USE [PubScreen]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Affiliation] [nvarchar](max) NULL,
	[username] [nvarchar](max) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaperType]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaperType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PaperType] [nvarchar](300) NULL,
 CONSTRAINT [PK_PaperType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Author]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Author](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
	[AuthorOrder] [int] NULL,
 CONSTRAINT [PK_Publication_Author] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Task] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubTask]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubTask](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NOT NULL,
	[SubTask] [nvarchar](max) NULL,
 CONSTRAINT [PK_SubTask] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_CellType]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_CellType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CelltypeID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_CellType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_SubTask]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_SubTask](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubTaskID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_SubTask] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BrainRegion]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BrainRegion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BrainRegion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_BrainRegion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Disease]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Disease](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DiseaseID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Disease] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Method]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Method](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MethodID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Method] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PaperLinkGuid] [uniqueidentifier] NOT NULL,
	[Title] [text] NULL,
	[Abstract] [text] NULL,
	[Keywords] [text] NULL,
	[DOI] [nvarchar](max) NULL,
	[Year] [nvarchar](10) NULL,
	[Reference] [text] NULL,
	[Username] [nvarchar](50) NULL,
	[Source] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaperInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_NeuroTransmitter]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_NeuroTransmitter](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransmitterID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_NeuroTransmitter] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Sex]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Sex](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SexID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Sex] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_PaperType]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_PaperType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PaperTypeID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_PaperType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Specie]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Specie](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SpecieID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Specie] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Method]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Method](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Method] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_Method] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Strain]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Strain](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StrainID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Strain] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Species]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Species](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Species] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_Species] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubModel]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubModel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubModel] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NULL,
	[ModelID] [int] NULL,
 CONSTRAINT [PK__SubModel__3214EC2754CAE51F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubRegion]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubRegion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RID] [int] NOT NULL,
	[SubRegion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SubRegion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Task]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Task](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Task] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CellType]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CellType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CellType] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_CellType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_SubModel]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_SubModel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubModelID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_SubRegion]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_SubRegion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubRegionID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_SubRegion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sex]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sex](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Sex] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Sex] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Neurotransmitter]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Neurotransmitter](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NeuroTransmitter] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_Neurotransmitter] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiseaseModel]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiseaseModel](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DiseaseModel] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](max) NULL,
 CONSTRAINT [PK_DiseaseModel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Strain]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strain](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Strain] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](max) NULL,
	[SpeciesID] [int] NULL,
 CONSTRAINT [PK_Strain] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_Region]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_Region](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
 CONSTRAINT [PK_Publication_Region] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubMethod]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubMethod](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubMethod] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](max) NULL,
	[MethodID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication_SubMethod]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication_SubMethod](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubMethodID] [int] NOT NULL,
	[PublicationID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SearchPub]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SearchPub]
AS
SELECT Publication.ID, PaperLinkGuid, Title, Abstract, Keywords, DOI, Reference, Username, Source, Year, STUFF
                      ((SELECT ', ' + CONCAT(Author.FirstName, '-', Author.LastName)
                        FROM      Publication_Author INNER JOIN
                                          Author ON Author.ID = Publication_Author.AuthorID
                        WHERE   Publication_Author.PublicationID = Publication.ID
                        ORDER BY AuthorOrder FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Author, PaperType.PaperType, STUFF
                      ((SELECT DISTINCT ', ' + Task.Task
                        FROM      Publication_Task INNER JOIN
                                          Task ON Task.ID = Publication_Task.TaskID
                        WHERE   Publication_Task.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Task, STUFF
                      ((SELECT DISTINCT ', ' + SubTask.SubTask
                        FROM      Publication_SubTask INNER JOIN
                                          SubTask ON SubTask.ID = Publication_SubTask.SubTaskID
                        WHERE   Publication_SubTask.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS SubTask, STUFF
                      ((SELECT DISTINCT ', ' + Species.Species
                        FROM      Publication_Specie INNER JOIN
                                          Species ON Species.ID = Publication_Specie.SpecieID
                        WHERE   Publication_Specie.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Species, STUFF
                      ((SELECT DISTINCT ', ' + Sex.Sex
                        FROM      Publication_Sex INNER JOIN
                                          Sex ON Sex.ID = Publication_Sex.SexID
                        WHERE   Publication_Sex.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Sex, STUFF
                      ((SELECT DISTINCT ', ' + Strain.Strain
                        FROM      Publication_Strain INNER JOIN
                                          Strain ON Strain.ID = Publication_Strain.StrainID
                        WHERE   Publication_Strain.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Strain, STUFF
                      ((SELECT DISTINCT ', ' + DiseaseModel.DiseaseModel
                        FROM      Publication_Disease INNER JOIN
                                          DiseaseModel ON DiseaseModel.ID = Publication_Disease.DiseaseID
                        WHERE   Publication_Disease.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS DiseaseModel, STUFF
                      ((SELECT DISTINCT ', ' + SubModel.SubModel
                        FROM      Publication_SubModel INNER JOIN
                                          SubModel ON SubModel.ID = Publication_SubModel.SubModelID
                        WHERE   Publication_SubModel.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS SubModel, STUFF
                      ((SELECT DISTINCT ', ' + BrainRegion.BrainRegion
                        FROM      Publication_Region INNER JOIN
                                          BrainRegion ON BrainRegion.ID = Publication_Region.RegionID
                        WHERE   Publication_Region.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS BrainRegion, STUFF
                      ((SELECT DISTINCT ', ' + SubRegion.SubRegion
                        FROM      Publication_SubRegion INNER JOIN
                                          SubRegion ON SubRegion.ID = Publication_SubRegion.SubRegionID
                        WHERE   Publication_SubRegion.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS SubRegion, STUFF
                      ((SELECT DISTINCT ', ' + CellType.CellType
                        FROM      Publication_CellType INNER JOIN
                                          CellType ON CellType.ID = Publication_CellType.CelltypeID
                        WHERE   Publication_CellType.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS CellType, STUFF
                      ((SELECT DISTINCT ', ' + Method.Method
                        FROM      Publication_Method INNER JOIN
                                          Method ON Method.ID = Publication_Method.MethodID
                        WHERE   Publication_Method.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS Method, STUFF
                      ((SELECT DISTINCT ', ' + SubMethod.SubMethod
                        FROM      Publication_SubMethod INNER JOIN
                                          SubMethod ON SubMethod.ID = Publication_SubMethod.SubMethodID
                        WHERE   Publication_SubMethod.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS SubMethod, STUFF
                      ((SELECT DISTINCT ', ' + Neurotransmitter.NeuroTransmitter
                        FROM      Publication_NeuroTransmitter INNER JOIN
                                          Neurotransmitter ON Neurotransmitter.ID = Publication_NeuroTransmitter.TransmitterID
                        WHERE   Publication_NeuroTransmitter.PublicationID = Publication.ID FOR XML PATH(''), type ).value('.', 'nvarchar(max)'), 1, 2, '') AS NeuroTransmitter
FROM     Publication LEFT JOIN
                  Publication_PaperType AS PP ON PP.PublicationID = Publication.ID LEFT JOIN
                  PaperType ON PaperType.ID = PP.PaperTypeID
GO
/****** Object:  View [dbo].[dashboard_data_with_keyfeatures]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[dashboard_data_with_keyfeatures] AS
Select * From SearchPub
Where  (task is not null or species is not NUll or sex is not Null or Strain is not null or DiseaseModel is not null or BrainRegion is not null
	or CellType is not null or method is not null or Neurotransmitter is not null);
GO
/****** Object:  View [dbo].[view_temp]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_temp] AS 
Select Publication.ID, DOI, Year, Task.Task, SubTask.SubTask From Publication
 inner join Publication_Task on Publication_Task.PublicationID = Publication.ID
 inner join Task on Task.ID = Publication_Task.TaskID
 inner join SubTask on SubTask.TaskID = Task.ID
GO
/****** Object:  View [dbo].[spotfire_dashboard]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[spotfire_dashboard] as

Select Publication.*, Task.Task, subTask.SubTask, Strain.Strain, sex.Sex, Species.Species, DiseaseModel.DiseaseModel, 
SubModel.SubModel, BrainRegion.BrainRegion, SubRegion.SubRegion, CellType.CellType, Method.Method, SubMethod.SubMethod, Neurotransmitter.NeuroTransmitter

From Publication 
left join Publication_Task as pt on pt.PublicationID = Publication.ID
left join Task on Task.ID = pt.TaskID 
left join Publication_SubTask as ps on ps.PublicationID = Publication.ID
inner join SubTask  on SubTask.ID = ps.SubTaskID  and  SubTask.TaskID = Task.ID

left join Publication_Specie on Publication_Specie.PublicationID = Publication.ID
left join Species on Species.ID = Publication_Specie.SpecieID

left join Publication_Sex on Publication_Sex.PublicationID = Publication.ID
left join Sex on Sex.ID = Publication_Sex.SexID

left join Publication_Strain on Publication_Strain.PublicationID = Publication.ID
left join Strain on Strain.ID = Publication_Strain.StrainID

left join Publication_Disease on Publication_Disease.PublicationID = Publication.ID
left join DiseaseModel on DiseaseModel.ID = Publication_Disease.DiseaseID
left join Publication_SubModel on Publication_SubModel.PublicationID = Publication.ID
left join SubModel  on SubModel.ID = Publication_SubModel.SubModelID  and  SubModel.ModelID = DiseaseModel.ID

left join Publication_Region on Publication_Region.PublicationID = Publication.ID
left join BrainRegion on BrainRegion.ID = Publication_Region.RegionID
left join Publication_SubRegion on Publication_SubRegion.PublicationID = Publication.ID
left join SubRegion  on SubRegion.ID = Publication_SubRegion.SubRegionID  and  SubRegion.RID = BrainRegion.ID

left join Publication_CellType on Publication_CellType.PublicationID = Publication.ID
left join CellType on CellType.ID = Publication_CellType.CelltypeID

left join Publication_Method on Publication_Method.PublicationID = Publication.ID
left join Method on Method.ID = Publication_Method.MethodID
left join Publication_SubMethod on Publication_SubMethod.PublicationID = Publication.ID
left join SubMethod  on SubMethod.ID = Publication_SubMethod.SubMethodID  and  SubMethod.MethodID = Method.ID

left join Publication_Neurotransmitter on Publication_Neurotransmitter.PublicationID = Publication.ID
left join Neurotransmitter on Neurotransmitter.ID = Publication_Neurotransmitter.TransmitterID
GO
/****** Object:  Table [dbo].[DateQueueUpdated]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateQueueUpdated](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[IsError] [bit] NOT NULL,
 CONSTRAINT [PK_DateQueueUpdated] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EditLog]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PubID] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[EditDate] [date] NOT NULL,
	[ChangeLog] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK__EditLog__3214EC27D97461D3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PubmedQueue]    Script Date: 4/23/2025 12:04:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PubmedQueue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PubmedID] [int] NOT NULL,
	[PubDate] [date] NOT NULL,
	[QueueDate] [date] NOT NULL,
	[DOI] [nvarchar](max) NULL,
	[IsProcessed] [bit] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK__Pubmed_Q__3214EC27C02CC8FC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Publication] ADD  CONSTRAINT [DF__Publicati__Paper__40C49C62]  DEFAULT (newid()) FOR [PaperLinkGuid]
GO
ALTER TABLE [dbo].[PubmedQueue] ADD  CONSTRAINT [DF_PubmedQueue_IsProcessed]  DEFAULT ((0)) FOR [IsProcessed]
GO
ALTER TABLE [dbo].[EditLog]  WITH CHECK ADD  CONSTRAINT [FK__EditLog__PubID__6CA31EA0] FOREIGN KEY([PubID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[EditLog] CHECK CONSTRAINT [FK__EditLog__PubID__6CA31EA0]
GO
ALTER TABLE [dbo].[Publication_Author]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Author_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([ID])
GO
ALTER TABLE [dbo].[Publication_Author] CHECK CONSTRAINT [FK_Publication_Author_Author]
GO
ALTER TABLE [dbo].[Publication_Author]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Author_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Author] CHECK CONSTRAINT [FK_Publication_Author_Publication]
GO
ALTER TABLE [dbo].[Publication_CellType]  WITH CHECK ADD  CONSTRAINT [FK_Publication_CellType_CellType] FOREIGN KEY([CelltypeID])
REFERENCES [dbo].[CellType] ([ID])
GO
ALTER TABLE [dbo].[Publication_CellType] CHECK CONSTRAINT [FK_Publication_CellType_CellType]
GO
ALTER TABLE [dbo].[Publication_CellType]  WITH CHECK ADD  CONSTRAINT [FK_Publication_CellType_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_CellType] CHECK CONSTRAINT [FK_Publication_CellType_Publication]
GO
ALTER TABLE [dbo].[Publication_Disease]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Disease_Disease] FOREIGN KEY([DiseaseID])
REFERENCES [dbo].[DiseaseModel] ([ID])
GO
ALTER TABLE [dbo].[Publication_Disease] CHECK CONSTRAINT [FK_Publication_Disease_Disease]
GO
ALTER TABLE [dbo].[Publication_Disease]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Disease_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Disease] CHECK CONSTRAINT [FK_Publication_Disease_Publication]
GO
ALTER TABLE [dbo].[Publication_Method]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Method_Method] FOREIGN KEY([MethodID])
REFERENCES [dbo].[Method] ([ID])
GO
ALTER TABLE [dbo].[Publication_Method] CHECK CONSTRAINT [FK_Publication_Method_Method]
GO
ALTER TABLE [dbo].[Publication_Method]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Method_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Method] CHECK CONSTRAINT [FK_Publication_Method_Publication]
GO
ALTER TABLE [dbo].[Publication_NeuroTransmitter]  WITH CHECK ADD  CONSTRAINT [FK_Publication_NeuroTransmitter_NeuroTransmitter] FOREIGN KEY([TransmitterID])
REFERENCES [dbo].[Neurotransmitter] ([ID])
GO
ALTER TABLE [dbo].[Publication_NeuroTransmitter] CHECK CONSTRAINT [FK_Publication_NeuroTransmitter_NeuroTransmitter]
GO
ALTER TABLE [dbo].[Publication_NeuroTransmitter]  WITH CHECK ADD  CONSTRAINT [FK_Publication_NeuroTransmitter_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_NeuroTransmitter] CHECK CONSTRAINT [FK_Publication_NeuroTransmitter_Publication]
GO
ALTER TABLE [dbo].[Publication_PaperType]  WITH CHECK ADD  CONSTRAINT [FK_Publication_PaperType_PaperType] FOREIGN KEY([PaperTypeID])
REFERENCES [dbo].[PaperType] ([ID])
GO
ALTER TABLE [dbo].[Publication_PaperType] CHECK CONSTRAINT [FK_Publication_PaperType_PaperType]
GO
ALTER TABLE [dbo].[Publication_PaperType]  WITH CHECK ADD  CONSTRAINT [FK_Publication_PaperType_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_PaperType] CHECK CONSTRAINT [FK_Publication_PaperType_Publication]
GO
ALTER TABLE [dbo].[Publication_Region]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Region_BrainRegion] FOREIGN KEY([RegionID])
REFERENCES [dbo].[BrainRegion] ([ID])
GO
ALTER TABLE [dbo].[Publication_Region] CHECK CONSTRAINT [FK_Publication_Region_BrainRegion]
GO
ALTER TABLE [dbo].[Publication_Region]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Region_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Region] CHECK CONSTRAINT [FK_Publication_Region_Publication]
GO
ALTER TABLE [dbo].[Publication_Sex]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Sex_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Sex] CHECK CONSTRAINT [FK_Publication_Sex_Publication]
GO
ALTER TABLE [dbo].[Publication_Sex]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Sex_Sex] FOREIGN KEY([SexID])
REFERENCES [dbo].[Sex] ([ID])
GO
ALTER TABLE [dbo].[Publication_Sex] CHECK CONSTRAINT [FK_Publication_Sex_Sex]
GO
ALTER TABLE [dbo].[Publication_Specie]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Specie_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Specie] CHECK CONSTRAINT [FK_Publication_Specie_Publication]
GO
ALTER TABLE [dbo].[Publication_Specie]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Specie_Specie] FOREIGN KEY([SpecieID])
REFERENCES [dbo].[Species] ([ID])
GO
ALTER TABLE [dbo].[Publication_Specie] CHECK CONSTRAINT [FK_Publication_Specie_Specie]
GO
ALTER TABLE [dbo].[Publication_Strain]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Strain_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Strain] CHECK CONSTRAINT [FK_Publication_Strain_Publication]
GO
ALTER TABLE [dbo].[Publication_Strain]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Strain_Strain] FOREIGN KEY([StrainID])
REFERENCES [dbo].[Strain] ([ID])
GO
ALTER TABLE [dbo].[Publication_Strain] CHECK CONSTRAINT [FK_Publication_Strain_Strain]
GO
ALTER TABLE [dbo].[Publication_SubMethod]  WITH CHECK ADD FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubMethod]  WITH CHECK ADD FOREIGN KEY([SubMethodID])
REFERENCES [dbo].[SubMethod] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubModel]  WITH CHECK ADD FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubModel]  WITH CHECK ADD FOREIGN KEY([SubModelID])
REFERENCES [dbo].[SubModel] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubRegion]  WITH CHECK ADD  CONSTRAINT [FK_Publication_SubRegion_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubRegion] CHECK CONSTRAINT [FK_Publication_SubRegion_Publication]
GO
ALTER TABLE [dbo].[Publication_SubRegion]  WITH CHECK ADD  CONSTRAINT [FK_Publication_SubRegion_SubRegion] FOREIGN KEY([SubRegionID])
REFERENCES [dbo].[SubRegion] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubRegion] CHECK CONSTRAINT [FK_Publication_SubRegion_SubRegion]
GO
ALTER TABLE [dbo].[Publication_SubTask]  WITH CHECK ADD  CONSTRAINT [FK_Publication_SubTask_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubTask] CHECK CONSTRAINT [FK_Publication_SubTask_Publication]
GO
ALTER TABLE [dbo].[Publication_SubTask]  WITH CHECK ADD  CONSTRAINT [FK_Publication_SubTask_SubTask] FOREIGN KEY([SubTaskID])
REFERENCES [dbo].[SubTask] ([ID])
GO
ALTER TABLE [dbo].[Publication_SubTask] CHECK CONSTRAINT [FK_Publication_SubTask_SubTask]
GO
ALTER TABLE [dbo].[Publication_Task]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Task_Publication] FOREIGN KEY([PublicationID])
REFERENCES [dbo].[Publication] ([ID])
GO
ALTER TABLE [dbo].[Publication_Task] CHECK CONSTRAINT [FK_Publication_Task_Publication]
GO
ALTER TABLE [dbo].[Publication_Task]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Task_Task] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Task] ([ID])
GO
ALTER TABLE [dbo].[Publication_Task] CHECK CONSTRAINT [FK_Publication_Task_Task]
GO
ALTER TABLE [dbo].[Strain]  WITH CHECK ADD FOREIGN KEY([SpeciesID])
REFERENCES [dbo].[Species] ([ID])
GO
ALTER TABLE [dbo].[SubMethod]  WITH CHECK ADD FOREIGN KEY([MethodID])
REFERENCES [dbo].[Method] ([ID])
GO
ALTER TABLE [dbo].[SubModel]  WITH CHECK ADD  CONSTRAINT [FK__SubModel__ModelI__2116E6DF] FOREIGN KEY([ModelID])
REFERENCES [dbo].[DiseaseModel] ([ID])
GO
ALTER TABLE [dbo].[SubModel] CHECK CONSTRAINT [FK__SubModel__ModelI__2116E6DF]
GO
ALTER TABLE [dbo].[SubRegion]  WITH CHECK ADD  CONSTRAINT [FK_Region_SubREgion] FOREIGN KEY([RID])
REFERENCES [dbo].[BrainRegion] ([ID])
GO
ALTER TABLE [dbo].[SubRegion] CHECK CONSTRAINT [FK_Region_SubREgion]
GO
ALTER TABLE [dbo].[SubTask]  WITH CHECK ADD  CONSTRAINT [FK_SubTask_Task] FOREIGN KEY([TaskID])
REFERENCES [dbo].[Task] ([ID])
GO
ALTER TABLE [dbo].[SubTask] CHECK CONSTRAINT [FK_SubTask_Task]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[33] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SearchPub'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SearchPub'
GO
