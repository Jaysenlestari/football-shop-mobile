# football_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---
## Tugas Individu 7
1.  Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.   
Widget tree adalah struktur hierarki dari semua widget dalam aplikasi Flutter.
Setiap tampilan di layar tersusun dari widget induk (parent) yang berisi widget anak (child) — membentuk seperti “pohon” (tree).

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.   
    - MaterialApp: Widget root aplikasi, menyediakan tema, routing, dan integrasi Material Design.
    - Scaffold: Menyediakan struktur dasar halaman: AppBar, body, dan layout utama.
    - AppBar: Bagian atas halaman yang berisi judul atau aksi.
    - Padding: Memberi jarak di sekitar child widget.
    - Column: Menyusun widget anak secara vertikal.
    - Row: Menyusun widget anak secara horizontal.
    - Card: Tampilan kotak dengan bayangan (elevation).
    - Container: Pembungkus widget lain untuk mengatur ukuran, padding, dan warna.
    - Text: Menampilkan teks.
    - Icon: Menampilkan ikon bawaan Flutter.
    - GridView: Menampilkan daftar widget dalam bentuk grid (kotak-kotak).
    - InkWell: Memberikan efek interaktif (klik, ripple effect).
    - SnackBar: Menampilkan pesan singkat di bagian bawah layar.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root   
MaterialApp adalah widget paling atas (root) yang menyediakan: Material Design theme (warna, font, ikon standar), Navigasi & routing antar halaman, Localization (dukungan bahasa), Debug banner dan konfigurasi global aplikasi.
Biasanya digunakan sebagai root karena semua komponen seperti Scaffold, AppBar, dan SnackBar memerlukan context dari MaterialApp agar bisa menampilkan elemen Material Design dengan benar. [source](https://api.flutter.dev/flutter/material/MaterialApp-class.html)

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?   
Stateless widget seperti namanya merupakan widget yang bersifat statis atau tidak akan berubah selama aplikasi berjalan. Biasanya, widget ini digunakan pada bagian-bagian aplikasi yang memang tidak akan berubah atau tidak memerlukan interaksi dari pengguna. Sedangkan, stateful widget adalah widget yang bersifat interaktif dan dapat berubah selama aplikasi berjalan. Widget ini memberikan respon terhadap interaksi yang dilakukan oleh pengguna.   

   Secara umum, perbedaan utamanya terletak pada fleksibilitas kedua widget, di mana stateless tidak dapat diubah ketika aplikasi sudah berjalan, sedangkan stateful dapat berubah sesuai dengan interaksi bersama pengguna.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?   
BuildContext adalah objek yang merepresentasikan posisi widget dalam widget tree.
Objek ini digunakan untuk:
    - Mengakses theme, navigator, media query, dan ScaffoldMessenger.
    - Menentukan di mana sebuah widget berada.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".   
Fitur hot reload digunakan untuk memperbarui tampilan aplikasi secara cepat tanpa harus memulai ulang seluruh proses aplikasi. Ketika kamu melakukan hot reload, Flutter hanya memuat ulang kode yang berubah dan menerapkannya langsung pada widget yang sedang berjalan. Dengan begitu, state atau data yang sedang aktif—misalnya isi dari TextField atau variabel yang disimpan di StatefulWidget—akan tetap dipertahankan. Fitur ini sangat berguna saat kamu ingin melihat hasil perubahan UI (seperti warna, teks, atau layout) secara instan tanpa kehilangan kondisi aplikasi.

    Sementara itu, hot restart benar-benar memulai ulang aplikasi dari awal. Semua variabel, state, dan data sementara akan direset seperti saat pertama kali aplikasi dijalankan. Flutter akan memuat ulang seluruh kode dan membangun ulang widget tree dari nol. Karena prosesnya lebih besar, hot restart biasanya memakan waktu sedikit lebih lama dibanding hot reload. Fitur ini digunakan ketika kamu melakukan perubahan besar yang memengaruhi struktur state atau inisialisasi variabel global yang tidak bisa diperbarui dengan hot reload saja.
    