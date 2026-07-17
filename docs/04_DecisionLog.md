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