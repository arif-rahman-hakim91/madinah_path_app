# Architecture

Version : Living Document

---

# High Level Architecture

UI (Screen)

↓

Service

↓

Repository

↓

SQLite

---

# Folder Structure

lib/

database/

models/

repositories/

services/

screens/

widgets/

core/

---

# Development Pattern

Model

↓

Repository

↓

Service (optional)

↓

Screen

↓

Dashboard Integration

---

# Current Modules

Foundation

Dashboard

Hafalan

Ibadah

Target Ibadah

Guardian (On Progress)

Family (Planning)

Child (Planning)

Reward (Planning)

Education (Planning)

---

# Database Philosophy

Semua data berasal dari SQLite.

Screen tidak boleh langsung mengakses database.

Screen

↓

Repository

↓

Database

---

# Family Architecture

Family

├── Guardian

└── Children

      ├── Hafalan

      ├── Ibadah

      ├── Target

      ├── Reward

      ├── Education History

      └── Dashboard

---

# Dashboard

Dashboard hanya menampilkan data.

Semua proses perhitungan dilakukan di Service.

Screen tidak melakukan logika bisnis.

---

# Future Architecture

SQLite

↓

Cloud Sync

↓

Backup

↓

Restore

↓

Multi Device