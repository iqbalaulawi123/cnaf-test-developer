# CodeIgniter 4 Application Starter

## What is CodeIgniter?

CodeIgniter is a PHP full-stack web framework that is light, fast, flexible and secure.
More information can be found at the [official site](https://codeigniter.com).

This repository holds a composer-installable app starter.
It has been built from the
[development repository](https://github.com/codeigniter4/CodeIgniter4).

More information about the plans for version 4 can be found in [CodeIgniter 4](https://forum.codeigniter.com/forumdisplay.php?fid=28) on the forums.

You can read the [user guide](https://codeigniter.com/user_guide/)
corresponding to the latest version of the framework.

## Installation & updates

`composer create-project codeigniter4/appstarter` then `composer update` whenever
there is a new release of the framework.

When updating, check the release notes to see if there are any changes you might need to apply
to your `app` folder. The affected files can be copied or merged from
`vendor/codeigniter4/framework/app`.

## Setup

Copy `env` to `.env` and tailor for your app, specifically the baseURL
and any database settings.

## Important Change with index.php

`index.php` is no longer in the root of the project! It has been moved inside the *public* folder,
for better security and separation of components.

This means that you should configure your web server to "point" to your project's *public* folder, and
not to the project root. A better practice would be to configure a virtual host to point there. A poor practice would be to point your web server to the project root and expect to enter *public/...*, as the rest of your logic and the
framework are exposed.

**Please** read the user guide for a better explanation of how CI4 works!

## Repository Management

We use GitHub issues, in our main repository, to track **BUGS** and to track approved **DEVELOPMENT** work packages.
We use our [forum](http://forum.codeigniter.com) to provide SUPPORT and to discuss
FEATURE REQUESTS.

This repository is a "distribution" one, built by our release preparation script.
Problems with it can be raised on our forum, or as issues in the main repository.

## Server Requirements

PHP version 8.2 or higher is required, with the following extensions installed:

- [intl](http://php.net/manual/en/intl.requirements.php)
- [mbstring](http://php.net/manual/en/mbstring.installation.php)

> [!WARNING]
> - The end of life date for PHP 7.4 was November 28, 2022.
> - The end of life date for PHP 8.0 was November 26, 2023.
> - The end of life date for PHP 8.1 was December 31, 2025.
> - If you are still using below PHP 8.2, you should upgrade immediately.
> - The end of life date for PHP 8.2 will be December 31, 2026.

Additionally, make sure that the following extensions are enabled in your PHP:

- json (enabled by default - don't turn it off)
- [mysqlnd](http://php.net/manual/en/mysqlnd.install.php) if you plan to use MySQL
- [libcurl](http://php.net/manual/en/curl.requirements.php) if you plan to use the HTTP\CURLRequest library


## Git

**Apa beda `git fetch` dan `git pull`?**
`git fetch` hanya mengambil commit terbaru dari remote ke `origin/<branch>` tanpa mengubah branch lokal dan working tree, jadi aman dipakai untuk melihat perubahan dulu. 
`git pull` adalah `fetch` lalu langsung `merge` (atau `rebase` kalau memakai `--rebase`) ke branch yang sedang aktif.

**Apa beda `git reset --hard` dan `git revert`, dan kapan masing-masing aman dipakai?**
`git reset --hard <commit>` memindahkan branch ke commit tersebut dan membuang semua perubahan sesudahnya, termasuk yang belum di-commit, sehingga history ditulis ulang. Ini aman hanya untuk commit lokal yang belum di-push.
`git revert <commit>` membuat commit baru yang membatalkan isi commit tersebut tanpa mengubah history. Ini cara yang aman untuk commit yang **sudah di-push** atau dipakai orang lain.

**Apa beda `merge` dan `rebase`, dan kapan `rebase` tidak boleh dipakai?**
`merge` menggabungkan dua branch dengan membuat merge commit. History asli tetap utuh, tapi bentuknya bercabang.
`rebase` memindahkan commit-commit branch ke atas base yang baru, sehingga history lurus. Konsekuensinya, hash commit berubah dan branch yang sudah di-push perlu `git push --force-with-lease`.
`rebase` tidak boleh dipakai pada branch yang sudah dipakai bersama orang lain (misalnya `main`), karena menulis ulang history yang sudah mereka ambil.

**Bagaimana mengembalikan commit yang "hilang" setelah `reset --hard`?**
Commit tersebut sebenarnya masih ada, hanya tidak ditunjuk branch mana pun. Langkahnya:
1. Jalankan `git reflog` untuk melihat riwayat posisi `HEAD`.
2. Cari hash commit sebelum reset.
3. Kembalikan dengan `git reset --hard <hash>`, atau buat branch baru.

Reflog bersifat lokal dan disimpan sekitar 90 hari secara bawaan.