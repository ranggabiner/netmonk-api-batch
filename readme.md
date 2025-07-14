# ⚡ Netmonk API Test Runner (Windows Edition)

Script interaktif buat ngejalanin **automated API tests** dari Postman collection via [Newman](https://www.npmjs.com/package/newman) — lengkap sama UI CLI selector pakai [`fzf`](https://github.com/junegunn/fzf), dan report HTML kece via [`htmlextra`](https://www.npmjs.com/package/newman-reporter-htmlextra).

---

## 📦 Features

- ✅ Pilih collection (HI / PRIME / PORTAL) via UI interaktif
- 📊 Report HTML otomatis disimpan ke folder lokal
- 🎨 UI interaktif pakai `fzf` versi Windows
- 🔐 API key dan ID Postman dipisah di file `.env`
- 🌐 Bisa langsung buka report di browser (Windows default)

---

## 🛠️ Installation (Windows)

### 0. Install Chocolatey (jika belum punya)

Chocolatey itu package manager buat Windows (kayak `brew` di macOS).

1. Buka **Command Prompt as Administrator**
2. Copy-paste perintah ini:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; ^
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

3. Tutup terminal dan buka ulang.

---

### 1. Install `fzf` (buat UI pilihan)

```powershell
choco install fzf
```

> Alternatif lain: [Download `fzf.exe` manual](https://github.com/junegunn/fzf/releases) lalu taruh ke folder yang ada di `PATH`

---

### 2. Install Node.js dan npm (jika belum ada)

Download dari: [https://nodejs.org](https://nodejs.org)
Install versi **LTS (Long-Term Support)** biar stabil

---

### 3. Install `newman` dan `htmlextra`

```bash
npm install -g newman
npm install -g newman-reporter-htmlextra
```

---

## ⚙️ Setup Environment Variables

Bikin file `config.env` di root project lo:

```env
# config.env

POSTMAN_API_KEY="ISI_PAKAI_API_KEY_LO"

HI_COLLECTION_ID="COLLECTION_ID_HI"
PRIME_COLLECTION_ID="COLLECTION_ID_PRIME"
PORTAL_COLLECTION_ID="COLLECTION_ID_PORTAL"

HI_ENVIRONMENT_ID="ENV_ID_HI"
PRIME_ENVIRONMENT_ID="ENV_ID_PRIME"
PORTAL_ENVIRONMENT_ID="ENV_ID_PORTAL"
```

---

## 📁 Folder Structure

```
📦 netmonk-api-batch/
├── 🟦 netmonk_api.bat         # script utama (Windows version)
├── 🟡 config.env              # file environment config (jangan di-commit!)
├── 📄 README.md               # dokumentasi kece ini
```

📝 **Note:**

- `config.env` harus valid (tanpa spasi aneh, tanpa kutip miring/kacau)
- File ini _jangan di-push ke GitHub_, karena berisi data sensitif 🛡️

---

## 🚀 How to Run

### 1. Buka Command Prompt / Git Bash

```bash
cd /path/tempat/lo/naruh/netmonk-api-batch
```

### 2. Jalankan script

```bash
netmonk_api.bat
```

Script akan munculin pilihan `fzf` seperti:

```
PRIME
HI
PORTAL
```

Pilih aja pakai arrow key ↕️ lalu ENTER.

---

## 📂 Report Output

📁 Report akan disimpan otomatis ke:

```
C:\Users\<USERNAME>\Documents\postman_newman
```

📝 Format nama file:

```
[REPORT_NAME]_Report_YYYY-MM-DD_HH-MM-SS.html
```

🧭 Setelah test selesai:

- ✅ YA → langsung buka di browser
- ❌ TIDAK → disimpan aja dulu

---

## 🧪 Contoh Use Case

Lo bisa pakai ini buat:

- Regression test semua Postman Collection
- Bikin laporan QA mingguan otomatis
- Ngetes banyak API pakai UI yang cepet & friendly

---

## ⚡ Tips Tambahan

- Kalau `fzf` gak muncul, cek apakah `fzf.exe` udah ada di `PATH`
- Jalanin script dari Git Bash kalau pengen feel-nya kayak Linux/macOS
- Bisa di-automate via task scheduler juga 😎

---

## 👨‍💻 Author

Made with 💙 by [Rangga Hadi Putra](https://ranggabiner.com)
`Cc Netmonk 2025` | ⚙️ QA Engineer
