<?php

namespace App\Models;

class TblPositionModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_TblPosition_GetList', ['Search' => $search, 'PositionID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_TblPosition_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_TblPosition_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_TblPosition_Delete', ['PositionID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'PositionID'          => $data['PositionID'] ?? null,
            'PositionDescription' => $data['PositionDescription'] ?? null,
        ];
    }
}
