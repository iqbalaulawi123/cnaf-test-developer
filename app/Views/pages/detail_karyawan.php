<?= $this->extend('layouts/main') ?>

<?= $this->section('content') ?>
<div data-master data-endpoint="detail-karyawan" data-key="KaryawanID">
    <h1 class="h3 mb-4"><?= esc($title) ?></h1>

    <div class="card">
        <div class="card-body">
            <div class="row g-2 mb-3">
                <div class="col">
                    <input type="search" class="form-control" placeholder="Cari ID, nama, atau email..." data-search>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-nowrap mb-0">
                    <thead>
                        <tr>
                            <th data-field="KaryawanID">ID</th>
                            <th data-field="FirstName">Nama Depan</th>
                            <th data-field="MiddleName">Nama Tengah</th>
                            <th data-field="LastName">Nama Belakang</th>
                            <th data-field="EmailAddress">Email</th>
                            <th data-field="HP">No. HP</th>
                            <th data-field="BirthDate" data-format="date">Tanggal Lahir</th>
                            <th data-field="BirthPlace">Tempat Lahir</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-3">
                <small class="text-body-secondary" data-info></small>
                <ul class="pagination pagination-sm mb-0" data-pager></ul>
            </div>
        </div>
    </div>
</div>
<?= $this->endSection() ?>

<?= $this->section('scripts') ?>
<script src="<?= base_url('js/master.js') ?>"></script>
<?= $this->endSection() ?>
