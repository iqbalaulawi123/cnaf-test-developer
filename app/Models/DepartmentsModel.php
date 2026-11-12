<?php

namespace App\Models;

class DepartmentsModel extends ProcedureModel
{
    public function getList(?string $search = null, ?string $id = null): array
    {
        return $this->call('usp_Departments_GetList', ['Search' => $search, 'dept_id' => $id]);
    }

    public function create(array $data): array
    {
        return $this->call('usp_Departments_Insert', $this->params($data));
    }

    public function update(array $data): array
    {
        return $this->call('usp_Departments_Update', $this->params($data));
    }

    public function delete(string $id): array
    {
        return $this->call('usp_Departments_Delete', ['dept_id' => $id]);
    }

    public function getTree(?string $rootId = null): array
    {
        return $this->call('usp_Departments_GetTree', ['RootID' => $rootId]);
    }

    private function params(array $data): array
    {
        return [
            'dept_id'       => $data['dept_id'] ?? null,
            'dept_parentid' => $data['dept_parentid'] ?? null,
            'dept_name'     => $data['dept_name'] ?? null,
        ];
    }
}
