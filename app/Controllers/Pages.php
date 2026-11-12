<?php

namespace App\Controllers;

class Pages extends BaseController
{
    public function karyawan(): string
    {
        return view('pages/karyawan', ['title' => 'Karyawan']);
    }

    public function detailKaryawan(): string
    {
        return view('pages/detail_karyawan', ['title' => 'Detail Karyawan']);
    }

    public function anggota(): string
    {
        return view('pages/anggota', ['title' => 'Anggota']);
    }

    public function branch(): string
    {
        return view('pages/branch', ['title' => 'Cabang']);
    }

    public function departments(): string
    {
        return view('pages/departments', ['title' => 'Departemen']);
    }

    public function office(): string
    {
        return view('pages/office', ['title' => 'Kantor']);
    }

    public function position(): string
    {
        return view('pages/position', ['title' => 'Posisi']);
    }

    public function plafond(): string
    {
        return view('pages/plafond', ['title' => 'Plafond']);
    }

    public function gender(): string
    {
        return view('pages/gender', ['title' => 'Gender']);
    }

    public function maritalStatus(): string
    {
        return view('pages/marital_status', ['title' => 'Status Pernikahan']);
    }
}
