IF DB_ID(N'DB_TestDeveloper') IS NULL
BEGIN
	CREATE DATABASE [DB_TestDeveloper]
END
GO
ALTER DATABASE [DB_TestDeveloper] SET COMPATIBILITY_LEVEL = 130
GO
USE [DB_TestDeveloper]
GO

/****** Object:  Table [dbo].[Anggota] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Anggota]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Anggota](
		[AnggotaID] [varchar](20) NOT NULL,
		[BranchID] [varchar](10) NOT NULL,
		[KaryawanID] [varchar](10) NOT NULL,
		[Plafond] [nchar](16) NOT NULL,
		[isValid] [bit] NOT NULL,
		[void] [bit] NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_Anggota] PRIMARY KEY CLUSTERED 
	(
		[AnggotaID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Branch] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Branch]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Branch](
		[BranchID] [varchar](10) NOT NULL,
		[BranchFullName] [varchar](100) NOT NULL,
		[BranchAddress] [varchar](200) NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
	(
		[BranchID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Departments] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Departments]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Departments](
		[dept_id] [nchar](16) NOT NULL,
		[dept_parentid] [nchar](16) NULL,
		[dept_name] [nchar](100) NOT NULL,
	 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
	(
		[dept_id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DetailKaryawan] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[DetailKaryawan]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[DetailKaryawan](
		[KaryawanID] [varchar](10) NOT NULL,
		[FirstName] [varchar](50) NOT NULL,
		[MiddleName] [varchar](50) NULL,
		[LastName] [varchar](50) NULL,
		[EmailAddress] [varchar](50) NULL,
		[Phone] [varchar](50) NULL,
		[BirthDate] [datetime] NULL,
		[BirthPlace] [nchar](200) NULL,
		[MaritalStatus] [varchar](10) NULL,
		[Gender] [varchar](10) NULL,
		[Other] [nchar](60) NULL,
		[HP] [nchar](100) NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_DetailKaryawan] PRIMARY KEY CLUSTERED 
	(
		[KaryawanID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Karyawan] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[Karyawan]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[Karyawan](
		[KaryawanID] [varchar](10) NOT NULL,
		[BranchID] [varchar](10) NOT NULL,
		[Isactive] [bit] NOT NULL,
		[Dept_ID] [nchar](16) NOT NULL,
		[OfficeID] [nchar](8) NOT NULL,
		[PositionID] [nchar](16) NOT NULL,
	 CONSTRAINT [PK_Karyawan] PRIMARY KEY CLUSTERED 
	(
		[KaryawanID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TblGenderType] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[TblGenderType]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[TblGenderType](
		[GenderTypeID] [varchar](10) NOT NULL,
		[GenderTypeDescription] [varchar](50) NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_TblGenderType] PRIMARY KEY CLUSTERED 
	(
		[GenderTypeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TblMaritalStatus] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[TblMaritalStatus]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[TblMaritalStatus](
		[MaritalStatusID] [varchar](10) NOT NULL,
		[MaritalStatusDescription] [varchar](50) NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_TblMaritalStatus] PRIMARY KEY CLUSTERED 
	(
		[MaritalStatusID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TblOffice] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[TblOffice]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[TblOffice](
		[OfficeID] [nchar](8) NOT NULL,
		[OfficeDescription] [nchar](120) NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_TblOffice] PRIMARY KEY CLUSTERED 
	(
		[OfficeID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TblPlafond] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[TblPlafond]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[TblPlafond](
		[PlafondID] [nchar](16) NOT NULL,
		[Amount] [money] NOT NULL,
		[PlafondDescription] [nchar](100) NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_TblPlafond] PRIMARY KEY CLUSTERED 
	(
		[PlafondID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TblPosition] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[TblPosition]', N'U') IS NULL
BEGIN
	CREATE TABLE [dbo].[TblPosition](
		[PositionID] [nchar](16) NOT NULL,
		[PositionDescription] [nchar](100) NOT NULL,
		[ModifiedDate] [datetime] NOT NULL,
	 CONSTRAINT [PK_TblPosition] PRIMARY KEY CLUSTERED 
	(
		[PositionID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF OBJECT_ID(N'[dbo].[DF_Anggota_isValid]', N'D') IS NULL
	ALTER TABLE [dbo].[Anggota] ADD  CONSTRAINT [DF_Anggota_isValid]  DEFAULT ((0)) FOR [isValid]
GO
IF OBJECT_ID(N'[dbo].[DF_Anggota_void]', N'D') IS NULL
	ALTER TABLE [dbo].[Anggota] ADD  CONSTRAINT [DF_Anggota_void]  DEFAULT ((0)) FOR [void]
GO
IF OBJECT_ID(N'[dbo].[DF_Anggota_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[Anggota] ADD  CONSTRAINT [DF_Anggota_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_Branch_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[Branch] ADD  CONSTRAINT [DF_Branch_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_DetailKaryawan_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[DetailKaryawan] ADD  CONSTRAINT [DF_DetailKaryawan_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_Karyawan_Isactive]', N'D') IS NULL
	ALTER TABLE [dbo].[Karyawan] ADD  CONSTRAINT [DF_Karyawan_Isactive]  DEFAULT ((1)) FOR [Isactive]
GO
IF OBJECT_ID(N'[dbo].[DF_TblGenderType_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[TblGenderType] ADD  CONSTRAINT [DF_TblGenderType_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_TblMaritalStatus_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[TblMaritalStatus] ADD  CONSTRAINT [DF_TblMaritalStatus_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_TblOffice_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[TblOffice] ADD  CONSTRAINT [DF_TblOffice_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_TblPlafond_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[TblPlafond] ADD  CONSTRAINT [DF_TblPlafond_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
IF OBJECT_ID(N'[dbo].[DF_TblPosition_ModifiedDate]', N'D') IS NULL
	ALTER TABLE [dbo].[TblPosition] ADD  CONSTRAINT [DF_TblPosition_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO


IF OBJECT_ID(N'[dbo].[FK_Anggota_Branch]', N'F') IS NULL
	ALTER TABLE [dbo].[Anggota]  WITH CHECK ADD  CONSTRAINT [FK_Anggota_Branch] FOREIGN KEY([BranchID])
	REFERENCES [dbo].[Branch] ([BranchID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Anggota] CHECK CONSTRAINT [FK_Anggota_Branch]
GO
IF OBJECT_ID(N'[dbo].[FK_Anggota_Karyawan]', N'F') IS NULL
	ALTER TABLE [dbo].[Anggota]  WITH CHECK ADD  CONSTRAINT [FK_Anggota_Karyawan] FOREIGN KEY([KaryawanID])
	REFERENCES [dbo].[Karyawan] ([KaryawanID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Anggota] CHECK CONSTRAINT [FK_Anggota_Karyawan]
GO
IF OBJECT_ID(N'[dbo].[FK_Anggota_TblPlafond]', N'F') IS NULL
	ALTER TABLE [dbo].[Anggota]  WITH CHECK ADD  CONSTRAINT [FK_Anggota_TblPlafond] FOREIGN KEY([Plafond])
	REFERENCES [dbo].[TblPlafond] ([PlafondID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Anggota] CHECK CONSTRAINT [FK_Anggota_TblPlafond]
GO
IF OBJECT_ID(N'[dbo].[FK_Departments_Departments]', N'F') IS NULL
	ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Departments] FOREIGN KEY([dept_parentid])
	REFERENCES [dbo].[Departments] ([dept_id])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Departments]
GO
IF OBJECT_ID(N'[dbo].[FK_DetailKaryawan_Karyawan]', N'F') IS NULL
	ALTER TABLE [dbo].[DetailKaryawan]  WITH CHECK ADD  CONSTRAINT [FK_DetailKaryawan_Karyawan] FOREIGN KEY([KaryawanID])
	REFERENCES [dbo].[Karyawan] ([KaryawanID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DetailKaryawan] CHECK CONSTRAINT [FK_DetailKaryawan_Karyawan]
GO
IF OBJECT_ID(N'[dbo].[FK_DetailKaryawan_TblGenderType]', N'F') IS NULL
	ALTER TABLE [dbo].[DetailKaryawan]  WITH CHECK ADD  CONSTRAINT [FK_DetailKaryawan_TblGenderType] FOREIGN KEY([Gender])
	REFERENCES [dbo].[TblGenderType] ([GenderTypeID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DetailKaryawan] CHECK CONSTRAINT [FK_DetailKaryawan_TblGenderType]
GO
IF OBJECT_ID(N'[dbo].[FK_DetailKaryawan_TblMaritalStatus]', N'F') IS NULL
	ALTER TABLE [dbo].[DetailKaryawan]  WITH CHECK ADD  CONSTRAINT [FK_DetailKaryawan_TblMaritalStatus] FOREIGN KEY([MaritalStatus])
	REFERENCES [dbo].[TblMaritalStatus] ([MaritalStatusID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[DetailKaryawan] CHECK CONSTRAINT [FK_DetailKaryawan_TblMaritalStatus]
GO
IF OBJECT_ID(N'[dbo].[FK_Karyawan_Branch]', N'F') IS NULL
	ALTER TABLE [dbo].[Karyawan]  WITH CHECK ADD  CONSTRAINT [FK_Karyawan_Branch] FOREIGN KEY([BranchID])
	REFERENCES [dbo].[Branch] ([BranchID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Karyawan] CHECK CONSTRAINT [FK_Karyawan_Branch]
GO
IF OBJECT_ID(N'[dbo].[FK_Karyawan_Departments]', N'F') IS NULL
	ALTER TABLE [dbo].[Karyawan]  WITH CHECK ADD  CONSTRAINT [FK_Karyawan_Departments] FOREIGN KEY([Dept_ID])
	REFERENCES [dbo].[Departments] ([dept_id])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Karyawan] CHECK CONSTRAINT [FK_Karyawan_Departments]
GO
IF OBJECT_ID(N'[dbo].[FK_Karyawan_TblOffice]', N'F') IS NULL
	ALTER TABLE [dbo].[Karyawan]  WITH CHECK ADD  CONSTRAINT [FK_Karyawan_TblOffice] FOREIGN KEY([OfficeID])
	REFERENCES [dbo].[TblOffice] ([OfficeID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Karyawan] CHECK CONSTRAINT [FK_Karyawan_TblOffice]
GO
IF OBJECT_ID(N'[dbo].[FK_Karyawan_TblPosition]', N'F') IS NULL
	ALTER TABLE [dbo].[Karyawan]  WITH CHECK ADD  CONSTRAINT [FK_Karyawan_TblPosition] FOREIGN KEY([PositionID])
	REFERENCES [dbo].[TblPosition] ([PositionID])
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
GO
ALTER TABLE [dbo].[Karyawan] CHECK CONSTRAINT [FK_Karyawan_TblPosition]
GO

IF OBJECT_ID(N'[dbo].[CK_Departments_dept_parentid]', N'C') IS NULL
	ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [CK_Departments_dept_parentid] CHECK  (([dept_parentid] IS NULL OR [dept_parentid]<>[dept_id]))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [CK_Departments_dept_parentid]
GO
IF OBJECT_ID(N'[dbo].[CK_TblPlafond_Amount]', N'C') IS NULL
	ALTER TABLE [dbo].[TblPlafond]  WITH CHECK ADD  CONSTRAINT [CK_TblPlafond_Amount] CHECK  (([Amount]>=(0)))
GO
ALTER TABLE [dbo].[TblPlafond] CHECK CONSTRAINT [CK_TblPlafond_Amount]
GO
