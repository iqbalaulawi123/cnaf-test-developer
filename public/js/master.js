function masterPage(root) {
    var $root = $(root);
    var endpoint = $root.data('endpoint');
    var key = $root.data('key');
    var columns = $root.find('thead th[data-field]').map(function () {
        return $(this).data();
    }).get();
    var $tbody = $root.find('tbody');
    var $search = $root.find('[data-search]');
    var $modal = $root.find('.modal');
    var $form = $modal.find('form');
    var $saveButton = $form.find('[type="submit"]');
    var editingId = null;
    var requestId = 0;

    function showMessage(text) {
        var $cell = $('<td>', { colspan: columns.length + 1, 'class': 'text-center text-body-secondary py-4' }).text(text);

        $tbody.empty().append($('<tr>').append($cell));
    }

    function render(rows) {
        if (rows.length === 0) {
            showMessage('Data tidak ditemukan.');
            return;
        }

        $tbody.empty();

        $.each(rows, function (index, row) {
            var $tr = $('<tr>');

            $.each(columns, function (i, column) {
                $tr.append($('<td>').text(formatValue(row[column.field], column.format)));
            });

            $tr.append($('<td>', { 'class': 'text-end text-nowrap' }).append(
                $('<button>', { type: 'button', 'class': 'btn btn-sm btn-outline-primary me-1' })
                    .text('Ubah')
                    .on('click', function () {
                        openForm(row);
                    }),
                $('<button>', { type: 'button', 'class': 'btn btn-sm btn-outline-danger' })
                    .text('Hapus')
                    .on('click', function () {
                        remove(row);
                    })
            ));

            $tbody.append($tr);
        });
    }

    function load() {
        var current = ++requestId;
        var search = $.trim($search.val());

        showMessage('Memuat data...');

        api('GET', '/' + endpoint + (search ? '?' + $.param({ search: search }) : ''))
            .done(function (result) {
                if (current === requestId) {
                    render(result.data);
                }
            })
            .fail(function (error) {
                if (current === requestId) {
                    showMessage(error.message);
                    notify(error.message, 'danger');
                }
            });
    }

    function openForm(row) {
        var requests;

        row = row || null;
        editingId = row ? row[key] : null;

        $form[0].reset();
        clearErrors($form);

        requests = $form.find('select[data-source]').map(function () {
            return loadOptions(this);
        }).get();

        $.when.apply($, requests)
            .done(function () {
                if (row) {
                    fillForm($form, row);
                }

                $form.find('[name="' + key + '"]').prop('readonly', row !== null);
                $modal.find('.modal-title').text(row ? 'Ubah Data' : 'Tambah Data');
                $modal.modal('show');
            })
            .fail(function (error) {
                notify(error.message, 'danger');
            });
    }

    function remove(row) {
        confirmDialog('Hapus data ' + row[key] + '?').done(function () {
            api('POST', '/' + endpoint + '/delete/' + encodeURIComponent(row[key]))
                .done(function (result) {
                    notify(result.message);
                    load();
                })
                .fail(function (error) {
                    notify(error.message, 'danger');
                });
        });
    }

    $form.on('submit', function (event) {
        var url = editingId === null
            ? '/' + endpoint + '/add'
            : '/' + endpoint + '/update/' + encodeURIComponent(editingId);

        event.preventDefault();

        if (!validateForm($form)) {
            return;
        }

        setLoading($saveButton, true);

        api('POST', url, formValues($form))
            .done(function (result) {
                $modal.modal('hide');
                notify(result.message);
                load();
            })
            .fail(function (error) {
                if (error.status === 422) {
                    showErrors($form, error.errors);
                }

                notify(error.message, 'danger');
            })
            .always(function () {
                setLoading($saveButton, false);
            });
    });

    $root.find('[data-add]').on('click', function () {
        openForm();
    });

    $search.on('input', debounce(load));

    load();
}

$(function () {
    $('[data-master]').each(function () {
        masterPage(this);
    });
});
