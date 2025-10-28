# E-Commerce App - "Aepp"

"Aepp" adalah sebuah purwarupa (prototype) aplikasi *mobile* e-commerce *single-vendor* yang fungsional. Proyek ini dibangun menggunakan **Flutter** dengan fokus pada implementasi arsitektur **MVVM (Model-View-ViewModel)** yang bersih dan skalabel, serta memanfaatkan *framework* **GetX** untuk *state management* dan *routing*.

Aplikasi ini dirancang dengan antarmuka yang modern, minimalis, dan berfokus pada *brand* (*brand-centric*), serta mengambil data produk secara *live* dari REST API.

## 📸 Tangkapan Layar (Screenshot)

| Halaman Utama | Daftar Produk (Kategori) | Detail Produk |
| :---: | :---: | :---: |
|  |  |  |

## ✨ Fitur Utama

* **UI Modern & Brand-Centric:** Desain yang bersih dan minimalis yang menonjolkan identitas *brand*.
* **Data Dinamis:** Mengambil dan menampilkan data produk secara *real-time* dari [DummyJSON REST API](https://dummyjson.com/).
* **Arsitektur MVVM:** Pemisahan tanggung jawab yang jelas antara *View* (UI), *ViewModel* (Logika & State), dan *Model* (Data & Repositori).
* **Navigasi Bersarang (Nested Routing):** Implementasi `BottomNavigationBar` yang persisten (tidak *reload* saat pindah halaman) menggunakan `GetRouterOutlet` dari GetX.
* **Manajemen Tema Terpusat:** Penggunaan `ThemeData` di `main.dart` untuk konsistensi UI global (warna, font, tombol, dll.).
* **UI Reaktif:** Layar secara otomatis diperbarui berdasarkan *state* (misalnya, menampilkan `CircularProgressIndicator` saat `isLoading` bernilai *true*).

### Alur yang Diimplementasikan:
1.  **Halaman Utama:** Menampilkan *header brand*, *search bar*, pintasan "Top Deals" & "Best Seller", daftar Kategori, dan *grid* produk umum.
2.  **Halaman Daftar Produk:** Menampilkan produk yang telah difilter berdasarkan Kategori yang dipilih dari Halaman Utama.
3.  **Halaman Detail Produk:** Menampilkan informasi rinci, gambar, dan deskripsi produk, beserta tombol "Add to Cart" dengan *feedback* `Snackbar`.

## 🚀 Teknologi & Arsitektur

* **Framework:** Flutter
* **State Management & Routing:** GetX
    * **State Management:** Menggunakan `GetxController` (sebagai ViewModel) dan `.obs` untuk variabel reaktif.
    * **Routing:** Menggunakan `GetPage` dan `GetRouterOutlet` untuk *nested navigation* yang terpusat.
    * **Dependency Injection:** Menggunakan `Bindings` (misal: `HomeBinding`) untuk menyuntikkan (`inject`) *Repository* ke *ViewModel*.
* **Arsitektur:** MVVM (Model-View-ViewModel)
    * **Model:** `ProductModel` (struktur data) dan `ProductRepository` (logika pengambilan data dari API).
    * **View:** *Widget* layar (misal: `Home`, `AboutScreen`) yang hanya bertugas menampilkan UI dan meneruskan *event* ke ViewModel.
    * **ViewModel:** *Class* `GetxController` (misal: `HomeViewModel`) yang menampung semua *state* dan logika bisnis.
* **API Client:** `http` *package* untuk melakukan panggilan REST API.
* **Fonts:** `google_fonts` (menggunakan *font* "Inter").

## 📂 Struktur Folder

Proyek ini diorganisir menggunakan struktur folder yang berorientasi pada fitur dan arsitektur MVVM:
