# Panduan Deployment ke Vercel

Project Flutter Pokémon ini sudah dikonfigurasi sepenuhnya agar dapat di-deploy ke **Vercel**.

---

## Konfigurasi yang Ditambahkan

1. **`vercel.json`**:
   - Menetapkan direktori output ke `build/web`.
   - Mengarahkan perintah build otomatis ke `bash vercel-build.sh`.
   - Menambahkan routing rewrites `/(.*)` ke `/index.html` agar tidak terjadi error 404 saat navigasi atau refresh halaman.
   - Menambahkan header caching untuk performa dan keamanan.

2. **`vercel-build.sh`**:
   - Script otomatis untuk environment Linux di Vercel: mengunduh Flutter SDK stable, menjalankan `flutter config --enable-web`, `flutter pub get`, dan `flutter build web --release`.

3. **`package.json`**:
   - Memberitahu Vercel bahwa project memiliki script build (`npm run build`).

4. **`web/index.html` & `web/manifest.json`**:
   - Memperbarui title menjadi `Pokemon Go - Pokédex`, meta deskripsi, dan tema warna `#376B4D`.

---

## Cara Deploy ke Vercel

### Metode 1: Hubungkan ke GitHub (Otomatis & Direkomendasikan)

1. Push project ini ke repository GitHub Anda:
   ```bash
   git add .
   git commit -m "Configure project for Vercel deployment"
   git push origin main
   ```
2. Buka dashboard [Vercel](https://vercel.com).
3. Klik **"Add New..."** -> **"Project"**.
4. Pilih repository GitHub project Pokémon Anda.
5. Pada bagian **Build and Output Settings**:
   - **Framework Preset**: biarkan **Other**.
   - Pengaturan lainnya akan otomatis membaca konfigurasi dari `vercel.json` (`outputDirectory: build/web` dan `buildCommand: bash vercel-build.sh`).
6. Klik **Deploy**.
7. Vercel akan otomatis meng-compile dan menerbitkan website Anda dengan domain `*.vercel.app`.

---

### Metode 2: Deploy Cepat via Vercel CLI (Lokal)

Jika Anda sudah menginstal Node.js dan Vercel CLI:

1. Install Vercel CLI (jika belum):
   ```bash
   npm i -g vercel
   ```
2. Build web secara lokal:
   ```bash
   flutter build web --release
   ```
3. Deploy ke Vercel:
   ```bash
   vercel deploy --prebuilt --prod
   ```
   *Atau langsung dari folder build:*
   ```bash
   cd build/web
   vercel --prod
   ```
