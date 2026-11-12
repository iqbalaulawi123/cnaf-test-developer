<?php

namespace App\Models;

use App\Exceptions\ProcedureException;

abstract class ProcedureModel
{
    private $conn;

    abstract public function getList(?string $search = null, ?string $id = null): array;

    abstract public function create(array $data): array;

    abstract public function update(array $data): array;

    abstract public function delete(string $id): array;

    public function find(string $id): ?array
    {
        return $this->getList(null, $id)[0] ?? null;
    }

    protected function call(string $procedure, array $params = []): array
    {
        $assignments = array_map(static fn ($name) => "@{$name} = ?", array_keys($params));
        $sql         = trim("EXEC dbo.{$procedure} " . implode(', ', $assignments));

        $stmt = $this->execute($sql, array_values($params));
        $rows = $this->fetchAll($stmt);
        $this->finish($stmt);

        return $rows;
    }

    protected function execute(string $sql, array $params)
    {
        $stmt = sqlsrv_query($this->connection(), $sql, $params);

        if ($stmt === false) {
            throw ProcedureException::fromErrors(sqlsrv_errors());
        }

        return $stmt;
    }

    protected function fetchAll($stmt): array
    {
        $rows = [];

        if (sqlsrv_num_fields($stmt) > 0) {
            while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
                $rows[] = $row;
            }
        }

        return $rows;
    }

    protected function finish($stmt): void
    {
        while (($next = sqlsrv_next_result($stmt)) !== null) {
            if ($next === false) {
                $errors = sqlsrv_errors();
                sqlsrv_free_stmt($stmt);

                throw ProcedureException::fromErrors($errors);
            }
        }

        sqlsrv_free_stmt($stmt);
    }

    protected function toSqlDate(?string $date): ?string
    {
        return $date ? date('Ymd', strtotime($date)) : null;
    }

    protected function toBit($value): ?int
    {
        return $value === null || $value === '' ? null : (int) $value;
    }

    private function connection()
    {
        if ($this->conn === null) {
            $db = db_connect();
            $db->initialize();
            $this->conn = $db->connID;
        }

        return $this->conn;
    }
}
