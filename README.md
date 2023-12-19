## Tugas Proyek Akhir Semester - PBP E08

[![Build status](https://build.appcenter.ms/v0.1/apps/644f8b00-be2d-4141-88fc-d5146e181d5e/branches/main/badge)](https://appcenter.ms)

## [__LiteraHub__](install.appcenter.ms/orgs/literahub/apps/literahub/distribution_groups/public)

**Anggota kelompok:**

1. Jeslyn Theodora - 2206082026
2. Puti Raissa - 2206830391
3. Muhammad Rafli Mahesa - 2206828140
4. Mohammad Fauzan Aditya - 2206827831
5. Rena Martha Ulima - 2206818783

**Cerita aplikasi yang diajukan serta manfaatnya**

LiteraHub adalah sebuah aplikasi perpustakaan yang dirancang supaya pengguna dapat mencari dan meminjam buku, berdiskusi dengan anggota perpustakaan lain dalam forum, serta melakukan _reservasi_ tempat untuk membaca. LiteraHub terdiri dari berbagai fitur, yaitu fitur LembarAsa, Forum, Daftar Buku, Pinjam Buku, dan Reservasi LiteraHub. Adapun manfaat LiteraHub, yaitu untuk memudahkan pengguna dalam mencari ketersediaan buku tanpa perlu datang ke perpustakaan secara langsung dan pengguna juga dapat berdiskusi mengenai topik bacaan sesuai dengan minatnya pada forum yang disediakan oleh LiteraHub. Pengguna yang memiliki karya tulis juga dapat mempublikasikan karyanya di LiteraHub. Selain itu, LiteraHub juga membantu pengguna untuk melihat ketersediaan tempat baca dan melakukan reservasi tempat baca di perpustakaan.

**Daftar modul yang akan diimplementasikan**

1. **Modul LembarAsa** - Puti Raissa

Pada aplikasi LiteraHub, terdapat fitur LembarAsa yang memungkinkan pengguna untuk mengunggah karyanya sendiri. Pengguna yang sudah login dapat memasukkan informasi mengenai karyanya seperti judul dan sampul, serta karya itu sendiri. Hasil karya pengguna akan terunggah ke dalam database buku. Pengguna dapat secara bebas menyunting dan menghapus karyanya sendiri. Pada halaman ini juga pengguna dapat melihat karya-karya lain milik pengguna lainnya.

2. **Modul Forum** - Jeslyn Theodora

Pengguna dapat mengisi obrolan dengan pengguna lainnya untuk saling memberi rekomendasi buku yang bagus ataupun hanya untuk sekedar berdiskusi. _Form_ pada modul ini akan meminta _input_ teks dan pengguna dapat menambahkan buku serta detailnya saat membuat pesan obrolan.

3. **Modul Daftar buku** - Mohammad Fauzan Aditya

Pada modul ini, pengguna dapat mencari buku yang diinginkan sesuai judul, nama penulis, dan tahunnya, seperti _search_ pada _e-commerce_. Bagian ini juga menampilkan buku-buku yang tersedia dan akan ada buku yang berasal dari modul LembarAsa (karya yang ditambahkan oleh pengguna juga akan ditampilkan disini). Selain itu, pengguna bisa mengisi/melihat review dari buku yang dicari.

4. **Modul Peminjaman buku** - Muhammad Rafli Mahesa

Modul Peminjaman Buku dalam aplikasi ini ditujukan bagi pengguna yang sudah login untuk proses peminjaman dan pengembalian buku. Modul ini menyajikan daftar buku yang tersedia untuk dipinjam beserta tombol akses ke halaman peminjaman buku. Pada halaman peminjaman, pengguna diminta untuk mengisi nama dan tanggal pengembalian, lalu data input form akan disimpan untuk detail peminjaman.
Selain tombol akses untuk peminjaman, modul ini juga mempunyai tombol akses untuk pengembalian. Pada halaman pengembalian buku, pengguna dapat melihat detail informasi mengenai buku apa saja yang sedang dipinjam, serta pengguna juga dapat menggunakan tombol untuk mengembalikan buku.

5. **Modul Reservasi LiteraHub** - Rena Martha Ulima

Pengguna dapat melakukan _reservasi_ tempat untuk baca buku secara _offline_. Pengguna akan mengisi _form_, seperti tanggal kunjungan, nomor anggota, judul buku yang dipinjam, dll. Pada bagian sini akan ditampilkan daftar tempat yang tersedia.

<br>

_Role_ atau peran pengguna beserta deskripsinya (karena bisa saja lebih dari satu jenis pengguna yang mengakses aplikasi)

- Pengguna tidak login

  Pengguna yang hanya mengunjungi aplikasi LiteraHub tanpa melakukan registrasi akun. Pengguna ini memiliki akses:

  - Dapat mengakses daftar buku
  - Dapat melihat rekomendasi buku

- Pengguna login

  Pengguna yang telah melakukan registrasi dan memiliki akun LiteraHub. Pengguna ini memiliki akses:

  - Dapat mengakses daftar buku
  - Dapat melihat rekomendasi buku
  - Dapat berdiskusi di forum
  - Dapat _reservasi_ kunjungan LiteraHub
  - Dapat menambahkan karyanya ke dalam LiteraHub
  - Dapat _checkout_/pinjam buku
  - Dapat mengisi dan menghapus review buku

Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester

### Modul LembarAsa:

POST: Input user berupa judul buku, gambar sampul, dan isi buku.

GET: Data dari database berisi keterangan buku yang sudah diunggah.

Hal yang perlu diimplementasikan:

- Halaman utama menampilkan buku milik user
- Form input judul buku, gambar sampul, dan isi buku karya user.
- Halaman buku buatan semua user
- Halaman detail isi buku jika buku ditekan

Data hasil input user akan dikirim ke aplikasi django dalam format json dan kalau berhasil akan mengirimkan sinyal HTTP 200. Data seluruh buku (model buku) karya user akan diambil dari aplikasi django dalam format json untuk kemudian dikirimkan ke mobile apps.

### Modul Forum:

POST: Input user berupa pembuatan thread baru dan isi post yang dibuat user. Jika berhasil dibuat, django akan mengirim sinyal HTTP Response 201.

GET: Data dari database berisi buku (cover dan judul), thread, dan post yang sudah ada. Jika berhasil, django akan mengirim sinyal HTTP Response 200.

Hal yang perlu diimplementasikan:

- Page untuk menunjukan thread.
- Page untuk menunjukan semua post dalam suatu thread (dengan form membuat postnya).
- Page/popup untuk membuat thread baru.

Data untuk forum dan buku diambil dari aplikasi yang sudah dibuat sebagai proyek tengah semester. Data akan diambil dalam bentuk JSON dari django ke aplikasi mobile, dan saat form pembuatan thread/post sukses dibuat, data baru akan dikirimkan ke aplikasi django.

### Modul Peminjaman Buku:

POST: Mengirim input formulir dari halaman peminjaman buku.

GET: Meminta data semua buku serta buku yang dipinjam dari website proyek tengah semester dalam bentuk JSON.


Hal yang perlu diimplementasikan:

- Page utama untuk menunjukkan fitur yang dapat diakses pada modul ini yaitu peminjaman dan pengembalian.
- Page peminjaman buku (Terdapat form untuk nama dan tanggal pengembalian).
- Page pengembalian buku.

Data dari formulir peminjaman buku akan diubah ke bentuk json terlebih dahulu, lalu akan dikirimkan ke database django. Jika berhasil akan dikirimkan sinyal HTTP 200. Terkait data untuk detail buku yang dipinjam akan didapat dengan mengambil dari website proyek tengah semester dalam format json untuk dikirimkan ke mobile apps.

### Modul Reservasi Tempat:

POST: Mengirimkan input user berupa nama, nomor ponsel, buku yang dipinjam, tanggal dan jam mulai, serta tempat yang direservasi.

GET: Meminta data dari database berupa buku dan tempat yang tersedia.

Hal yang perlu diimplementasikan:

- Form yang meminta input nama, nomor ponsel, buku yang dipinjam, tanggal dan jam mulai, serta tempat yang direservasi
- Page menampilkan buku yang tersedia di LiteraHub

Data buku dan tempat yang tersedia akan diambil dari django dalam format json untuk dikirimkan ke mobile apps. Data dari form yang berisi input user pada mobile apps akan diubah dalam format json dan dikirimkan ke aplikasi django. Jika berhasil, django akan mengirimkan sinyal HTTP 200.

### Modul Daftar Buku:

POST: Mengirim input formulir untuk review buku.

GET: Meminta data semua buku dari website proyek tengah semester dalam bentuk JSON.

Hal yang perlu diimplementasikan:

- Fitur search buku berdasarkan judul, penulis, dan tahun
- Tampilan mengenai buku-buku yang tersedia di LiteraHub
- Page add review buku
- Page menampilkan review buku

Data untuk detail dan review buku akan diambil dari django dalam format json untuk dikirimkan ke mobile apps. Selain itu, data dari form yang ada di mobile apps akan diubah dalam format json untuk dikirimkan ke database django dan apabila berhasil django akan mengirimkan sinyal HTTP 200.

**Menambahkan tautan berita acara ke README.md**
https://docs.google.com/spreadsheets/d/13aM5jSwt4QPegzKhCVhBAza9aQ1dyKUCtiHKymxtPuE/edit?hl=id#gid=0

### Panduan _Build_

#### __Flutter__ perlu diinstal untuk membangun dan menjalankan proyek:
- [Download Flutter untuk MacOS](https://docs.flutter.dev/get-started/install/macos) 

- [Download Flutter untuk Windows](https://docs.flutter.dev/get-started/install/windows)

- [Download Flutter untuk Linux](https://docs.flutter.dev/get-started/install/linux)

- [Download Android Studio untuk IDE (Recommended)](https://developer.android.com/studio)

- Pada _console window_ yang memiliki direktori Flutter di _path_-nya, jalankan perintah `flutter doctor` untuk melihat apakah ada dependensi platform yang diperlukan untuk menyelesaikan _setup_

Menggunakan IDE Android Studio direkomendasikan untuk mengembangkan proyek ini. Namun IDE lain seperti Visual Studio Code juga dapat digunakan.

#### Inisialisasi lokal

Untuk mendapatkan kode proyek ini, anda dapat _clone repository_ dengan menjalankan `git clone` pada direktori yang diinginkan. 

#### Menjalankan program secara lokal

Jika ingin menjalankan proyek secara lokal, jalankan perintah `flutter run` pada direktori proyek dan pilih tempat untuk menjalankan aplikasi (misalnya browser Windows, Chrome, dll.). Jika dijalankan di browser, aplikasi dapat diakses melalui localhost.