<?php

use CodeIgniter\Router\RouteCollection;

$routes->get('/', 'Home::index');

$routes->group('api', ['namespace' => 'App\Controllers\Api'], static function (RouteCollection $routes) {
    $routes->get('karyawan', 'Karyawan::index');
    $routes->get('karyawan/(:segment)', 'Karyawan::show/$1');
    $routes->post('karyawan/add', 'Karyawan::create');
    $routes->post('karyawan/update/(:segment)', 'Karyawan::update/$1');
    $routes->post('karyawan/delete/(:segment)', 'Karyawan::delete/$1');

    $routes->get('detail-karyawan', 'DetailKaryawan::index');
    $routes->get('detail-karyawan/(:segment)', 'DetailKaryawan::show/$1');
    $routes->post('detail-karyawan/add', 'DetailKaryawan::create');
    $routes->post('detail-karyawan/update/(:segment)', 'DetailKaryawan::update/$1');
    $routes->post('detail-karyawan/delete/(:segment)', 'DetailKaryawan::delete/$1');

    $routes->get('anggota', 'Anggota::index');
    $routes->get('anggota/(:segment)', 'Anggota::show/$1');
    $routes->post('anggota/add', 'Anggota::create');
    $routes->post('anggota/update/(:segment)', 'Anggota::update/$1');
    $routes->post('anggota/delete/(:segment)', 'Anggota::delete/$1');

    $routes->get('branch', 'Branch::index');
    $routes->get('branch/(:segment)', 'Branch::show/$1');
    $routes->post('branch/add', 'Branch::create');
    $routes->post('branch/update/(:segment)', 'Branch::update/$1');
    $routes->post('branch/delete/(:segment)', 'Branch::delete/$1');

    $routes->get('departments', 'Departments::index');
    $routes->get('departments/tree', 'Departments::tree');
    $routes->get('departments/(:segment)', 'Departments::show/$1');
    $routes->post('departments/add', 'Departments::create');
    $routes->post('departments/update/(:segment)', 'Departments::update/$1');
    $routes->post('departments/delete/(:segment)', 'Departments::delete/$1');

    $routes->get('position', 'TblPosition::index');
    $routes->get('position/(:segment)', 'TblPosition::show/$1');
    $routes->post('position/add', 'TblPosition::create');
    $routes->post('position/update/(:segment)', 'TblPosition::update/$1');
    $routes->post('position/delete/(:segment)', 'TblPosition::delete/$1');

    $routes->get('office', 'TblOffice::index');
    $routes->get('office/(:segment)', 'TblOffice::show/$1');
    $routes->post('office/add', 'TblOffice::create');
    $routes->post('office/update/(:segment)', 'TblOffice::update/$1');
    $routes->post('office/delete/(:segment)', 'TblOffice::delete/$1');

    $routes->get('plafond', 'TblPlafond::index');
    $routes->get('plafond/(:segment)', 'TblPlafond::show/$1');
    $routes->post('plafond/add', 'TblPlafond::create');
    $routes->post('plafond/update/(:segment)', 'TblPlafond::update/$1');
    $routes->post('plafond/delete/(:segment)', 'TblPlafond::delete/$1');

    $routes->get('gender', 'TblGenderType::index');
    $routes->get('gender/(:segment)', 'TblGenderType::show/$1');
    $routes->post('gender/add', 'TblGenderType::create');
    $routes->post('gender/update/(:segment)', 'TblGenderType::update/$1');
    $routes->post('gender/delete/(:segment)', 'TblGenderType::delete/$1');

    $routes->get('marital-status', 'TblMaritalStatus::index');
    $routes->get('marital-status/(:segment)', 'TblMaritalStatus::show/$1');
    $routes->post('marital-status/add', 'TblMaritalStatus::create');
    $routes->post('marital-status/update/(:segment)', 'TblMaritalStatus::update/$1');
    $routes->post('marital-status/delete/(:segment)', 'TblMaritalStatus::delete/$1');
});
