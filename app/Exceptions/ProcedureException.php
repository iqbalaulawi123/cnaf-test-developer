<?php

namespace App\Exceptions;

use RuntimeException;

class ProcedureException extends RuntimeException
{
    private const CONSTRAINT_ERRORS = [547, 2601, 2627];

    public static function fromErrors(?array $errors): self
    {
        $errors = $errors ?: [];
        $error  = $errors[0] ?? ['code' => 0, 'message' => 'Unknown database error'];

        foreach ($errors as $item) {
            if ((int) $item['code'] >= 50000) {
                $error = $item;
                break;
            }
        }

        $message = preg_replace('/^(\[[^\]]*\])+/', '', (string) $error['message']);

        return new self(trim($message), (int) $error['code']);
    }

    public function isConflict(): bool
    {
        return $this->getCode() >= 50000 || in_array($this->getCode(), self::CONSTRAINT_ERRORS, true);
    }

    public function userMessage(): string
    {
        if ($this->getCode() >= 50000) {
            return $this->getMessage();
        }

        return 'Data bentrok dengan data lain (duplikat atau masih dipakai).';
    }
}
