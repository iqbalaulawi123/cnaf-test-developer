USE DB_TestDeveloper;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

/* =============================================================================
   CRUD 
   ============================================================================= */

/* -----------------------------------------------------------------------------
   TblMaritalStatus
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_TblMaritalStatus_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblMaritalStatus_GetList;
GO
CREATE PROCEDURE dbo.usp_TblMaritalStatus_GetList
    @Search nvarchar(100) = NULL,
    @MaritalStatusID  varchar(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  MaritalStatusID,
                MaritalStatusDescription,
                ModifiedDate
        FROM    dbo.TblMaritalStatus
        WHERE   (@MaritalStatusID IS NULL OR MaritalStatusID = @MaritalStatusID)
          AND   (@Search IS NULL
                OR MaritalStatusID LIKE N'%' + @Search + N'%'
                OR MaritalStatusDescription LIKE N'%' + @Search + N'%')
        ORDER BY MaritalStatusID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblMaritalStatus_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblMaritalStatus_Insert;
GO
CREATE PROCEDURE dbo.usp_TblMaritalStatus_Insert
    @MaritalStatusID varchar(10),
    @MaritalStatusDescription varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @MaritalStatusID IS NULL OR LTRIM(RTRIM(@MaritalStatusID)) = N''
            THROW 50005, N'ID status pernikahan wajib diisi.', 1;
        IF @MaritalStatusDescription IS NULL OR LTRIM(RTRIM(@MaritalStatusDescription)) = N''
            THROW 50005, N'Deskripsi status pernikahan wajib diisi.', 1;

        IF EXISTS (SELECT 1 FROM dbo.TblMaritalStatus WHERE MaritalStatusID = @MaritalStatusID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID status pernikahan ' + RTRIM(@MaritalStatusID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.TblMaritalStatus (MaritalStatusID, MaritalStatusDescription)
        VALUES (@MaritalStatusID, @MaritalStatusDescription);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@MaritalStatusID) AS MaritalStatusID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblMaritalStatus_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblMaritalStatus_Update;
GO
CREATE PROCEDURE dbo.usp_TblMaritalStatus_Update
    @MaritalStatusID varchar(10),
    @MaritalStatusDescription varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @MaritalStatusID IS NULL OR LTRIM(RTRIM(@MaritalStatusID)) = N''
            THROW 50005, N'ID status pernikahan wajib diisi.', 1;
        IF @MaritalStatusDescription IS NULL OR LTRIM(RTRIM(@MaritalStatusDescription)) = N''
            THROW 50005, N'Deskripsi status pernikahan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblMaritalStatus WHERE MaritalStatusID = @MaritalStatusID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID status pernikahan ' + RTRIM(@MaritalStatusID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.TblMaritalStatus
        SET     MaritalStatusDescription = @MaritalStatusDescription,
                ModifiedDate = GETDATE()
        WHERE   MaritalStatusID = @MaritalStatusID;

        SELECT RTRIM(@MaritalStatusID) AS MaritalStatusID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblMaritalStatus_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblMaritalStatus_Delete;
GO
CREATE PROCEDURE dbo.usp_TblMaritalStatus_Delete
    @MaritalStatusID varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @MaritalStatusID IS NULL OR LTRIM(RTRIM(@MaritalStatusID)) = N''
            THROW 50005, N'ID status pernikahan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblMaritalStatus WHERE MaritalStatusID = @MaritalStatusID)
        BEGIN
            SET @msg = N'ID status pernikahan ' + RTRIM(@MaritalStatusID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE MaritalStatus = @MaritalStatusID)
        BEGIN
            SET @msg = N'ID status pernikahan ' + RTRIM(@MaritalStatusID) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.TblMaritalStatus WHERE MaritalStatusID = @MaritalStatusID;

        SELECT RTRIM(@MaritalStatusID) AS MaritalStatusID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   TblGenderType
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_TblGenderType_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblGenderType_GetList;
GO
CREATE PROCEDURE dbo.usp_TblGenderType_GetList
    @Search nvarchar(100) = NULL,
    @GenderTypeID  varchar(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  GenderTypeID,
                GenderTypeDescription,
                ModifiedDate
        FROM    dbo.TblGenderType
        WHERE   (@GenderTypeID IS NULL OR GenderTypeID = @GenderTypeID)
          AND   (@Search IS NULL
                OR GenderTypeID LIKE N'%' + @Search + N'%'
                OR GenderTypeDescription LIKE N'%' + @Search + N'%')
        ORDER BY GenderTypeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblGenderType_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblGenderType_Insert;
GO
CREATE PROCEDURE dbo.usp_TblGenderType_Insert
    @GenderTypeID varchar(10),
    @GenderTypeDescription varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @GenderTypeID IS NULL OR LTRIM(RTRIM(@GenderTypeID)) = N''
            THROW 50005, N'ID gender wajib diisi.', 1;
        IF @GenderTypeDescription IS NULL OR LTRIM(RTRIM(@GenderTypeDescription)) = N''
            THROW 50005, N'Deskripsi gender wajib diisi.', 1;

        IF EXISTS (SELECT 1 FROM dbo.TblGenderType WHERE GenderTypeID = @GenderTypeID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID gender ' + RTRIM(@GenderTypeID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.TblGenderType (GenderTypeID, GenderTypeDescription)
        VALUES (@GenderTypeID, @GenderTypeDescription);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@GenderTypeID) AS GenderTypeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblGenderType_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblGenderType_Update;
GO
CREATE PROCEDURE dbo.usp_TblGenderType_Update
    @GenderTypeID varchar(10),
    @GenderTypeDescription varchar(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @GenderTypeID IS NULL OR LTRIM(RTRIM(@GenderTypeID)) = N''
            THROW 50005, N'ID gender wajib diisi.', 1;
        IF @GenderTypeDescription IS NULL OR LTRIM(RTRIM(@GenderTypeDescription)) = N''
            THROW 50005, N'Deskripsi gender wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblGenderType WHERE GenderTypeID = @GenderTypeID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID gender ' + RTRIM(@GenderTypeID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.TblGenderType
        SET     GenderTypeDescription = @GenderTypeDescription,
                ModifiedDate = GETDATE()
        WHERE   GenderTypeID = @GenderTypeID;

        SELECT RTRIM(@GenderTypeID) AS GenderTypeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblGenderType_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblGenderType_Delete;
GO
CREATE PROCEDURE dbo.usp_TblGenderType_Delete
    @GenderTypeID varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @GenderTypeID IS NULL OR LTRIM(RTRIM(@GenderTypeID)) = N''
            THROW 50005, N'ID gender wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblGenderType WHERE GenderTypeID = @GenderTypeID)
        BEGIN
            SET @msg = N'ID gender ' + RTRIM(@GenderTypeID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE Gender = @GenderTypeID)
        BEGIN
            SET @msg = N'ID gender ' + RTRIM(@GenderTypeID) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.TblGenderType WHERE GenderTypeID = @GenderTypeID;

        SELECT RTRIM(@GenderTypeID) AS GenderTypeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   TblPosition
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_TblPosition_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPosition_GetList;
GO
CREATE PROCEDURE dbo.usp_TblPosition_GetList
    @Search nvarchar(100) = NULL,   -- cari di ID / deskripsi (opsional)
    @PositionID  nvarchar(16) = NULL     -- isi untuk mengambil satu data (detail)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  RTRIM(PositionID) AS PositionID,
                RTRIM(PositionDescription) AS PositionDescription,
                ModifiedDate
        FROM    dbo.TblPosition
        WHERE   (@PositionID IS NULL OR PositionID = @PositionID)
          AND   (@Search IS NULL
                OR PositionID LIKE N'%' + @Search + N'%'
                OR PositionDescription LIKE N'%' + @Search + N'%')
        ORDER BY PositionID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPosition_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPosition_Insert;
GO
CREATE PROCEDURE dbo.usp_TblPosition_Insert
    @PositionID nvarchar(16),
    @PositionDescription nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PositionID IS NULL OR LTRIM(RTRIM(@PositionID)) = N''
            THROW 50005, N'ID posisi wajib diisi.', 1;
        IF @PositionDescription IS NULL OR LTRIM(RTRIM(@PositionDescription)) = N''
            THROW 50005, N'Deskripsi posisi wajib diisi.', 1;

        IF EXISTS (SELECT 1 FROM dbo.TblPosition WHERE PositionID = @PositionID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID posisi ' + RTRIM(@PositionID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.TblPosition (PositionID, PositionDescription)
        VALUES (@PositionID, @PositionDescription);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@PositionID) AS PositionID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPosition_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPosition_Update;
GO
CREATE PROCEDURE dbo.usp_TblPosition_Update
    @PositionID nvarchar(16),
    @PositionDescription nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PositionID IS NULL OR LTRIM(RTRIM(@PositionID)) = N''
            THROW 50005, N'ID posisi wajib diisi.', 1;
        IF @PositionDescription IS NULL OR LTRIM(RTRIM(@PositionDescription)) = N''
            THROW 50005, N'Deskripsi posisi wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblPosition WHERE PositionID = @PositionID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID posisi ' + RTRIM(@PositionID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.TblPosition
        SET     PositionDescription = @PositionDescription,
                ModifiedDate = GETDATE()
        WHERE   PositionID = @PositionID;

        SELECT RTRIM(@PositionID) AS PositionID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPosition_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPosition_Delete;
GO
CREATE PROCEDURE dbo.usp_TblPosition_Delete
    @PositionID nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @PositionID IS NULL OR LTRIM(RTRIM(@PositionID)) = N''
            THROW 50005, N'ID posisi wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblPosition WHERE PositionID = @PositionID)
        BEGIN
            SET @msg = N'ID posisi ' + RTRIM(@PositionID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Karyawan WHERE PositionID = @PositionID)
        BEGIN
            SET @msg = N'ID posisi ' + RTRIM(@PositionID) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.TblPosition WHERE PositionID = @PositionID;

        SELECT RTRIM(@PositionID) AS PositionID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   TblOffice
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_TblOffice_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblOffice_GetList;
GO
CREATE PROCEDURE dbo.usp_TblOffice_GetList
    @Search nvarchar(100) = NULL,   -- cari di ID / deskripsi (opsional)
    @OfficeID  nvarchar(8) = NULL     -- isi untuk mengambil satu data (detail)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  RTRIM(OfficeID) AS OfficeID,
                RTRIM(OfficeDescription) AS OfficeDescription,
                ModifiedDate
        FROM    dbo.TblOffice
        WHERE   (@OfficeID IS NULL OR OfficeID = @OfficeID)
          AND   (@Search IS NULL
                OR OfficeID LIKE N'%' + @Search + N'%'
                OR OfficeDescription LIKE N'%' + @Search + N'%')
        ORDER BY OfficeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblOffice_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblOffice_Insert;
GO
CREATE PROCEDURE dbo.usp_TblOffice_Insert
    @OfficeID nvarchar(8),
    @OfficeDescription nvarchar(120)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @OfficeID IS NULL OR LTRIM(RTRIM(@OfficeID)) = N''
            THROW 50005, N'ID kantor wajib diisi.', 1;
        IF @OfficeDescription IS NULL OR LTRIM(RTRIM(@OfficeDescription)) = N''
            THROW 50005, N'Deskripsi kantor wajib diisi.', 1;

        IF EXISTS (SELECT 1 FROM dbo.TblOffice WHERE OfficeID = @OfficeID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID kantor ' + RTRIM(@OfficeID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.TblOffice (OfficeID, OfficeDescription)
        VALUES (@OfficeID, @OfficeDescription);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@OfficeID) AS OfficeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblOffice_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblOffice_Update;
GO
CREATE PROCEDURE dbo.usp_TblOffice_Update
    @OfficeID nvarchar(8),
    @OfficeDescription nvarchar(120)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @OfficeID IS NULL OR LTRIM(RTRIM(@OfficeID)) = N''
            THROW 50005, N'ID kantor wajib diisi.', 1;
        IF @OfficeDescription IS NULL OR LTRIM(RTRIM(@OfficeDescription)) = N''
            THROW 50005, N'Deskripsi kantor wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblOffice WHERE OfficeID = @OfficeID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID kantor ' + RTRIM(@OfficeID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.TblOffice
        SET     OfficeDescription = @OfficeDescription,
                ModifiedDate = GETDATE()
        WHERE   OfficeID = @OfficeID;

        SELECT RTRIM(@OfficeID) AS OfficeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblOffice_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblOffice_Delete;
GO
CREATE PROCEDURE dbo.usp_TblOffice_Delete
    @OfficeID nvarchar(8)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @OfficeID IS NULL OR LTRIM(RTRIM(@OfficeID)) = N''
            THROW 50005, N'ID kantor wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblOffice WHERE OfficeID = @OfficeID)
        BEGIN
            SET @msg = N'ID kantor ' + RTRIM(@OfficeID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Karyawan WHERE OfficeID = @OfficeID)
        BEGIN
            SET @msg = N'ID kantor ' + RTRIM(@OfficeID) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.TblOffice WHERE OfficeID = @OfficeID;

        SELECT RTRIM(@OfficeID) AS OfficeID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   TblPlafond
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_TblPlafond_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPlafond_GetList;
GO
CREATE PROCEDURE dbo.usp_TblPlafond_GetList
    @Search nvarchar(100) = NULL,   -- cari di ID / deskripsi (opsional)
    @PlafondID  nvarchar(16) = NULL     -- isi untuk mengambil satu data (detail)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  RTRIM(PlafondID) AS PlafondID,
                Amount,
                RTRIM(PlafondDescription) AS PlafondDescription,
                ModifiedDate
        FROM    dbo.TblPlafond
        WHERE   (@PlafondID IS NULL OR PlafondID = @PlafondID)
          AND   (@Search IS NULL
                OR PlafondID LIKE N'%' + @Search + N'%'
                OR PlafondDescription LIKE N'%' + @Search + N'%')
        ORDER BY PlafondID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPlafond_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPlafond_Insert;
GO
CREATE PROCEDURE dbo.usp_TblPlafond_Insert
    @PlafondID nvarchar(16),
    @Amount money,
    @PlafondDescription nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PlafondID IS NULL OR LTRIM(RTRIM(@PlafondID)) = N''
            THROW 50005, N'ID plafond wajib diisi.', 1;
        IF @Amount IS NULL
            THROW 50005, N'Amount wajib diisi.', 1;
        IF @PlafondDescription IS NULL OR LTRIM(RTRIM(@PlafondDescription)) = N''
            THROW 50005, N'Deskripsi plafond wajib diisi.', 1;
        IF @Amount < 0
            THROW 50005, N'Amount tidak boleh negatif.', 1;

        IF EXISTS (SELECT 1 FROM dbo.TblPlafond WHERE PlafondID = @PlafondID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID plafond ' + RTRIM(@PlafondID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.TblPlafond (PlafondID, Amount, PlafondDescription)
        VALUES (@PlafondID, @Amount, @PlafondDescription);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@PlafondID) AS PlafondID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPlafond_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPlafond_Update;
GO
CREATE PROCEDURE dbo.usp_TblPlafond_Update
    @PlafondID nvarchar(16),
    @Amount money,
    @PlafondDescription nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @PlafondID IS NULL OR LTRIM(RTRIM(@PlafondID)) = N''
            THROW 50005, N'ID plafond wajib diisi.', 1;
        IF @Amount IS NULL
            THROW 50005, N'Amount wajib diisi.', 1;
        IF @PlafondDescription IS NULL OR LTRIM(RTRIM(@PlafondDescription)) = N''
            THROW 50005, N'Deskripsi plafond wajib diisi.', 1;
        IF @Amount < 0
            THROW 50005, N'Amount tidak boleh negatif.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblPlafond WHERE PlafondID = @PlafondID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID plafond ' + RTRIM(@PlafondID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.TblPlafond
        SET     Amount = @Amount,
                PlafondDescription = @PlafondDescription,
                ModifiedDate = GETDATE()
        WHERE   PlafondID = @PlafondID;

        SELECT RTRIM(@PlafondID) AS PlafondID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_TblPlafond_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_TblPlafond_Delete;
GO
CREATE PROCEDURE dbo.usp_TblPlafond_Delete
    @PlafondID nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @PlafondID IS NULL OR LTRIM(RTRIM(@PlafondID)) = N''
            THROW 50005, N'ID plafond wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.TblPlafond WHERE PlafondID = @PlafondID)
        BEGIN
            SET @msg = N'ID plafond ' + RTRIM(@PlafondID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Anggota WHERE Plafond = @PlafondID)
        BEGIN
            SET @msg = N'ID plafond ' + RTRIM(@PlafondID) + N' tidak bisa dihapus karena masih dipakai data anggota.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.TblPlafond WHERE PlafondID = @PlafondID;

        SELECT RTRIM(@PlafondID) AS PlafondID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   Branch
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Branch_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Branch_GetList;
GO
CREATE PROCEDURE dbo.usp_Branch_GetList
    @Search nvarchar(100) = NULL,   -- cari di ID / deskripsi (opsional)
    @BranchID  varchar(10) = NULL     -- isi untuk mengambil satu data (detail)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  BranchID,
                BranchFullName,
                BranchAddress,
                ModifiedDate
        FROM    dbo.Branch
        WHERE   (@BranchID IS NULL OR BranchID = @BranchID)
          AND   (@Search IS NULL
                OR BranchID LIKE N'%' + @Search + N'%'
                OR BranchFullName LIKE N'%' + @Search + N'%'
                OR BranchAddress LIKE N'%' + @Search + N'%')
        ORDER BY BranchID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Branch_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Branch_Insert;
GO
CREATE PROCEDURE dbo.usp_Branch_Insert
    @BranchID varchar(10),
    @BranchFullName varchar(100),
    @BranchAddress varchar(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @BranchID IS NULL OR LTRIM(RTRIM(@BranchID)) = N''
            THROW 50005, N'ID cabang wajib diisi.', 1;
        IF @BranchFullName IS NULL OR LTRIM(RTRIM(@BranchFullName)) = N''
            THROW 50005, N'Nama cabang wajib diisi.', 1;

        IF EXISTS (SELECT 1 FROM dbo.Branch WHERE BranchID = @BranchID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID cabang ' + RTRIM(@BranchID) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.Branch (BranchID, BranchFullName, BranchAddress)
        VALUES (@BranchID, @BranchFullName, @BranchAddress);     -- ModifiedDate terisi otomatis oleh DEFAULT GETDATE()

        SELECT RTRIM(@BranchID) AS BranchID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Branch_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Branch_Update;
GO
CREATE PROCEDURE dbo.usp_Branch_Update
    @BranchID varchar(10),
    @BranchFullName varchar(100),
    @BranchAddress varchar(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @BranchID IS NULL OR LTRIM(RTRIM(@BranchID)) = N''
            THROW 50005, N'ID cabang wajib diisi.', 1;
        IF @BranchFullName IS NULL OR LTRIM(RTRIM(@BranchFullName)) = N''
            THROW 50005, N'Nama cabang wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Branch WHERE BranchID = @BranchID)
        BEGIN
            DECLARE @msg nvarchar(2048) = N'ID cabang ' + RTRIM(@BranchID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        UPDATE  dbo.Branch
        SET     BranchFullName = @BranchFullName,
                BranchAddress = @BranchAddress,
                ModifiedDate = GETDATE()
        WHERE   BranchID = @BranchID;

        SELECT RTRIM(@BranchID) AS BranchID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Branch_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Branch_Delete;
GO
CREATE PROCEDURE dbo.usp_Branch_Delete
    @BranchID varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @BranchID IS NULL OR LTRIM(RTRIM(@BranchID)) = N''
            THROW 50005, N'ID cabang wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Branch WHERE BranchID = @BranchID)
        BEGIN
            SET @msg = N'ID cabang ' + RTRIM(@BranchID) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Karyawan WHERE BranchID = @BranchID)
        BEGIN
            SET @msg = N'ID cabang ' + RTRIM(@BranchID) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Anggota WHERE BranchID = @BranchID)
        BEGIN
            SET @msg = N'ID cabang ' + RTRIM(@BranchID) + N' tidak bisa dihapus karena masih dipakai data anggota.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.Branch WHERE BranchID = @BranchID;

        SELECT RTRIM(@BranchID) AS BranchID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   Departments
   - dept_parentid opsional (NULL = root); bila diisi, induk harus ada.
   - Update menolak perubahan induk yang membentuk siklus (departemen
     dipindah ke bawah dirinya sendiri / turunannya). Pengecekan dilakukan
     dengan menelusuri induk ke atas memakai WHILE (tanpa CTE).
   - Delete ditolak bila masih punya sub-departemen atau dipakai Karyawan.
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Departments_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Departments_GetList;
GO
CREATE PROCEDURE dbo.usp_Departments_GetList
    @Search  nvarchar(100) = NULL,
    @dept_id nvarchar(16)  = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  RTRIM(d.dept_id)        AS dept_id,
                RTRIM(d.dept_parentid)  AS dept_parentid,
                RTRIM(d.dept_name)      AS dept_name,
                RTRIM(p.dept_name)      AS dept_parentname
        FROM        dbo.Departments d
        LEFT JOIN   dbo.Departments p ON p.dept_id = d.dept_parentid
        WHERE   (@dept_id IS NULL OR d.dept_id = @dept_id)
          AND   (@Search IS NULL
                OR d.dept_id   LIKE N'%' + @Search + N'%'
                OR d.dept_name LIKE N'%' + @Search + N'%')
        ORDER BY d.dept_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Departments_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Departments_Insert;
GO
CREATE PROCEDURE dbo.usp_Departments_Insert
    @dept_id       nvarchar(16),
    @dept_parentid nvarchar(16) = NULL,
    @dept_name     nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        SET @dept_parentid = NULLIF(LTRIM(RTRIM(@dept_parentid)), N'');

        IF @dept_id IS NULL OR LTRIM(RTRIM(@dept_id)) = N''
            THROW 50005, N'ID departemen wajib diisi.', 1;
        IF @dept_name IS NULL OR LTRIM(RTRIM(@dept_name)) = N''
            THROW 50005, N'Nama departemen wajib diisi.', 1;
        IF @dept_parentid = @dept_id
            THROW 50005, N'Departemen tidak boleh menjadi induk dirinya sendiri.', 1;

        IF EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @dept_id)
        BEGIN
            SET @msg = N'ID departemen ' + RTRIM(@dept_id) + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        IF @dept_parentid IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @dept_parentid)
        BEGIN
            SET @msg = N'Departemen induk ' + @dept_parentid + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END

        INSERT INTO dbo.Departments (dept_id, dept_parentid, dept_name)
        VALUES (@dept_id, @dept_parentid, @dept_name);

        SELECT RTRIM(@dept_id) AS dept_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Departments_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Departments_Update;
GO
CREATE PROCEDURE dbo.usp_Departments_Update
    @dept_id       nvarchar(16),
    @dept_parentid nvarchar(16) = NULL,
    @dept_name     nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        DECLARE @cursor nvarchar(16);
        DECLARE @guard int = 0;
        SET @dept_parentid = NULLIF(LTRIM(RTRIM(@dept_parentid)), N'');

        IF @dept_id IS NULL OR LTRIM(RTRIM(@dept_id)) = N''
            THROW 50005, N'ID departemen wajib diisi.', 1;
        IF @dept_name IS NULL OR LTRIM(RTRIM(@dept_name)) = N''
            THROW 50005, N'Nama departemen wajib diisi.', 1;
        IF @dept_parentid = @dept_id
            THROW 50005, N'Departemen tidak boleh menjadi induk dirinya sendiri.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @dept_id)
        BEGIN
            SET @msg = N'ID departemen ' + RTRIM(@dept_id) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF @dept_parentid IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @dept_parentid)
            BEGIN
                SET @msg = N'Departemen induk ' + @dept_parentid + N' tidak ditemukan.';
                THROW 50006, @msg, 1;
            END

            /* telusuri induk ke atas: bila bertemu @dept_id, berarti induk baru
               adalah turunan departemen ini -> siklus */
            SET @cursor = @dept_parentid;
            WHILE @cursor IS NOT NULL AND @guard < 100
            BEGIN
                IF @cursor = @dept_id
                    THROW 50005, N'Induk tidak valid: departemen tidak boleh dipindah ke bawah turunannya sendiri.', 1;

                SELECT @cursor = RTRIM(dept_parentid)
                FROM   dbo.Departments
                WHERE  dept_id = @cursor;

                SET @guard = @guard + 1;
            END
        END

        UPDATE  dbo.Departments
        SET     dept_parentid = @dept_parentid,
                dept_name     = @dept_name
        WHERE   dept_id = @dept_id;

        SELECT RTRIM(@dept_id) AS dept_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Departments_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Departments_Delete;
