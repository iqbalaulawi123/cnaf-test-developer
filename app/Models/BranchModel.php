<?php

namespace App\Models;

class BranchModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_Branch_GetList', ['Search' => $search, 'BranchID' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_Branch_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_Branch_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_Branch_Delete', ['BranchID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'BranchID'       => $data['BranchID'] ?? null,
            'BranchFullName' => $data['BranchFullName'] ?? null,
            'BranchAddress'  => $data['BranchAddress'] ?? null,
        ];
    }
}
