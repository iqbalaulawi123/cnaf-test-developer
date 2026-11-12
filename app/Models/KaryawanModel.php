<?php

namespace App\Models;

class KaryawanModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_Karyawan_GetList', ['Search' => $search, 'KaryawanID' => $id]);
    }

    public function getPaged(?string $search, ?string $branchId, ?int $isActive, int $page, int $size): array
    {
        $total = 0;
        $sql   = 'EXEC dbo.usp_Karyawan_GetPaged @Search = ?, @BranchID = ?, @IsActive = ?, @PageNo = ?, @PageSize = ?, @TotalRows = ?';

        $stmt = $this->execute($sql, [
            $search,
            $branchId,
            $isActive,
            $page,
            $size,
            [&$total, SQLSRV_PARAM_OUT, SQLSRV_PHPTYPE_INT, SQLSRV_SQLTYPE_INT],
        ]);

        $rows = $this->fetchAll($stmt);
        $this->finish($stmt);

        return ['rows' => $rows, 'total' => (int) $total];
    }

    public function create(array $data): array
    {
        return $this->save(true, $data);
    }

    public function update(array $data): array
    {
        return $this->save(false, $data);
    }

    public function delete(string $id): array
    {
        return $this->call('usp_Karyawan_Delete', ['KaryawanID' => $id]);
    }

    private function save(bool $isNew, array $data): array
    {
        return $this->call('usp_Karyawan_Save', [
            'IsNew'         => $isNew ? 1 : 0,
            'KaryawanID'    => $data['KaryawanID'] ?? null,
            'BranchID'      => $data['BranchID'] ?? null,
            'Isactive'      => $this->toBit($data['Isactive'] ?? null),
            'Dept_ID'       => $data['Dept_ID'] ?? null,
            'OfficeID'      => $data['OfficeID'] ?? null,
            'PositionID'    => $data['PositionID'] ?? null,
            'FirstName'     => $data['FirstName'] ?? null,
            'MiddleName'    => $data['MiddleName'] ?? null,
            'LastName'      => $data['LastName'] ?? null,
            'EmailAddress'  => $data['EmailAddress'] ?? null,
            'Phone'         => $data['Phone'] ?? null,
            'BirthDate'     => $this->toSqlDate($data['BirthDate'] ?? null),
            'BirthPlace'    => $data['BirthPlace'] ?? null,
            'MaritalStatus' => $data['MaritalStatus'] ?? null,
            'Gender'        => $data['Gender'] ?? null,
            'Other'         => $data['Other'] ?? null,
            'HP'            => $data['HP'] ?? null,
        ]);
    }
}
