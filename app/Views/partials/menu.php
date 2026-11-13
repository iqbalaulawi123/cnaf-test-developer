<?php
$groups = [
    'Karyawan' => [
        'karyawan'        => 'Karyawan',
        'detail-karyawan' => 'Detail Karyawan',
        'anggota'         => 'Anggota',
    ],
    'Master' => [
        'branch'         => 'Cabang',
        'departments'    => 'Departemen',
        'office'         => 'Kantor',
        'position'       => 'Posisi',
        'plafond'        => 'Plafond',
        'gender'         => 'Gender',
        'marital-status' => 'Status Pernikahan',
    ],
];

$current = uri_string();
?>
<?php foreach ($groups as $group => $menus): ?>
    <div class="small text-uppercase fw-semibold text-body-secondary px-3 mt-3 mb-2"><small><?= esc($group) ?></small></div>
    <div class="list-group list-group-flush">
        <?php foreach ($menus as $path => $label): ?>
            <a href="<?= site_url($path) ?>" class="list-group-item list-group-item-action<?= $current === $path ? ' active' : '' ?>"><?= esc($label) ?></a>
        <?php endforeach ?>
    </div>
<?php endforeach ?>