GO
CREATE PROCEDURE dbo.usp_Departments_Delete
    @dept_id nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @dept_id IS NULL OR LTRIM(RTRIM(@dept_id)) = N''
            THROW 50005, N'ID departemen wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @dept_id)
        BEGIN
            SET @msg = N'ID departemen ' + RTRIM(@dept_id) + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_parentid = @dept_id)
        BEGIN
            SET @msg = N'ID departemen ' + RTRIM(@dept_id) + N' tidak bisa dihapus karena masih punya sub-departemen.';
            THROW 50004, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Karyawan WHERE Dept_ID = @dept_id)
        BEGIN
            SET @msg = N'ID departemen ' + RTRIM(@dept_id) + N' tidak bisa dihapus karena masih dipakai data karyawan.';
            THROW 50004, @msg, 1;
        END

        DELETE FROM dbo.Departments WHERE dept_id = @dept_id;

        SELECT RTRIM(@dept_id) AS dept_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   Karyawan
   Prosedur bantu usp_Karyawan_ValidateRef dipakai bersama oleh Insert,
   Update, dan Save supaya aturan validasi tidak ditulis berulang.
   usp_Karyawan_Delete ada di bagian B (prosedur khusus).
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Karyawan_ValidateRef', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_ValidateRef;
GO
CREATE PROCEDURE dbo.usp_Karyawan_ValidateRef
    @KaryawanID varchar(10),
    @BranchID   varchar(10),
    @Dept_ID    nvarchar(16),
    @OfficeID   nvarchar(8),
    @PositionID nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'ID karyawan wajib diisi.', 1;
        IF @BranchID IS NULL OR LTRIM(RTRIM(@BranchID)) = ''
            THROW 50005, N'Cabang wajib diisi.', 1;
        IF @Dept_ID IS NULL OR LTRIM(RTRIM(@Dept_ID)) = N''
            THROW 50005, N'Departemen wajib diisi.', 1;
        IF @OfficeID IS NULL OR LTRIM(RTRIM(@OfficeID)) = N''
            THROW 50005, N'Kantor wajib diisi.', 1;
        IF @PositionID IS NULL OR LTRIM(RTRIM(@PositionID)) = N''
            THROW 50005, N'Posisi wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Branch WHERE BranchID = @BranchID)
        BEGIN
            SET @msg = N'Cabang ' + @BranchID + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
        IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @Dept_ID)
        BEGIN
            SET @msg = N'Departemen ' + RTRIM(@Dept_ID) + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
        IF NOT EXISTS (SELECT 1 FROM dbo.TblOffice WHERE OfficeID = @OfficeID)
        BEGIN
            SET @msg = N'Kantor ' + RTRIM(@OfficeID) + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
        IF NOT EXISTS (SELECT 1 FROM dbo.TblPosition WHERE PositionID = @PositionID)
        BEGIN
            SET @msg = N'Posisi ' + RTRIM(@PositionID) + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Karyawan_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_GetList;
