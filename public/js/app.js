var API_URL = $('meta[name="api-url"]').attr('content');

function api(method, url, body) {
    var options = { url: API_URL + url, method: method, dataType: 'json' };

    if (body !== undefined) {
        options.contentType = 'application/json';
        options.data = JSON.stringify(body);
    }

    return $.ajax(options).then(null, function (xhr) {
        var json = xhr.responseJSON || {};
        var message = xhr.status === 0
            ? 'Tidak dapat terhubung ke server.'
            : (json.message || 'Terjadi kesalahan pada server.');

        return $.Deferred().reject({ status: xhr.status, message: message, errors: json.data || null });
    });
}

function debounce(fn, wait) {
    var timer;

    return function () {
        var context = this;
        var args = arguments;

        clearTimeout(timer);
        timer = setTimeout(function () {
            fn.apply(context, args);
        }, wait || 300);
    };
}

function notify(message, type) {
    var $toast = $($.trim($('#toastTemplate').html())).addClass('text-bg-' + (type || 'success'));

    $toast.find('.toast-body').text(message);
    $toast.on('hidden.bs.toast', function () {
        $toast.remove();
    });

    $('#toastContainer').append($toast);
    $toast.toast('show');
}

function confirmDialog(message) {
    var $modal = $('#confirmModal');
    var deferred = $.Deferred();
    var confirmed = false;

    $modal.find('.modal-body').text(message);
    $modal.find('[data-confirm]').off('click').on('click', function () {
        confirmed = true;
        $modal.modal('hide');
    });

    $modal.one('hidden.bs.modal', function () {
        if (confirmed) {
            deferred.resolve();
        } else {
            deferred.reject();
        }
    });

    $modal.modal('show');

    return deferred.promise();
}

function formatValue(value, format) {
    if (value === null || value === undefined) {
        return '';
    }

    if (format === 'number') {
        return Number(value).toLocaleString('id-ID');
    }

    if (format === 'date') {
        return String(value).substring(0, 10);
    }

    if (format === 'yesno') {
        return value === true || value === 1 || value === '1' ? 'Ya' : 'Tidak';
    }

    return String(value);
}

function loadOptions(select) {
    var $select = $(select);

    return api('GET', '/' + $select.data('source')).done(function (result) {
        $select.find('option').not(':first').remove();

        $.each(result.data, function (index, row) {
            $select.append(new Option(row[$select.data('label')], row[$select.data('value')]));
        });
    });
}

function setLoading($button, loading) {
    $button.prop('disabled', loading).find('.spinner-border').toggleClass('d-none', !loading);
}

function formValues($form) {
    var values = {};

    $form.find('[name]').each(function () {
        values[this.name] = this.type === 'checkbox' ? this.checked : $(this).val();
    });

    return values;
}

function fillForm($form, data) {
    $form.find('[name]').each(function () {
        var value = data[this.name];

        if (value === null || value === undefined) {
            value = '';
        }

        if (this.type === 'date') {
            value = String(value).substring(0, 10);
        }

        if (this.type === 'checkbox') {
            $(this).prop('checked', value === true || value === 1 || value === '1');
        } else {
            $(this).val(value);
        }
    });
}

function setFieldError($field, message) {
    $field.addClass('is-invalid').siblings('.invalid-feedback').text(message);
}

function clearErrors($form) {
    $form.find('.is-invalid').removeClass('is-invalid');
}

function validateForm($form) {
    var valid = true;

    clearErrors($form);

    $form.find('[name]').each(function () {
        if (!this.checkValidity()) {
            setFieldError($(this), this.validationMessage);
            valid = false;
        }
    });

    return valid;
}

function showErrors($form, errors) {
    $.each(errors || {}, function (name, message) {
        setFieldError($form.find('[name="' + name + '"]'), message);
    });
}
