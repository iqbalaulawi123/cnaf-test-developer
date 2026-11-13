function masterPage(root) {
    var $root = $(root);
    var endpoint = $root.data('endpoint');
    var key = $root.data('key');
    var paged = $root.is('[data-paged]');
    var fetchRow = $root.is('[data-fetch]');
    var columns = $root.find('thead th[data-field]').map(function () {
        return $(this).data();
    }).get();
    var $tbody = $root.find('tbody');
    var $search = $root.find('[data-search]');
    var $filters = $root.find('[data-filter]');
    var $pager = $root.find('[data-pager]');
    var $info = $root.find('[data-info]');
    var $modal = $root.find('.modal');
    var $form = $modal.find('form');
    var $saveButton = $form.find('[type="submit"]');
    var editable = $modal.length > 0;
    var pageSize = 10;
    var page = 1;
    var rows = [];
    var editingId = null;
    var requestId = 0;

    function showMessage(text) {
        var $cell = $('<td>', {
            colspan: columns.length + (editable ? 1 : 0),
            'class': 'text-center text-body-secondary py-4'
        }).text(text);

        $tbody.empty().append($('<tr>').append($cell));
    }

    function render(items) {
        if (items.length === 0) {
            showMessage('Data tidak ditemukan.');
            return;
        }

        $tbody.empty();

        $.each(items, function (index, row) {
            var $tr = $('<tr>');

            $.each(columns, function (i, column) {
                $tr.append($('<td>').text(formatValue(row[column.field], column.format)));
            });

            if (editable) {
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
            }

            $tbody.append($tr);
        });
    }

    function pageItem(label, target, disabled, active) {
        var $link = $('<button>', { type: 'button', 'class': 'page-link' })
            .text(label)
            .on('click', function () {
                goTo(target);
            });

        return $('<li>', { 'class': 'page-item' + (disabled ? ' disabled' : '') + (active ? ' active' : '') }).append($link);
    }

    function renderPager(total) {
        var totalPages = Math.max(1, Math.ceil(total / pageSize));
        var end = Math.min(totalPages, Math.max(1, page - 2) + 4);
        var start = Math.max(1, end - 4);
        var i;

        $pager.empty();
        $info.text('');

        if (total === 0) {
            return;
        }

        $info.text('Menampilkan ' + ((page - 1) * pageSize + 1) + '–' + Math.min(page * pageSize, total)
            + ' dari ' + total.toLocaleString('id-ID') + ' data');

        $pager.append(pageItem('«', 1, page === 1), pageItem('‹', page - 1, page === 1));

        for (i = start; i <= end; i++) {
            $pager.append(pageItem(String(i), i, false, i === page));
        }

        $pager.append(pageItem('›', page + 1, page === totalPages), pageItem('»', totalPages, page === totalPages));
    }

    function show(items, total) {
        render(items);
        renderPager(total);
    }

    function showPage() {
        show(rows.slice((page - 1) * pageSize, page * pageSize), rows.length);
    }

    function params() {
        var result = {};
        var search = $.trim($search.val());

        if (search) {
            result.search = search;
        }

        $filters.each(function () {
            var value = $(this).val();

            if (value !== '') {
                result[this.name] = value;
            }
        });

        if (paged) {
            result.page = page;
            result.size = pageSize;
        }

        return result;
    }

    function load() {
        var current = ++requestId;
        var query = params();

        showMessage('Memuat data...');

        api('GET', '/' + endpoint + ($.isEmptyObject(query) ? '' : '?' + $.param(query)))
            .done(function (result) {
                if (current !== requestId) {
                    return;
                }

                if (paged) {
                    show(result.data.rows, result.data.total);
                } else {
                    rows = result.data;
                    showPage();
                }
            })
            .fail(function (error) {
                if (current === requestId) {
                    showMessage(error.message);
                    renderPager(0);
                    notify(error.message, 'danger');
                }
            });
    }

    function goTo(target) {
        page = target;

        if (paged) {
            load();
        } else {
            showPage();
        }
    }

    function reload() {
        page = 1;
        load();
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

        if (row && fetchRow) {
            requests.push(api('GET', '/' + endpoint + '/' + encodeURIComponent(row[key])).done(function (result) {
                row = result.data;
            }));
        }

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

    if (editable) {
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
    }

    $search.on('input', debounce(reload));
    $filters.on('change', reload);

    $filters.filter('select[data-source]').each(function () {
        loadOptions(this).fail(function (error) {
            notify(error.message, 'danger');
        });
    });

    load();
}

$(function () {
    $('[data-master]').each(function () {
        masterPage(this);
    });
});
