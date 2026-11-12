<?php

namespace App\Models;

class TblPlafondModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_TblPlafond_GetList', ['Search' => $search, 'PlafondID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_TblPlafond_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_TblPlafond_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_TblPlafond_Delete', ['PlafondID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'PlafondID'          => $data['PlafondID'] ?? null,
            'Amount'             => $data['Amount'] ?? null,
            'PlafondDescription' => $data['PlafondDescription'] ?? null,
        ];
    }
}
