USE DB_TestDeveloper;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO


/* 
    SQL Server TIDAK otomatis membuat index untuk kolom foreign key (hanya PK dan UNIQUE yang otomatis ber-index) 
    dan juga untuk keperluan filter
    Nonclustered index pada kolom foreign key Karyawan: BranchID, Dept_ID, OfficeID, PositionID. 
*/
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Karyawan_BranchID'
                 AND object_id = OBJECT_ID(N'dbo.Karyawan'))
    CREATE NONCLUSTERED INDEX IX_Karyawan_BranchID
        ON dbo.Karyawan (BranchID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Karyawan_Dept_ID'
                 AND object_id = OBJECT_ID(N'dbo.Karyawan'))
    CREATE NONCLUSTERED INDEX IX_Karyawan_Dept_ID
        ON dbo.Karyawan (Dept_ID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Karyawan_OfficeID'
                 AND object_id = OBJECT_ID(N'dbo.Karyawan'))
    CREATE NONCLUSTERED INDEX IX_Karyawan_OfficeID
        ON dbo.Karyawan (OfficeID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Karyawan_PositionID'
                 AND object_id = OBJECT_ID(N'dbo.Karyawan'))
    CREATE NONCLUSTERED INDEX IX_Karyawan_PositionID
        ON dbo.Karyawan (PositionID);
GO

/* 
    di soal :
    jalankan satu query filter Isactive = 1 AND BranchID = '...'
    index ini buat cover soal itu (index kombinasi Branch Id dan Isactive)
*/
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Karyawan_Isactive_BranchID'
                 AND object_id = OBJECT_ID(N'dbo.Karyawan'))
    CREATE NONCLUSTERED INDEX IX_Karyawan_Isactive_BranchID
        ON dbo.Karyawan (Isactive, BranchID)
        INCLUDE (Dept_ID, PositionID);
GO

-- DetailKaryawan
-- Unique filtered index DetailKaryawan (EmailAddress) WHERE EmailAddress IS NOT NULL. 
-- supaya banyak baris NULL tetap boleh, sementara email yang terisi tetap unik
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'UX_DetailKaryawan_EmailAddress'
                 AND object_id = OBJECT_ID(N'dbo.DetailKaryawan'))
    CREATE UNIQUE NONCLUSTERED INDEX UX_DetailKaryawan_EmailAddress
        ON dbo.DetailKaryawan (EmailAddress)
        WHERE EmailAddress IS NOT NULL;
GO

-- Anggota
-- Nonclustered index Anggota (KaryawanID) dengan INCLUDE (Plafond, isValid, void). 
IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_Anggota_KaryawanID'
                 AND object_id = OBJECT_ID(N'dbo.Anggota'))
    CREATE NONCLUSTERED INDEX IX_Anggota_KaryawanID
        ON dbo.Anggota (KaryawanID)
        INCLUDE (Plafond, isValid, void);
GO
