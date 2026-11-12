<?php

namespace App\Models;

class DetailKaryawanModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_DetailKaryawan_GetList', ['Search' => $search, 'KaryawanID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_DetailKaryawan_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_DetailKaryawan_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_DetailKaryawan_Delete', ['KaryawanID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'KaryawanID'    => $data['KaryawanID'] ?? null,
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
        ];
    }
}