GO
CREATE PROCEDURE dbo.usp_Karyawan_GetList
    @Search     nvarchar(100) = NULL,   -- cari di ID, nama, email, HP
    @KaryawanID varchar(10)   = NULL    -- isi untuk detail satu karyawan (form edit)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        /* kolom tampilan dari view + kolom mentah DetailKaryawan untuk
           mengisi form edit */
        SELECT  v.KaryawanID,
                v.BranchID,
                v.Isactive,
                v.Dept_ID,
                v.OfficeID,
                v.PositionID,
                dk.FirstName,
                dk.MiddleName,
                dk.LastName,
                dk.EmailAddress,
                dk.Phone,
                dk.BirthDate,
                RTRIM(dk.BirthPlace) AS BirthPlace,
                dk.MaritalStatus,
                dk.Gender,
                RTRIM(dk.Other)      AS Other,
                RTRIM(dk.HP)         AS HP,
                dk.ModifiedDate,
                v.NamaLengkap,
                v.NamaCabang,
                v.NamaDepartemen,
                v.NamaDepartemenInduk,
                v.NamaKantor,
                v.NamaPosisi,
                v.Gender             AS GenderDescription,
                v.StatusPernikahan,
                v.Status
        FROM        dbo.vw_KaryawanLengkap v
        LEFT JOIN   dbo.DetailKaryawan     dk ON dk.KaryawanID = v.KaryawanID
        WHERE   (@KaryawanID IS NULL OR v.KaryawanID = @KaryawanID)
          AND   (@Search IS NULL
                OR v.KaryawanID  LIKE N'%' + @Search + N'%'
                OR v.NamaLengkap LIKE N'%' + @Search + N'%'
                OR v.Email       LIKE N'%' + @Search + N'%'
                OR v.HP          LIKE N'%' + @Search + N'%')
        ORDER BY v.KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Karyawan_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_Insert;
