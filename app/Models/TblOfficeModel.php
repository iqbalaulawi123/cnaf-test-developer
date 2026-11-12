<?php

namespace App\Models;

class TblOfficeModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_TblOffice_GetList', ['Search' => $search, 'OfficeID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_TblOffice_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_TblOffice_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_TblOffice_Delete', ['OfficeID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'OfficeID'          => $data['OfficeID'] ?? null,
            'OfficeDescription' => $data['OfficeDescription'] ?? null,
        ];
    }
}
