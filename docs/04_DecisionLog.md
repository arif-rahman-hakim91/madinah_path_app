# Decision Log

Status : Living Document

Semua keputusan penting dicatat di sini.

---

Decision 001

Dashboard tetap menggunakan Profil Anak.

Tidak diganti menjadi Guardian.

Alasan:

Dashboard selalu menampilkan anak yang sedang aktif.

---

Decision 002

Menu Profil akan berkembang menjadi Family.

Family menjadi pusat pengelolaan keluarga.

---

Decision 003

Family Foundation dikerjakan sebelum Target Hafalan.

Alasan:

Semua fitur berikutnya akan bergantung pada Child.

---

Decision 004

Arsitektur menggunakan Repository Pattern.

Screen tidak boleh langsung mengakses SQLite.

---

Decision 005

Dashboard hanya menampilkan data.

Semua perhitungan dilakukan di Service.

---

Decision 006

Target aplikasi adalah keluarga muslim.

Bukan aplikasi hafalan saja.

---

Decision 007

Project menggunakan Living Documentation.

Dokumen selalu diperbarui mengikuti perkembangan project.

---

Decision 008

Setiap milestone harus mengikuti urutan:

Model

↓

Database

↓

Repository

↓

Screen

↓

Save

↓

Load

↓

Dashboard Integration

↓

Testing

↓

Documentation

↓

Commit

↓

Release