GO
CREATE PROCEDURE dbo.usp_Karyawan_Insert
    @KaryawanID varchar(10),
    @BranchID   varchar(10),
    @Isactive   bit = 1,
    @Dept_ID    nvarchar(16),
    @OfficeID   nvarchar(8),
    @PositionID nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        EXEC dbo.usp_Karyawan_ValidateRef @KaryawanID, @BranchID, @Dept_ID, @OfficeID, @PositionID;

        IF EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'ID karyawan ' + @KaryawanID + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.Karyawan (KaryawanID, BranchID, Isactive, Dept_ID, OfficeID, PositionID)
        VALUES (@KaryawanID, @BranchID, ISNULL(@Isactive, 1), @Dept_ID, @OfficeID, @PositionID);

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Karyawan_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_Update;
GO
CREATE PROCEDURE dbo.usp_Karyawan_Update
    @KaryawanID varchar(10),
    @BranchID   varchar(10),
    @Isactive   bit,
    @Dept_ID    nvarchar(16),
    @OfficeID   nvarchar(8),
    @PositionID nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        EXEC dbo.usp_Karyawan_ValidateRef @KaryawanID, @BranchID, @Dept_ID, @OfficeID, @PositionID;

        IF NOT EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'ID karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        /* Karyawan tidak punya kolom ModifiedDate (sesuai soal) */
        UPDATE  dbo.Karyawan
        SET     BranchID   = @BranchID,
                Isactive   = ISNULL(@Isactive, Isactive),
                Dept_ID    = @Dept_ID,
                OfficeID   = @OfficeID,
                PositionID = @PositionID
        WHERE   KaryawanID = @KaryawanID;

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   DetailKaryawan (1:1 dengan Karyawan)
   usp_DetailKaryawan_Validate dipakai bersama oleh Insert, Update, dan
   usp_Karyawan_Save.
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_DetailKaryawan_Validate', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_DetailKaryawan_Validate;
GO
CREATE PROCEDURE dbo.usp_DetailKaryawan_Validate
    @KaryawanID    varchar(10),
    @FirstName     varchar(50),
    @EmailAddress  varchar(50),
    @MaritalStatus varchar(10),
    @Gender        varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @FirstName IS NULL OR LTRIM(RTRIM(@FirstName)) = ''
            THROW 50005, N'Nama depan wajib diisi.', 1;

        /* format email sederhana: ada teks@teks.teks dan tanpa spasi */
        IF @EmailAddress IS NOT NULL
           AND (@EmailAddress NOT LIKE '%_@_%._%' OR CHARINDEX(' ', @EmailAddress) > 0)
            THROW 50005, N'Format email tidak valid.', 1;

        /* email unik (dicek di sini agar pesannya jelas; unique filtered index
           UX_DetailKaryawan_EmailAddress tetap menjadi pengaman terakhir) */
        IF @EmailAddress IS NOT NULL
           AND EXISTS (SELECT 1 FROM dbo.DetailKaryawan
                       WHERE EmailAddress = @EmailAddress
                         AND KaryawanID  <> @KaryawanID)
        BEGIN
            SET @msg = N'Email ' + @EmailAddress + N' sudah dipakai karyawan lain.';
            THROW 50007, @msg, 1;
        END

        IF @MaritalStatus IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM dbo.TblMaritalStatus WHERE MaritalStatusID = @MaritalStatus)
        BEGIN
            SET @msg = N'Status pernikahan ' + @MaritalStatus + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END

        IF @Gender IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM dbo.TblGenderType WHERE GenderTypeID = @Gender)
        BEGIN
            SET @msg = N'Gender ' + @Gender + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_DetailKaryawan_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_DetailKaryawan_GetList;
