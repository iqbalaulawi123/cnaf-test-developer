<?php

namespace App\Models;

class TblGenderTypeModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_TblGenderType_GetList', ['Search' => $search, 'GenderTypeID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_TblGenderType_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_TblGenderType_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_TblGenderType_Delete', ['GenderTypeID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'GenderTypeID'          => $data['GenderTypeID'] ?? null,
            'GenderTypeDescription' => $data['GenderTypeDescription'] ?? null,
        ];
    }
}
