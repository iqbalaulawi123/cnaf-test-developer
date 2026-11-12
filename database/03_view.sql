IF OBJECT_ID(N'dbo.vw_KaryawanLengkap', N'V') IS NOT NULL
       DROP VIEW dbo.vw_KaryawanLengkap;
GO
CREATE VIEW dbo.vw_KaryawanLengkap
AS
SELECT  k.KaryawanID,
        ISNULL(
              LTRIM(RTRIM(ISNULL(dk.FirstName, '')))
            + ISNULL(' ' + NULLIF(LTRIM(RTRIM(dk.MiddleName)), ''), '')
            + ISNULL(' ' + NULLIF(LTRIM(RTRIM(dk.LastName)),   ''), '')
        , '')                                       AS NamaLengkap,
        dk.EmailAddress                             AS Email,
        RTRIM(dk.HP)                                AS HP,
        k.BranchID,
        b.BranchFullName                            AS NamaCabang,
        RTRIM(k.Dept_ID)                            AS Dept_ID,
        RTRIM(d.dept_name)                          AS NamaDepartemen,
        RTRIM(d.dept_parentid)                      AS DeptParentID,
        RTRIM(dp.dept_name)                         AS NamaDepartemenInduk,
        RTRIM(k.OfficeID)                           AS OfficeID,
        RTRIM(o.OfficeDescription)                  AS NamaKantor,
        RTRIM(k.PositionID)                         AS PositionID,
        RTRIM(p.PositionDescription)                AS NamaPosisi,
        dk.Gender                                   AS GenderID,
        g.GenderTypeDescription                     AS Gender,
        dk.MaritalStatus                            AS MaritalStatusID,
        ms.MaritalStatusDescription                 AS StatusPernikahan,
        k.Isactive,
        CASE WHEN k.Isactive = 1 THEN 'Aktif' ELSE 'Nonaktif' END
                                                    AS Status
FROM        dbo.Karyawan         k
INNER JOIN  dbo.Branch           b  ON b.BranchID   = k.BranchID
INNER JOIN  dbo.Departments      d  ON d.dept_id    = k.Dept_ID
LEFT  JOIN  dbo.Departments      dp ON dp.dept_id   = d.dept_parentid   -- self join: induk
INNER JOIN  dbo.TblOffice        o  ON o.OfficeID   = k.OfficeID
INNER JOIN  dbo.TblPosition      p  ON p.PositionID = k.PositionID
LEFT  JOIN  dbo.DetailKaryawan   dk ON dk.KaryawanID = k.KaryawanID
LEFT  JOIN  dbo.TblGenderType    g  ON g.GenderTypeID    = dk.Gender
LEFT  JOIN  dbo.TblMaritalStatus ms ON ms.MaritalStatusID = dk.MaritalStatus;
GO



IF OBJECT_ID(N'dbo.vw_AnggotaPlafond', N'V') IS NOT NULL
    DROP VIEW dbo.vw_AnggotaPlafond;
GO

CREATE VIEW dbo.vw_AnggotaPlafond
AS
SELECT  a.AnggotaID,
        a.KaryawanID,
        ISNULL(
              LTRIM(RTRIM(ISNULL(dk.FirstName, '')))
            + ISNULL(' ' + NULLIF(LTRIM(RTRIM(dk.MiddleName)), ''), '')
            + ISNULL(' ' + NULLIF(LTRIM(RTRIM(dk.LastName)),   ''), '')
        , '')                                       AS NamaLengkap,
        a.BranchID,
        b.BranchFullName                            AS NamaCabang,
        RTRIM(a.Plafond)                            AS PlafondID,
        RTRIM(pl.PlafondDescription)                AS DeskripsiPlafond,
        pl.Amount
FROM        dbo.Anggota        a
INNER JOIN  dbo.Branch         b  ON b.BranchID   = a.BranchID
INNER JOIN  dbo.TblPlafond     pl ON pl.PlafondID = a.Plafond
LEFT  JOIN  dbo.DetailKaryawan dk ON dk.KaryawanID = a.KaryawanID
WHERE   a.isValid = 1
  AND   a.void    = 0;
GO



IF OBJECT_ID(N'dbo.vw_JumlahKaryawanPerCabang', N'V') IS NOT NULL
    DROP VIEW dbo.vw_JumlahKaryawanPerCabang;
GO

CREATE VIEW dbo.vw_JumlahKaryawanPerCabang
WITH SCHEMABINDING
AS
SELECT  b.BranchID,
        b.BranchFullName,
        COUNT_BIG(*)      AS JumlahKaryawanAktif
FROM        dbo.Karyawan k
INNER JOIN  dbo.Branch   b ON b.BranchID = k.BranchID
WHERE   k.Isactive = 1
GROUP BY b.BranchID,
         b.BranchFullName;
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'UCX_vw_JumlahKaryawanPerCabang'
                 AND object_id = OBJECT_ID(N'dbo.vw_JumlahKaryawanPerCabang'))
    CREATE UNIQUE CLUSTERED INDEX UCX_vw_JumlahKaryawanPerCabang
        ON dbo.vw_JumlahKaryawanPerCabang (BranchID);
GO