<?php

namespace App\Models;

class TblMaritalStatusModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_TblMaritalStatus_GetList', ['Search' => $search, 'MaritalStatusID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_TblMaritalStatus_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_TblMaritalStatus_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_TblMaritalStatus_Delete', ['MaritalStatusID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'MaritalStatusID'          => $data['MaritalStatusID'] ?? null,
            'MaritalStatusDescription' => $data['MaritalStatusDescription'] ?? null,
        ];
    }
}
