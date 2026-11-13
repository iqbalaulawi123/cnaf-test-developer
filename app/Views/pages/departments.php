<?= $this->extend('layouts/main') ?>

<?= $this->section('content') ?>
<div data-master data-endpoint="departments" data-key="dept_id">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0"><?= esc($title) ?></h1>
        <button type="button" class="btn btn-primary" data-add>Tambah</button>
    </div>

    <div class="card">
        <div class="card-body">
            <input type="search" class="form-control mb-3" placeholder="Cari ID atau nama departemen..." data-search>

            <table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th data-field="dept_id">ID</th>
                        <th data-field="dept_name">Nama Departemen</th>
                        <th data-field="dept_parentname">Departemen Induk</th>
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
                        <label for="dept_id" class="form-label">ID Departemen</label>
                        <input type="text" class="form-control" id="dept_id" name="dept_id" maxlength="16" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label for="dept_name" class="form-label">Nama Departemen</label>
                        <input type="text" class="form-control" id="dept_name" name="dept_name" maxlength="100" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label for="dept_parentid" class="form-label">Departemen Induk</label>
                        <select class="form-select" id="dept_parentid" name="dept_parentid" data-source="departments" data-value="dept_id" data-label="dept_name">
                            <option value="">-- Tidak ada --</option>
                        </select>
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
