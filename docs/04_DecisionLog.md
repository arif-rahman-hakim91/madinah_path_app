# Decision Log

Project : Madinah Path

---

## Decision 001

Menggunakan SQLite sebagai database lokal.

Status

Accepted

---

## Decision 002

Menggunakan Repository Pattern agar UI tidak langsung mengakses database.

Status

Accepted

---

## Decision 003

Setiap Child memiliki data sendiri.

Relasi

Guardian

↓

Child

↓

Semua data perkembangan

Alasan

Dashboard harus berubah ketika Child aktif berganti.

Status

Accepted

---

## Decision 004

Menggunakan CurrentChildService.

Tujuan

Menyimpan Child yang sedang aktif.

Seluruh Screen mengambil Child dari CurrentChildService.

Status

Accepted

---

## Decision 005

Seluruh data perkembangan wajib mempunyai childId.

Modul

- Hafalan
- Ibadah
- Target Ibadah
- Education
- Reward
- Achievement

Alasan

Satu aplikasi digunakan oleh beberapa anak.

Status

Accepted

---

## Decision 006

HomeScreen tidak dibongkar.

Dashboard akan ditingkatkan sedikit demi sedikit agar tidak merusak lebih dari 700 baris kode.

Status

Accepted

---

## Decision 007

Setiap milestone besar wajib memiliki Git Checkpoint.

Contoh

Checkpoint 1

Checkpoint 2

Checkpoint 3

dst.

Tujuan

Jika terjadi kesalahan besar dapat kembali ke kondisi stabil.

Status

Accepted

---

## Decision 008

Setiap selesai milestone, seluruh dokumentasi diperbarui.

Dokumen

01_Vision.md

02_Architecture.md

03_Roadmap.md

04_DecisionLog.md

Tujuan

Agar project dapat dilanjutkan di chat baru tanpa kehilangan konteks.

Status

Accepted

## Decision 009

Dashboard tidak boleh mengambil data langsung dari Repository.

Semua data Dashboard harus melalui DashboardService.

Tujuan

- HomeScreen tetap sederhana.
- Logika bisnis berada di Service.
- Mudah dikembangkan ketika Dashboard bertambah kompleks.

Status

Accepted# Decision Log

Project : Madinah Path

---

## Decision 001

### SQLite Database

Menggunakan SQLite sebagai database lokal aplikasi.

Alasan

- Tidak membutuhkan koneksi internet.
- Cepat.
- Cocok untuk aplikasi Android offline.

Status

✅ Accepted

---

## Decision 002

### Repository Pattern

UI tidak boleh mengakses database secara langsung.

Semua operasi database harus melalui Repository.

Alasan

- Memisahkan UI dan Database.
- Memudahkan testing.
- Memudahkan maintenance.

Status

✅ Accepted

---

## Decision 003

### Child Ownership

Setiap Child memiliki seluruh data perkembangannya sendiri.

Relasi

Guardian

↓

Child

├── Hafalan

├── Ibadah

├── Target Ibadah

└── Education

Alasan

Dashboard harus berubah ketika Child aktif berganti.

Status

✅ Accepted

---

## Decision 004

### CurrentChildService

Menggunakan CurrentChildService sebagai penyimpan Child yang sedang aktif.

Seluruh Screen mengambil Child aktif dari service ini.

Alasan

Menghindari pengiriman childId melalui setiap halaman.

Status

✅ Accepted

---

## Decision 005

### childId Relation

Seluruh data perkembangan wajib memiliki childId.

Modul

- Hafalan
- Ibadah
- Target Ibadah
- Education
- Reward
- Achievement

Alasan

Satu aplikasi digunakan oleh beberapa anak.

Status

✅ Accepted

---

## Decision 006

### HomeScreen Stability

HomeScreen tidak dibongkar secara besar-besaran.

Perubahan dilakukan sedikit demi sedikit.

Alasan

HomeScreen sudah cukup besar sehingga refactor besar berisiko menimbulkan banyak bug.

Status

✅ Accepted

---

## Decision 007

### Git Checkpoint

Setiap milestone besar wajib memiliki Git Checkpoint.

Contoh

- Checkpoint 1
- Checkpoint 2
- Checkpoint 3
- dan seterusnya.

Alasan

Jika terjadi kesalahan besar dapat kembali ke kondisi stabil.

Status

✅ Accepted

---

## Decision 008

### Documentation

Setiap selesai milestone seluruh dokumentasi wajib diperbarui.

Dokumen

- 01_Vision.md
- 02_Architecture.md
- 03_Roadmap.md
- 04_Decision.md

Alasan

Project dapat dilanjutkan pada chat baru tanpa kehilangan konteks.

Status

✅ Accepted

---

## Decision 009

### Dashboard Service

Dashboard tidak boleh mengambil data langsung dari Repository.

Semua data Dashboard harus melalui DashboardService.

Alasan

- HomeScreen tetap sederhana.
- Logika bisnis berada di Service.
- Dashboard mudah dikembangkan.

Status

✅ Accepted

---

## Decision 010

### DateService

Seluruh fitur yang menggunakan tanggal harus melalui DateService.

Contoh

- Dashboard
- Weekly Progress
- Monthly Progress
- Education History
- Achievement

Alasan

- Menghindari penggunaan DateTime.now() di banyak file.
- Memusatkan logika tanggal.
- Memudahkan pengembangan fitur berbasis waktu.

Status

✅ Accepted