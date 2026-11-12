<?php

namespace App\Models;

class AnggotaModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null, bool $includeVoid = false): array
    {
        return $this->call('usp_Anggota_GetList', [
            'Search'      => $search,
            'AnggotaID'   => $id,
            'IncludeVoid' => $includeVoid ? 1 : 0,
        ]);
    }

    public function find(string $id): ?array
    {
        return $this->getList(null, $id, true)[0] ?? null;
    }

    public function create(array $data): array
    {
        return $this->call('usp_Anggota_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_Anggota_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_Anggota_Delete', ['AnggotaID' => $id]);
    }

    private function params(array $data): array
    {
        return [
            'AnggotaID'  => $data['AnggotaID'] ?? null,
            'BranchID'   => $data['BranchID'] ?? null,
            'KaryawanID' => $data['KaryawanID'] ?? null,
            'Plafond'    => $data['Plafond'] ?? null,
            'isValid'    => $this->toBit($data['isValid'] ?? null),
        ];
    }
}
