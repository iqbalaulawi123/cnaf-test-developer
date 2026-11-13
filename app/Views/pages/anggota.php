<?= $this->extend('layouts/main') ?>

<?= $this->section('content') ?>
<div data-master data-endpoint="anggota" data-key="AnggotaID">
    <h1 class="h3 mb-4"><?= esc($title) ?></h1>

    <div class="card">
        <div class="card-body">
            <div class="row g-2 mb-3">
                <div class="col">
                    <input type="search" class="form-control" placeholder="Cari ID anggota atau nama..." data-search>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-nowrap mb-0">
                    <thead>
                        <tr>
                            <th data-field="AnggotaID">ID</th>
                            <th data-field="NamaLengkap">Karyawan</th>
                            <th data-field="NamaCabang">Cabang</th>
                            <th data-field="DeskripsiPlafond">Plafond</th>
                            <th data-field="Amount" data-format="number">Amount</th>
                            <th data-field="isValid" data-format="yesno">Valid</th>
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