GO
CREATE PROCEDURE dbo.usp_DetailKaryawan_GetList
    @Search     nvarchar(100) = NULL,
    @KaryawanID varchar(10)   = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  KaryawanID,
                FirstName,
                MiddleName,
                LastName,
                EmailAddress,
                Phone,
                BirthDate,
                RTRIM(BirthPlace) AS BirthPlace,
                MaritalStatus,
                Gender,
                RTRIM(Other)      AS Other,
                RTRIM(HP)         AS HP,
                ModifiedDate
        FROM    dbo.DetailKaryawan
        WHERE   (@KaryawanID IS NULL OR KaryawanID = @KaryawanID)
          AND   (@Search IS NULL
                OR KaryawanID   LIKE N'%' + @Search + N'%'
                OR FirstName    LIKE N'%' + @Search + N'%'
                OR MiddleName   LIKE N'%' + @Search + N'%'
                OR LastName     LIKE N'%' + @Search + N'%'
                OR EmailAddress LIKE N'%' + @Search + N'%')
        ORDER BY KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_DetailKaryawan_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_DetailKaryawan_Insert;
GO
CREATE PROCEDURE dbo.usp_DetailKaryawan_Insert
    @KaryawanID    varchar(10),
    @FirstName     varchar(50),
    @MiddleName    varchar(50)   = NULL,
    @LastName      varchar(50)   = NULL,
    @EmailAddress  varchar(50)   = NULL,
    @Phone         varchar(50)   = NULL,
    @BirthDate     datetime      = NULL,
    @BirthPlace    nvarchar(200) = NULL,
    @MaritalStatus varchar(10)   = NULL,
    @Gender        varchar(10)   = NULL,
    @Other         nvarchar(60)  = NULL,
    @HP            nvarchar(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        SET @EmailAddress  = NULLIF(LTRIM(RTRIM(@EmailAddress)), '');
        SET @MaritalStatus = NULLIF(LTRIM(RTRIM(@MaritalStatus)), '');
        SET @Gender        = NULLIF(LTRIM(RTRIM(@Gender)), '');

        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'ID karyawan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'Karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'Detail karyawan ' + @KaryawanID + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        EXEC dbo.usp_DetailKaryawan_Validate @KaryawanID, @FirstName, @EmailAddress, @MaritalStatus, @Gender;

        INSERT INTO dbo.DetailKaryawan
               (KaryawanID, FirstName, MiddleName, LastName, EmailAddress, Phone,
                BirthDate, BirthPlace, MaritalStatus, Gender, Other, HP)
        VALUES (@KaryawanID, @FirstName, @MiddleName, @LastName, @EmailAddress, @Phone,
                @BirthDate, @BirthPlace, @MaritalStatus, @Gender, @Other, @HP);

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_DetailKaryawan_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_DetailKaryawan_Update;
GO
CREATE PROCEDURE dbo.usp_DetailKaryawan_Update
    @KaryawanID    varchar(10),
    @FirstName     varchar(50),
    @MiddleName    varchar(50)   = NULL,
    @LastName      varchar(50)   = NULL,
    @EmailAddress  varchar(50)   = NULL,
    @Phone         varchar(50)   = NULL,
    @BirthDate     datetime      = NULL,
    @BirthPlace    nvarchar(200) = NULL,
    @MaritalStatus varchar(10)   = NULL,
    @Gender        varchar(10)   = NULL,
    @Other         nvarchar(60)  = NULL,
    @HP            nvarchar(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        SET @EmailAddress  = NULLIF(LTRIM(RTRIM(@EmailAddress)), '');
        SET @MaritalStatus = NULLIF(LTRIM(RTRIM(@MaritalStatus)), '');
        SET @Gender        = NULLIF(LTRIM(RTRIM(@Gender)), '');

        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'ID karyawan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'Detail karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        EXEC dbo.usp_DetailKaryawan_Validate @KaryawanID, @FirstName, @EmailAddress, @MaritalStatus, @Gender;

        UPDATE  dbo.DetailKaryawan
        SET     FirstName     = @FirstName,
                MiddleName    = @MiddleName,
                LastName      = @LastName,
                EmailAddress  = @EmailAddress,
                Phone         = @Phone,
                BirthDate     = @BirthDate,
                BirthPlace    = @BirthPlace,
                MaritalStatus = @MaritalStatus,
                Gender        = @Gender,
                Other         = @Other,
                HP            = @HP,
                ModifiedDate  = GETDATE()
        WHERE   KaryawanID = @KaryawanID;

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_DetailKaryawan_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_DetailKaryawan_Delete;
GO
CREATE PROCEDURE dbo.usp_DetailKaryawan_Delete
    @KaryawanID varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'ID karyawan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'Detail karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        /* tidak ada tabel lain yang mereferensikan DetailKaryawan */
        DELETE FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID;

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   Anggota
   - Insert: void selalu 0; isValid default 0 bila tidak diisi.
   - Update ditolak untuk anggota yang sudah void.
   - usp_Anggota_Delete (soft delete) ada di bagian B.
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Anggota_ValidateRef', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Anggota_ValidateRef;
GO
CREATE PROCEDURE dbo.usp_Anggota_ValidateRef
    @AnggotaID  varchar(20),
    @BranchID   varchar(10),
    @KaryawanID varchar(10),
    @Plafond    nvarchar(16)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @AnggotaID IS NULL OR LTRIM(RTRIM(@AnggotaID)) = ''
            THROW 50005, N'ID anggota wajib diisi.', 1;
        IF @BranchID IS NULL OR LTRIM(RTRIM(@BranchID)) = ''
            THROW 50005, N'Cabang wajib diisi.', 1;
        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'Karyawan wajib diisi.', 1;
        IF @Plafond IS NULL OR LTRIM(RTRIM(@Plafond)) = N''
            THROW 50005, N'Plafond wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Branch WHERE BranchID = @BranchID)
        BEGIN
            SET @msg = N'Cabang ' + @BranchID + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
        IF NOT EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'Karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
        IF NOT EXISTS (SELECT 1 FROM dbo.TblPlafond WHERE PlafondID = @Plafond)
        BEGIN
            SET @msg = N'Plafond ' + RTRIM(@Plafond) + N' tidak ditemukan.';
            THROW 50006, @msg, 1;
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Anggota_GetList', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Anggota_GetList;
GO
CREATE PROCEDURE dbo.usp_Anggota_GetList
    @Search      nvarchar(100) = NULL,
    @AnggotaID   varchar(20)   = NULL,
    @KaryawanID  varchar(10)   = NULL,
    @IncludeVoid bit           = 0      -- 1 = tampilkan juga yang sudah di-void
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        SELECT  a.AnggotaID,
                a.BranchID,
                a.KaryawanID,
                RTRIM(a.Plafond)             AS Plafond,
                a.isValid,
                a.void,
                a.ModifiedDate,
                b.BranchFullName             AS NamaCabang,
                v.NamaLengkap,
                RTRIM(pl.PlafondDescription) AS DeskripsiPlafond,
                pl.Amount
        FROM        dbo.Anggota            a
        INNER JOIN  dbo.Branch             b  ON b.BranchID    = a.BranchID
        INNER JOIN  dbo.TblPlafond         pl ON pl.PlafondID  = a.Plafond
        LEFT  JOIN  dbo.vw_KaryawanLengkap v  ON v.KaryawanID  = a.KaryawanID
        WHERE   (@AnggotaID  IS NULL OR a.AnggotaID  = @AnggotaID)
          AND   (@KaryawanID IS NULL OR a.KaryawanID = @KaryawanID)
          AND   (ISNULL(@IncludeVoid, 0) = 1 OR a.void = 0)
          AND   (@Search IS NULL
                OR a.AnggotaID   LIKE N'%' + @Search + N'%'
                OR a.KaryawanID  LIKE N'%' + @Search + N'%'
                OR v.NamaLengkap LIKE N'%' + @Search + N'%')
        ORDER BY a.AnggotaID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Anggota_Insert', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Anggota_Insert;
GO
CREATE PROCEDURE dbo.usp_Anggota_Insert
    @AnggotaID  varchar(20),
    @BranchID   varchar(10),
    @KaryawanID varchar(10),
    @Plafond    nvarchar(16),
    @isValid    bit = 0
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        EXEC dbo.usp_Anggota_ValidateRef @AnggotaID, @BranchID, @KaryawanID, @Plafond;

        IF EXISTS (SELECT 1 FROM dbo.Anggota WHERE AnggotaID = @AnggotaID)
        BEGIN
            SET @msg = N'ID anggota ' + @AnggotaID + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        INSERT INTO dbo.Anggota (AnggotaID, BranchID, KaryawanID, Plafond, isValid, void)
        VALUES (@AnggotaID, @BranchID, @KaryawanID, @Plafond, ISNULL(@isValid, 0), 0);

        SELECT @AnggotaID AS AnggotaID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

IF OBJECT_ID(N'dbo.usp_Anggota_Update', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Anggota_Update;
GO
CREATE PROCEDURE dbo.usp_Anggota_Update
    @AnggotaID  varchar(20),
    @BranchID   varchar(10),
    @KaryawanID varchar(10),
    @Plafond    nvarchar(16),
    @isValid    bit
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        EXEC dbo.usp_Anggota_ValidateRef @AnggotaID, @BranchID, @KaryawanID, @Plafond;

        IF NOT EXISTS (SELECT 1 FROM dbo.Anggota WHERE AnggotaID = @AnggotaID)
        BEGIN
            SET @msg = N'ID anggota ' + @AnggotaID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Anggota WHERE AnggotaID = @AnggotaID AND void = 1)
        BEGIN
            SET @msg = N'Anggota ' + @AnggotaID + N' sudah dibatalkan (void) dan tidak bisa diubah.';
            THROW 50005, @msg, 1;
        END

        UPDATE  dbo.Anggota
        SET     BranchID     = @BranchID,
                KaryawanID   = @KaryawanID,
                Plafond      = @Plafond,
                isValid      = ISNULL(@isValid, isValid),
                ModifiedDate = GETDATE()
        WHERE   AnggotaID = @AnggotaID;

        SELECT @AnggotaID AS AnggotaID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* =============================================================================
   B. PROSEDUR KHUSUS
   ============================================================================= */

/* -----------------------------------------------------------------------------
   usp_Karyawan_Save
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Karyawan_Save', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_Save;
GO
CREATE PROCEDURE dbo.usp_Karyawan_Save
    @IsNew         bit,
    -- Karyawan
    @KaryawanID    varchar(10),
    @BranchID      varchar(10),
    @Isactive      bit           = 1,
    @Dept_ID       nvarchar(16),
    @OfficeID      nvarchar(8),
    @PositionID    nvarchar(16),
    -- DetailKaryawan
    @FirstName     varchar(50),
    @MiddleName    varchar(50)   = NULL,
    @LastName      varchar(50)   = NULL,
    @EmailAddress  varchar(50)   = NULL,
    @Phone         varchar(50)   = NULL,
    @BirthDate     datetime      = NULL,
    @BirthPlace    nvarchar(200) = NULL,
    @MaritalStatus varchar(10)   = NULL,
    @Gender        varchar(10)   = NULL,
    @Other         nvarchar(60)  = NULL,
    @HP            nvarchar(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        SET @EmailAddress  = NULLIF(LTRIM(RTRIM(@EmailAddress)), '');
        SET @MaritalStatus = NULLIF(LTRIM(RTRIM(@MaritalStatus)), '');
        SET @Gender        = NULLIF(LTRIM(RTRIM(@Gender)), '');

        IF @IsNew IS NULL
            THROW 50005, N'Parameter @IsNew wajib diisi (1 = tambah, 0 = ubah).', 1;

        /* ---- validasi (sebelum transaksi) ---- */
        EXEC dbo.usp_Karyawan_ValidateRef @KaryawanID, @BranchID, @Dept_ID, @OfficeID, @PositionID;
        EXEC dbo.usp_DetailKaryawan_Validate @KaryawanID, @FirstName, @EmailAddress, @MaritalStatus, @Gender;

        IF @IsNew = 1 AND EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'ID karyawan ' + @KaryawanID + N' sudah ada.';
            THROW 50002, @msg, 1;
        END

        IF @IsNew = 0 AND NOT EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'ID karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        /* ---- simpan (satu transaksi) ---- */
        BEGIN TRAN;

        IF @IsNew = 1
        BEGIN
            INSERT INTO dbo.Karyawan (KaryawanID, BranchID, Isactive, Dept_ID, OfficeID, PositionID)
            VALUES (@KaryawanID, @BranchID, ISNULL(@Isactive, 1), @Dept_ID, @OfficeID, @PositionID);

            INSERT INTO dbo.DetailKaryawan
                   (KaryawanID, FirstName, MiddleName, LastName, EmailAddress, Phone,
                    BirthDate, BirthPlace, MaritalStatus, Gender, Other, HP)
            VALUES (@KaryawanID, @FirstName, @MiddleName, @LastName, @EmailAddress, @Phone,
                    @BirthDate, @BirthPlace, @MaritalStatus, @Gender, @Other, @HP);
        END
        ELSE
        BEGIN
            UPDATE  dbo.Karyawan
            SET     BranchID   = @BranchID,
                    Isactive   = ISNULL(@Isactive, Isactive),
                    Dept_ID    = @Dept_ID,
                    OfficeID   = @OfficeID,
                    PositionID = @PositionID
            WHERE   KaryawanID = @KaryawanID;

            /* data lama bisa saja belum punya detail: update bila ada, insert bila belum */
            IF EXISTS (SELECT 1 FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID)
                UPDATE  dbo.DetailKaryawan
                SET     FirstName     = @FirstName,
                        MiddleName    = @MiddleName,
                        LastName      = @LastName,
                        EmailAddress  = @EmailAddress,
                        Phone         = @Phone,
                        BirthDate     = @BirthDate,
                        BirthPlace    = @BirthPlace,
                        MaritalStatus = @MaritalStatus,
                        Gender        = @Gender,
                        Other         = @Other,
                        HP            = @HP,
                        ModifiedDate  = GETDATE()
                WHERE   KaryawanID = @KaryawanID;
            ELSE
                INSERT INTO dbo.DetailKaryawan
                       (KaryawanID, FirstName, MiddleName, LastName, EmailAddress, Phone,
                        BirthDate, BirthPlace, MaritalStatus, Gender, Other, HP)
                VALUES (@KaryawanID, @FirstName, @MiddleName, @LastName, @EmailAddress, @Phone,
                        @BirthDate, @BirthPlace, @MaritalStatus, @Gender, @Other, @HP);
        END

        COMMIT TRAN;

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   usp_Karyawan_GetPaged
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Karyawan_GetPaged', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_GetPaged;
GO
CREATE PROCEDURE dbo.usp_Karyawan_GetPaged
    @Search    nvarchar(100) = NULL,   -- ID, nama, email, HP
    @BranchID  varchar(10)   = NULL,
    @IsActive  bit           = NULL,   -- NULL = aktif + nonaktif
    @PageNo    int           = 1,
    @PageSize  int           = 10,
    @TotalRows int           OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @TotalRows = 0;
        SET @BranchID  = NULLIF(LTRIM(RTRIM(@BranchID)), '');

        IF @PageNo IS NULL OR @PageNo < 1
            THROW 50005, N'PageNo minimal 1.', 1;
        IF @PageSize IS NULL OR @PageSize < 1 OR @PageSize > 100
            THROW 50005, N'PageSize harus antara 1 dan 100.', 1;

        SET @Search = NULLIF(LTRIM(RTRIM(@Search)), N'');

        IF OBJECT_ID(N'tempdb..#Filtered') IS NOT NULL
            DROP TABLE #Filtered;

        CREATE TABLE #Filtered
        (
            KaryawanID          varchar(10)   NOT NULL PRIMARY KEY,
            NamaLengkap         varchar(152)  NOT NULL,
            Email               varchar(50)   NULL,
            HP                  nvarchar(100) NULL,
            BranchID            varchar(10)   NOT NULL,
            NamaCabang          varchar(100)  NULL,
            Dept_ID             nvarchar(16)  NULL,
            NamaDepartemen      nvarchar(100) NULL,
            NamaDepartemenInduk nvarchar(100) NULL,
            OfficeID            nvarchar(8)   NULL,
            NamaKantor          nvarchar(120) NULL,
            PositionID          nvarchar(16)  NULL,
            NamaPosisi          nvarchar(100) NULL,
            Gender              varchar(50)   NULL,
            StatusPernikahan    varchar(50)   NULL,
            Isactive            bit           NOT NULL,
            Status              varchar(8)    NOT NULL
        );

        INSERT INTO #Filtered
               (KaryawanID, NamaLengkap, Email, HP, BranchID, NamaCabang,
                Dept_ID, NamaDepartemen, NamaDepartemenInduk, OfficeID, NamaKantor,
                PositionID, NamaPosisi, Gender, StatusPernikahan, Isactive, Status)
        SELECT  v.KaryawanID, v.NamaLengkap, v.Email, v.HP, v.BranchID, v.NamaCabang,
                v.Dept_ID, v.NamaDepartemen, v.NamaDepartemenInduk, v.OfficeID, v.NamaKantor,
                v.PositionID, v.NamaPosisi, v.Gender, v.StatusPernikahan, v.Isactive, v.Status
        FROM    dbo.vw_KaryawanLengkap v
        WHERE   (@BranchID IS NULL OR v.BranchID = @BranchID)
          AND   (@IsActive IS NULL OR v.Isactive = @IsActive)
          AND   (@Search IS NULL
                OR v.KaryawanID  LIKE N'%' + @Search + N'%'
                OR v.NamaLengkap LIKE N'%' + @Search + N'%'
                OR v.Email       LIKE N'%' + @Search + N'%'
                OR v.HP          LIKE N'%' + @Search + N'%');

        SELECT @TotalRows = COUNT(*) FROM #Filtered;

        SELECT  KaryawanID, NamaLengkap, Email, HP, BranchID, NamaCabang,
                Dept_ID, NamaDepartemen, NamaDepartemenInduk, OfficeID, NamaKantor,
                PositionID, NamaPosisi, Gender, StatusPernikahan, Isactive, Status
        FROM    #Filtered
        ORDER BY KaryawanID
        OFFSET (@PageNo - 1) * @PageSize ROWS
        FETCH NEXT @PageSize ROWS ONLY;

        DROP TABLE #Filtered;
    END TRY
    BEGIN CATCH
        IF OBJECT_ID(N'tempdb..#Filtered') IS NOT NULL
            DROP TABLE #Filtered;
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   usp_Departments_GetTree
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Departments_GetTree', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Departments_GetTree;
GO
CREATE PROCEDURE dbo.usp_Departments_GetTree
    @RootID nvarchar(16) = NULL   -- NULL = seluruh pohon; diisi = sub-pohon mulai dari departemen ini
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @Level int = 1;
        DECLARE @Added int;
        DECLARE @msg   nvarchar(2048);
        SET @RootID = NULLIF(LTRIM(RTRIM(@RootID)), N'');

        IF @RootID IS NOT NULL
           AND NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE dept_id = @RootID)
        BEGIN
            SET @msg = N'ID departemen ' + @RootID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF OBJECT_ID(N'tempdb..#Tree') IS NOT NULL
            DROP TABLE #Tree;

        CREATE TABLE #Tree
        (
            dept_id       nvarchar(16)   NOT NULL PRIMARY KEY,
            dept_parentid nvarchar(16)   NULL,
            dept_name     nvarchar(100)  NOT NULL,
            [Level]       int            NOT NULL,
            [Path]        nvarchar(4000) NOT NULL,   -- Direksi > Divisi ... > Unit ...
            SortPath      nvarchar(4000) NOT NULL    -- D00/D10/D11 (untuk urutan tampil)
        );

        /* level 1 */
        INSERT INTO #Tree (dept_id, dept_parentid, dept_name, [Level], [Path], SortPath)
        SELECT  RTRIM(d.dept_id),
                RTRIM(d.dept_parentid),
                RTRIM(d.dept_name),
                @Level,
                RTRIM(d.dept_name),
                RTRIM(d.dept_id)
        FROM    dbo.Departments d
        WHERE   (@RootID IS NULL AND d.dept_parentid IS NULL)
             OR (d.dept_id = @RootID);

        SET @Added = @@ROWCOUNT;

        /* level berikutnya, satu per satu */
        WHILE @Added > 0 AND @Level < 100
        BEGIN
            INSERT INTO #Tree (dept_id, dept_parentid, dept_name, [Level], [Path], SortPath)
            SELECT  RTRIM(c.dept_id),
                    RTRIM(c.dept_parentid),
                    RTRIM(c.dept_name),
                    @Level + 1,
                    t.[Path] + N' > ' + RTRIM(c.dept_name),
                    t.SortPath + N'/' + RTRIM(c.dept_id)
            FROM        dbo.Departments c
            INNER JOIN  #Tree t ON t.dept_id = c.dept_parentid
            WHERE   t.[Level] = @Level
              AND   NOT EXISTS (SELECT 1 FROM #Tree x WHERE x.dept_id = c.dept_id);

            SET @Added = @@ROWCOUNT;
            SET @Level = @Level + 1;
        END

        SELECT  dept_id,
                dept_parentid,
                dept_name,
                [Level],
                [Path]
        FROM    #Tree
        ORDER BY SortPath;

        DROP TABLE #Tree;
    END TRY
    BEGIN CATCH
        IF OBJECT_ID(N'tempdb..#Tree') IS NOT NULL
            DROP TABLE #Tree;
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   usp_Karyawan_Delete
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Karyawan_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Karyawan_Delete;
GO
CREATE PROCEDURE dbo.usp_Karyawan_Delete
    @KaryawanID varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        DECLARE @msg nvarchar(2048);
        DECLARE @JumlahAnggota int;

        IF @KaryawanID IS NULL OR LTRIM(RTRIM(@KaryawanID)) = ''
            THROW 50005, N'ID karyawan wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Karyawan WHERE KaryawanID = @KaryawanID)
        BEGIN
            SET @msg = N'ID karyawan ' + @KaryawanID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        SELECT @JumlahAnggota = COUNT(*) FROM dbo.Anggota WHERE KaryawanID = @KaryawanID;

        IF @JumlahAnggota > 0
        BEGIN
            SET @msg = N'Karyawan ' + @KaryawanID + N' tidak bisa dihapus karena masih memiliki '
                     + CAST(@JumlahAnggota AS nvarchar(10)) + N' data anggota.';
            THROW 50001, @msg, 1;
        END

        BEGIN TRAN;
            DELETE FROM dbo.DetailKaryawan WHERE KaryawanID = @KaryawanID;
            DELETE FROM dbo.Karyawan       WHERE KaryawanID = @KaryawanID;
        COMMIT TRAN;

        SELECT @KaryawanID AS KaryawanID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   usp_Anggota_Delete (soft delete)
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Anggota_Delete', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Anggota_Delete;
GO
CREATE PROCEDURE dbo.usp_Anggota_Delete
    @AnggotaID varchar(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @msg nvarchar(2048);

        IF @AnggotaID IS NULL OR LTRIM(RTRIM(@AnggotaID)) = ''
            THROW 50005, N'ID anggota wajib diisi.', 1;

        IF NOT EXISTS (SELECT 1 FROM dbo.Anggota WHERE AnggotaID = @AnggotaID)
        BEGIN
            SET @msg = N'ID anggota ' + @AnggotaID + N' tidak ditemukan.';
            THROW 50003, @msg, 1;
        END

        IF EXISTS (SELECT 1 FROM dbo.Anggota WHERE AnggotaID = @AnggotaID AND void = 1)
        BEGIN
            SET @msg = N'Anggota ' + @AnggotaID + N' sudah dibatalkan sebelumnya.';
            THROW 50005, @msg, 1;
        END

        UPDATE  dbo.Anggota
        SET     void         = 1,
                ModifiedDate = GETDATE()
        WHERE   AnggotaID = @AnggotaID;

        SELECT @AnggotaID AS AnggotaID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------------
   usp_Laporan_PlafondPerCabang
   ----------------------------------------------------------------------------- */
IF OBJECT_ID(N'dbo.usp_Laporan_PlafondPerCabang', N'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_Laporan_PlafondPerCabang;
GO
CREATE PROCEDURE dbo.usp_Laporan_PlafondPerCabang
    @BranchID varchar(10) = NULL   -- NULL = semua cabang
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @BranchID = NULLIF(LTRIM(RTRIM(@BranchID)), '');

        IF OBJECT_ID(N'tempdb..#Step1') IS NOT NULL DROP TABLE #Step1;
        IF OBJECT_ID(N'tempdb..#Step2') IS NOT NULL DROP TABLE #Step2;

        /* Step 1: detail anggota sah */
        CREATE TABLE #Step1
        (
            AnggotaID  varchar(20)  NOT NULL,
            BranchID   varchar(10)  NOT NULL,
            PositionID nvarchar(16) NOT NULL,
            Amount     money        NOT NULL
        );

        INSERT INTO #Step1 (AnggotaID, BranchID, PositionID, Amount)
        SELECT  a.AnggotaID,
                a.BranchID,
                RTRIM(k.PositionID),
                pl.Amount
        FROM        dbo.Anggota    a
        INNER JOIN  dbo.Karyawan   k  ON k.KaryawanID = a.KaryawanID
        INNER JOIN  dbo.TblPlafond pl ON pl.PlafondID = a.Plafond
        WHERE   a.isValid = 1
          AND   a.void    = 0
          AND   (@BranchID IS NULL OR a.BranchID = @BranchID);

        /* Step 2: agregasi per cabang dan posisi */
        CREATE TABLE #Step2
        (
            BranchID      varchar(10)  NOT NULL,
            PositionID    nvarchar(16) NOT NULL,
            JumlahAnggota int          NOT NULL,
            TotalPlafond  money        NOT NULL,
            PRIMARY KEY (BranchID, PositionID)
        );

        INSERT INTO #Step2 (BranchID, PositionID, JumlahAnggota, TotalPlafond)
        SELECT  BranchID,
                PositionID,
                COUNT(*),
                SUM(Amount)
        FROM    #Step1
        GROUP BY BranchID, PositionID;

        /* hasil akhir */
        SELECT  s.BranchID,
                b.BranchFullName                                    AS NamaCabang,
                s.PositionID,
                RTRIM(p.PositionDescription)                        AS NamaPosisi,
                s.JumlahAnggota,
                s.TotalPlafond,
                SUM(s.TotalPlafond) OVER (PARTITION BY s.BranchID)  AS TotalPlafondCabang
        FROM        #Step2         s
        INNER JOIN  dbo.Branch      b ON b.BranchID   = s.BranchID
        INNER JOIN  dbo.TblPosition p ON p.PositionID = s.PositionID
        ORDER BY s.BranchID, s.PositionID;

        DROP TABLE #Step1;
        DROP TABLE #Step2;
    END TRY
    BEGIN CATCH
        IF OBJECT_ID(N'tempdb..#Step1') IS NOT NULL DROP TABLE #Step1;
        IF OBJECT_ID(N'tempdb..#Step2') IS NOT NULL DROP TABLE #Step2;
        THROW;
    END CATCH
END
GO
