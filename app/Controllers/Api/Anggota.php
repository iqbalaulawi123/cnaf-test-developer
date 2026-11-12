<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\AnggotaModel;
use Throwable;

class Anggota extends BaseController
{
    protected AnggotaModel $model;

    protected array $rules = [
        'AnggotaID'  => ['label' => 'ID anggota', 'rules' => 'required|max_length[20]'],
        'BranchID'   => ['label' => 'Cabang', 'rules' => 'required|max_length[10]'],
        'KaryawanID' => ['label' => 'Karyawan', 'rules' => 'required|max_length[10]'],
        'Plafond'    => ['label' => 'Plafond', 'rules' => 'required|max_length[16]'],
        'isValid'    => ['label' => 'Status valid', 'rules' => 'permit_empty|in_list[0,1]'],
    ];

    public function __construct()
    {
        $this->model = new AnggotaModel();
    }

    public function index()
    {
        try {
            $rows = $this->model->getList(
                $this->request->getGet('search') ?: null,
                null,
                $this->request->getGet('void') === '1'
            );

            return $this->respondSuccess($rows);
        } catch (Throwable $e) {
            return $this->handleException($e);
        }
    }

    public function show($id)
    {
        try {
            $row = $this->model->find($id);

            if ($row === null) {
                return $this->respondError('Data tidak ditemukan.', 404);
            }

            return $this->respondSuccess($row);
        } catch (Throwable $e) {
            return $this->handleException($e);
        }
    }

    public function create()
    {
        $data = $this->input();

        if (! $this->validateData($data, $this->rules)) {
            return $this->respondError('Data yang dikirim tidak valid.', 422, $this->validator->getErrors());
        }

        try {
            $result = $this->model->create($data);

            return $this->respondSuccess($result[0] ?? null, 'Data berhasil ditambahkan.', 201);
        } catch (Throwable $e) {
            return $this->handleException($e);
        }
    }

    public function update($id)
    {
        $data              = $this->input();
        $data['AnggotaID'] = $id;

        if (! $this->validateData($data, $this->rules)) {
            return $this->respondError('Data yang dikirim tidak valid.', 422, $this->validator->getErrors());
        }

        try {
            $result = $this->model->update($data);

            return $this->respondSuccess($result[0] ?? null, 'Data berhasil diubah.');
        } catch (Throwable $e) {
            return $this->handleException($e);
        }
    }

    public function delete($id)
    {
        try {
            $result = $this->model->delete($id);

            return $this->respondSuccess($result[0] ?? null, 'Data berhasil dihapus.');
        } catch (Throwable $e) {
            return $this->handleException($e);
        }
    }
}
