<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\DetailKaryawanModel;
use Throwable;

class DetailKaryawan extends BaseController
{
    protected DetailKaryawanModel $model;

    protected array $rules = [
        'KaryawanID'    => ['label' => 'ID karyawan', 'rules' => 'required|max_length[10]'],
        'FirstName'     => ['label' => 'Nama depan', 'rules' => 'required|max_length[50]'],
        'MiddleName'    => ['label' => 'Nama tengah', 'rules' => 'permit_empty|max_length[50]'],
        'LastName'      => ['label' => 'Nama belakang', 'rules' => 'permit_empty|max_length[50]'],
        'EmailAddress'  => ['label' => 'Email', 'rules' => 'permit_empty|valid_email|max_length[50]'],
        'Phone'         => ['label' => 'Telepon', 'rules' => 'permit_empty|max_length[50]'],
        'BirthDate'     => ['label' => 'Tanggal lahir', 'rules' => 'permit_empty|valid_date[Y-m-d]'],
        'BirthPlace'    => ['label' => 'Tempat lahir', 'rules' => 'permit_empty|max_length[200]'],
        'MaritalStatus' => ['label' => 'Status pernikahan', 'rules' => 'permit_empty|max_length[10]'],
        'Gender'        => ['label' => 'Gender', 'rules' => 'permit_empty|max_length[10]'],
        'Other'         => ['label' => 'Lainnya', 'rules' => 'permit_empty|max_length[60]'],
        'HP'            => ['label' => 'No. HP', 'rules' => 'permit_empty|max_length[100]'],
    ];

    public function __construct()
    {
        $this->model = new DetailKaryawanModel();
    }

    public function index()
    {
        try {
            $rows = $this->model->getList($this->request->getGet('search') ?: null);

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
        $data               = $this->input();
        $data['KaryawanID'] = $id;

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
