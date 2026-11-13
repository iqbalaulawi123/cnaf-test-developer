<?= $this->extend('layouts/main') ?>

<?= $this->section('content') ?>
<div data-master data-endpoint="marital-status" data-key="MaritalStatusID">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0"><?= esc($title) ?></h1>
        <button type="button" class="btn btn-primary" data-add>Tambah</button>
    </div>

    <div class="card">
        <div class="card-body">
            <input type="search" class="form-control mb-3" placeholder="Cari ID atau deskripsi..." data-search>

            <table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th data-field="MaritalStatusID">ID</th>
                        <th data-field="MaritalStatusDescription">Deskripsi</th>
                        <th class="text-end">Aksi</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <form class="modal-content" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="MaritalStatusID" class="form-label">ID Status Pernikahan</label>
                        <input type="text" class="form-control" id="MaritalStatusID" name="MaritalStatusID" maxlength="10" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label for="MaritalStatusDescription" class="form-label">Deskripsi</label>
                        <input type="text" class="form-control" id="MaritalStatusDescription" name="MaritalStatusDescription" maxlength="50" required>
                        <div class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">
                        <span class="spinner-border spinner-border-sm d-none me-1"></span>Simpan
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<?= $this->endSection() ?>

<?= $this->section('scripts') ?>
<script src="<?= base_url('js/master.js') ?>"></script>
<?= $this->endSection() ?>
