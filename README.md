# TUBES PBP - RUMAH SAKIT

## Anggota Kelompok / Kontributor

- **Gre**gorius Fuchen Taran Boro (NPM 210711074)
- Aloysius Gonzaga **Seto** Galih D. (NPM 210711180)
- **Reyhan** (NPM 210711212)
- Agustinus **Adit**ya Putra Pratama (NPM 210711429)

## Deskripsi Project

Membuat sebuah aplikasi Rumah Sakit sederhana yang berbasis Android. Project ini dikerjakan oleh Kelompok 1 pada mata kuliah Pemrograman Berbasis Platform (PBP) kelas B dengan menggunakan framework Flutter. Saat ini, aplikasi kami terdiri dari banyak fitur dan halaman yang memudahkan interaksi dengan pengguna. Beberapa fitur di antaranya adalah login, register, home, profil, tambah janji periksa, pesan kamar, cari dokter, akses lokasi, dan masih banyak lagi.

## API Repository
https://github.com/AloysiussG/PBP_B_1_Hospital_API.git

### UGD MODUL 1 & 2 (WIDGETS)

- Enhance Register Page : confirm alert dialog (Adit), date picker (Reyhan), radio button (Seto), checkbox (Adit), toggle password visibility (Reyhan)
- Enhance Login Page : toggle password visibility (Reyhan)
- Enhance Home Page : light/dark mode (Seto), apply expandable grid views (Gre)

### UGD MODUL 4 & 5 (BLOC)
- https://github.com/RInf0/ugd_bloc_1_b.git (different repository)

### UGD MODUL 6 & 7 (SQFLITE)

- Enhance Register Page : more validations (Seto, Reyhan, Adit), unique email (Reyhan), register using sqflite (Seto), snackbar (Adit, Reyhan), ui improvement (Seto)
- Enhance Login Page : login using sqflite (Seto), ui improvement (Seto)
- Enhance Home Page : ui improvement & grid icons (Seto), profile section & update profile (Adit), crud janji periksa dan daftar periksa (Seto, Reyhan, Gre)

### UGD MODUL HARDWARE

- Hardware camera untuk update foto profil di profile page, serta pilih dari gallery (Reyhan,Gre)
- Hardware camera untuk tambah dan update dokumen janji periksa, dapat pilih foto dari gallery, serta crop foto dokumen (Seto)
- Hardware speaker untuk fungsi text-to-speech yang menjelaskan detail janji periksa user (Seto)
- Hardware GPS untuk track jarak rumah sakit dengan lokasi user saat itu (Adit)

### UGD MODUL LIBRARY

- Responsive Sizer (Adit)
- PDF dan Printing, design ui pdf_view (Seto)
- Image Picker yang dimasukkan ke dalam pdf_view (Seto)
- INTL untuk tanggal create PDF, tanggal lahir, dan tanggal periksa pada pdf_view (Adit, Seto)
- Barcode QR berdasarkan UUID (Reyhan, Gre)
- UUID autogenerate untuk nomor antrian (Gre)

### UGD MODUL API

- a Login (Seto)
- b Register (Seto)
- c Tampil Profil (Seto)
- d Reset Password (Seto)
- e Update Profile (Reyhan, Seto)
- f CRUD Transaksi (Adit, Seto)

### UGD MODUL TESTING

- Widget Testing Login (Seto)
- Widget Testing Register (Gre, Seto, Reyhan, Adit)
- Widget Testing CRUD Janji Periksa (Seto)

### UAS / FINISHING TUBES
#### Front-End:
- Login Page: improve UI login page with Atma Hospital logo and slogan (Seto), implement isLoading logic with flutter spinkit widget (Seto)
- Reset/Forgot Password Page: improve UI reset password page (Seto), implement isLoading logic (Seto)
- Register Page: improve UI register page with Atma Hospital title (Seto)
- Home Page: improve UI main home page (Adit, Seto), improve grid menu button (Adit), carousel card (Adit, Reyhan)
- Daftar Periksa Page: improve UI daftar periksa page & card daftar periksa (Seto), apply isLoading logic (Seto)
- Detail Periksa Page: improve UI detail periksa (Gre, Seto)
- PDF View Page: improve auto-generated pdf design (Seto)
- Daftar Pesanan Kamar Page: add & improve UI daftar pesan kamar and card pesanan kamar (Seto), apply isLoading logic (Seto)
- Profile Page: improve UI profile page & implement network image to access stored profile photo in laravel storage link (Seto)
- Update Profile Page: slightly change accent color & implement network image to access stored profile photo (Seto)
- Input Janji Periksa Page: improve UI input (create & update) janji periksa page (Adit), slightly improve some minor design (Seto), implement dropdown list value from API data (Adit), apply isLoading logic awaiting dropdown daftar dokter (Seto)
- Cari Dokter Page: add UI cari dokter/daftar dokter page with dokter card containing 2 features: button 'lihat profil dokter' and button 'buat janji periksa by dokter' (Seto), apply isLoading logic (Seto)
- Lihat Profil Dokter Page: add profil dokter page (Seto)
- Buat/Tambah Janji Periksa By Dokter Page: add buat janji periksa by dokter page (Seto)
- Input Pesan Kamar Page: add & style pesan kamar page (Adit)
- Lokasi RS Page: add logic for 3 different hospital with 3 different distance (Adit), slightly improve ui (Seto)
- Kontak Page: add ui kontak kami page (Gre)
- Tentang Kami Page: add ui tentang kami page (Gre)
- Admin Page, accessible with login if there is any user with username 'admin' from DB: add admin page for CRUD Dokter (Seto) ***currently, main view of Admin Page is a read dokter page, containing some buttons to create dokter, read dokter, update dokter, and delete dokter
- Input Dokter in Admin Page: add input dokter page for create and update dokter (Seto), apply logic for random select dokter photo using modulo (Seto)

#### Back-End:
- Auth (Login & Register): add db seeder for 1 user and 1 user admin (Seto)
- Profile: implement laravel storage link for storing profile photos (send base64 in json, save as image in storage link), better reliability compared to sending/getting image as original base64 (Seto), bug fix in update profile (Seto)
- Janji Periksa (Transaksi 1): finish Janji Periksa API (Adit), implement laravel storage link for better storing document image (send base64 in json, save as image in storage link) (Seto), adding new required attribute in entity/model Janji Periksa (Adit), some bug fix (Seto)
- Pesan Kamar (Transaksi 2): add CRUD Pesan Kamar API (Adit), add Pesan Kamar entity and client (Adit), bug fix read update and delete API (Seto)
- Dokter (CRUD 3): add CRUD Dokter API (Adit), add Dokter client (Seto), add db seeder (Seto)

