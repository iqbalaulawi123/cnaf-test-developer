<?= $this->extend('layouts/main') ?>

<?= $this->section('content') ?>
<div data-master data-endpoint="karyawan" data-key="KaryawanID" data-paged data-fetch>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0"><?= esc($title) ?></h1>
        <button type="button" class="btn btn-primary" data-add>Tambah</button>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="row g-2 mb-3">
                <div class="col">
                    <input type="search" class="form-control" placeholder="Cari ID, nama, atau email..." data-search>
                </div>
                <div class="col-auto">
                    <select class="form-select" name="branch" data-filter data-source="branch" data-value="BranchID" data-label="BranchFullName">
                        <option value="">Semua cabang</option>
                    </select>
                </div>
                <div class="col-auto">
                    <select class="form-select" name="active" data-filter>
                        <option value="">Semua status</option>
                        <option value="1">Aktif</option>
                        <option value="0">Nonaktif</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-nowrap mb-0">
                    <thead>
                        <tr>
                            <th data-field="KaryawanID">ID</th>
                            <th data-field="NamaLengkap">Nama Lengkap</th>
                            <th data-field="NamaCabang">Cabang</th>
                            <th data-field="NamaDepartemen">Departemen</th>
                            <th data-field="NamaPosisi">Posisi</th>
                            <th data-field="Email">Email</th>
                            <th data-field="Status">Status</th>
                            <th class="text-end">Aksi</th>
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

    <div class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <form class="modal-content" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                        <h6 class="text-body-secondary">Data Karyawan</h6>
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <label for="KaryawanID" class="form-label">ID Karyawan</label>
                                <input type="text" class="form-control" id="KaryawanID" name="KaryawanID" maxlength="10" required>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="BranchID" class="form-label">Cabang</label>
                                <select class="form-select" id="BranchID" name="BranchID" data-source="branch" data-value="BranchID" data-label="BranchFullName" required>
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="Dept_ID" class="form-label">Departemen</label>
                                <select class="form-select" id="Dept_ID" name="Dept_ID" data-source="departments" data-value="dept_id" data-label="dept_name" required>
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="OfficeID" class="form-label">Kantor</label>
                                <select class="form-select" id="OfficeID" name="OfficeID" data-source="office" data-value="OfficeID" data-label="OfficeDescription" required>
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="PositionID" class="form-label">Posisi</label>
                                <select class="form-select" id="PositionID" name="PositionID" data-source="position" data-value="PositionID" data-label="PositionDescription" required>
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6 d-flex align-items-end">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" id="Isactive" name="Isactive" checked>
                                    <label class="form-check-label" for="Isactive">Aktif</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>

                        <h6 class="text-body-secondary">Data Pribadi</h6>
                        <div class="row g-3">
                            <div class="col-6">
                                <label for="FirstName" class="form-label">Nama Depan</label>
                                <input type="text" class="form-control" id="FirstName" name="FirstName" maxlength="50" required>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="MiddleName" class="form-label">Nama Tengah</label>
                                <input type="text" class="form-control" id="MiddleName" name="MiddleName" maxlength="50">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="LastName" class="form-label">Nama Belakang</label>
                                <input type="text" class="form-control" id="LastName" name="LastName" maxlength="50">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="EmailAddress" class="form-label">Email</label>
                                <input type="email" class="form-control" id="EmailAddress" name="EmailAddress" maxlength="50">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="Phone" class="form-label">Telepon</label>
                                <input type="text" class="form-control" id="Phone" name="Phone" maxlength="50">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="HP" class="form-label">No. HP</label>
                                <input type="text" class="form-control" id="HP" name="HP" maxlength="100">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="BirthPlace" class="form-label">Tempat Lahir</label>
                                <input type="text" class="form-control" id="BirthPlace" name="BirthPlace" maxlength="200">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="BirthDate" class="form-label">Tanggal Lahir</label>
                                <input type="date" class="form-control" id="BirthDate" name="BirthDate">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="Gender" class="form-label">Gender</label>
                                <select class="form-select" id="Gender" name="Gender" data-source="gender" data-value="GenderTypeID" data-label="GenderTypeDescription">
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-6">
                                <label for="MaritalStatus" class="form-label">Status Pernikahan</label>
                                <select class="form-select" id="MaritalStatus" name="MaritalStatus" data-source="marital-status" data-value="MaritalStatusID" data-label="MaritalStatusDescription">
                                    <option value="">-- Pilih --</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-12">
                                <label for="Other" class="form-label">Lainnya</label>
                                <input type="text" class="form-control" id="Other" name="Other" maxlength="60">
                                <div class="invalid-feedback"></div>
                            </div>
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
