# Anime Notes Pro

Anime Notes Pro adalah aplikasi pencatat catatan yang terinspirasi dari anime Re:Zero, dibangun dengan Flutter. Aplikasi ini memungkinkan pengguna untuk membuat, mengedit, dan menghapus catatan dengan antarmuka yang bersih dan intuitif, serta tema visual yang menarik.

## Fitur

- **Manajemen Catatan**: Buat, baca, perbarui, dan hapus catatan dengan mudah.
- **Tema Re:Zero**: Antarmuka pengguna yang disesuaikan dengan elemen visual dan audio dari anime Re:Zero.
- **Penyimpanan Lokal**: Menggunakan Hive untuk penyimpanan data lokal yang cepat dan efisien.
- **Splash Screen Kustom**: Splash screen yang menarik saat aplikasi dimulai.
- **Ikon Aplikasi Kustom**: Ikon aplikasi yang unik.
- **Font Kustom**: Menggunakan font `M PLUS 1p` untuk pengalaman membaca yang lebih baik.
- **CI/CD Otomatis**: Pipeline GitHub Actions untuk build dan pengujian otomatis.

## Struktur Proyek

```
anime_notes_pro/
├── .github/
│   └── workflows/
│       └── flutter_ci.yaml  # Konfigurasi CI/CD GitHub Actions
├── assets/
│   ├── animations/          # Placeholder untuk animasi Lottie (mis. ice_crystal_spinner.png)
│   ├── fonts/               # Font kustom (M PLUS 1p)
│   ├── icons/               # Ikon aplikasi dan karakter (Emilia, Rem, Ram, Beatrice)
│   └── sounds/              # File suara (mis. rem_voice.wav, emilia_voice.wav)
├── lib/
│   ├── main.dart            # Titik masuk aplikasi dan konfigurasi tema
│   ├── models/              # Model data Hive (note.dart, note.g.dart)
│   ├── screens/             # Layar aplikasi (note_list_screen.dart, note_detail_screen.dart)
│   └── services/            # Layanan aplikasi (hive_service.dart)
├── android/                 # Proyek Android
├── ios/                     # Proyek iOS
├── linux/                   # Proyek Linux
├── macos/                   # Proyek macOS
├── web/                     # Proyek Web
├── windows/                 # Proyek Windows
├── pubspec.yaml             # Definisi proyek dan dependensi
├── pubspec.lock             # Kunci dependensi
└── README.md                # Dokumentasi proyek
```

## Memulai

Ikuti langkah-langkah ini untuk menyiapkan dan menjalankan proyek secara lokal.

### Prasyarat

Pastikan Anda telah menginstal yang berikut ini:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) (opsional, tetapi direkomendasikan untuk pengembangan Android)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Instalasi

1.  **Kloning Repositori**: Kloning repositori ini ke mesin lokal Anda:
    ```bash
    git clone <URL_REPOSITORI_ANDA>
    cd anime_notes_pro
    ```

2.  **Instal Dependensi**: Dapatkan semua dependensi Flutter yang diperlukan:
    ```bash
    flutter pub get
    ```

3.  **Hasilkan File Hive Adapter**: Jalankan build_runner untuk menghasilkan file adapter Hive:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Hasilkan Splash Screen dan Ikon Peluncur**: Jika Anda mengubah konfigurasi splash screen atau ikon peluncur di `pubspec.yaml`:
    ```bash
    flutter pub run flutter_native_splash:create
    flutter pub run flutter_launcher_icons:main
    ```

### Menjalankan Aplikasi

Untuk menjalankan aplikasi di perangkat atau emulator yang terhubung:

```bash
flutter run
```

### Membangun Aplikasi

Untuk membangun APK rilis Android:

```bash
flutter build apk --release
```

APK yang dibangun akan ditemukan di `build/app/outputs/flutter-apk/app-release.apk`.

## CI/CD (GitHub Actions)

Proyek ini dilengkapi dengan alur kerja GitHub Actions yang dikonfigurasi untuk:

- Membangun aplikasi Flutter pada setiap push ke branch `master` atau `main`.
- Menjalankan pengujian unit.
- Menghasilkan APK rilis.
- Mengunggah APK yang dibangun sebagai artefak.

File konfigurasi alur kerja terletak di `.github/workflows/flutter_ci.yaml`.

## Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT. Lihat file `LICENSE` untuk detail lebih lanjut.

## Kontribusi

Kontribusi dipersilakan! Silakan buka masalah atau kirim permintaan pull.

---

