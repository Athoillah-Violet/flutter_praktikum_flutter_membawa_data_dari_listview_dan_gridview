# PROMPT UNTUK ANTIGRAVITY

(Salin semua isi di bawah garis ini ke Antigravity)

---

Kamu adalah asisten pemrograman Flutter. Tugasmu: membuat aplikasi katalog produk di proyek Flutter yang sudah ada, dengan membuat/mengisi file Dart sesuai instruksi di bawah.

## 1. Baca konteks dulu
Buka dan baca file `contoh program yang akan di buat.pdf` di folder proyek. Itu adalah materi praktikum (Pemrograman Aplikasi Mobile, Flutter) yang menjadi acuan struktur aplikasi: satu sumber data produk, ditampilkan dalam ListView (daftar) dan GridView (galeri dua kolom), lalu halaman detail produk, dan tombol "Tambah ke Keranjang" dengan SnackBar. Tema produk pada versi ini adalah **laptop dan aksesorisnya**.

## 2. Aturan penting
- Gunakan kode **persis seperti yang kutulis di bawah**. Jangan mengubah nama class, nama fungsi, struktur widget, atau gaya penulisan. Jangan menambah fitur, package, atau refactor.
- Jangan menambah package baru dan jangan mengubah `pubspec.yaml`. Gambar memakai `Image.network` (dari internet), jadi **tidak ada asset lokal**.
- Hanya ada **2 file** yang dibuat/diisi: `lib/main.dart` dan `lib/katalog.dart`. Class `Katalog` dan `DetailProduk` **harus berada dalam satu file** (`katalog.dart`), karena `DetailProduk` memanggil `Katalog._gambar(...)` yang bersifat private.
- Nilai `'gambar'` pada data produk sengaja masih placeholder (`https://example.com/GANTI_URL_x.png`). Biarkan apa adanya. Aku akan menggantinya sendiri nanti. Aplikasi tetap harus bisa dijalankan; gambar yang gagal akan menampilkan ikon pengganti lewat `errorBuilder`.

## 3. Langkah kerja
1. Ganti seluruh isi `lib/main.dart` dengan kode pada bagian 4.
2. Buat file baru `lib/katalog.dart` dengan kode pada bagian 5.
3. Pastikan izin INTERNET ada di `android/app/src/main/AndroidManifest.xml`. Jika belum ada, tambahkan baris `<uses-permission android:name="android.permission.INTERNET"/>` tepat di atas tag `<application ...>`. Jangan mengubah bagian lain pada file itu.
4. Jika ada file `test/widget_test.dart` bawaan yang merujuk ke `MyApp` sehingga menimbulkan error, hapus file itu.
5. Jalankan `flutter pub get` lalu `flutter analyze`. Pastikan tidak ada error. Jika ada error, perbaiki seminimal mungkin tanpa mengubah struktur kode.
6. Jika memungkinkan, jalankan aplikasi di emulator Android dengan `flutter run`.
7. Setelah selesai, beri laporan singkat: file apa saja yang dibuat/diubah, dan hasil `flutter analyze`.

## 4. Isi `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'katalog.dart';

void main() {
  runApp(const MaterialApp(
    home: Katalog(),
  ));
}
```

## 5. Isi `lib/katalog.dart`

```dart
import 'package:flutter/material.dart';

class Katalog extends StatelessWidget {
  const Katalog({super.key});

  // Data produk (gambar diambil dari internet)
  static const List<Map<String, String>> items = [
    {
      'nama': 'ASUS Vivobook 14',
      'kategori': 'Laptop',
      'harga': 'Rp 7.500.000',
      'gambar': 'https://example.com/GANTI_URL_1.png',
      'deskripsi': 'Laptop tipis dan ringan, cocok untuk kuliah dan kerja harian.',
    },
    {
      'nama': 'Acer Nitro 5',
      'kategori': 'Gaming',
      'harga': 'Rp 13.999.000',
      'gambar': 'https://example.com/GANTI_URL_2.png',
      'deskripsi': 'Laptop gaming bertenaga dengan kartu grafis dedicated.',
    },
    {
      'nama': 'Lenovo ThinkPad E14',
      'kategori': 'Laptop',
      'harga': 'Rp 9.800.000',
      'gambar': 'https://example.com/GANTI_URL_3.png',
      'deskripsi': 'Laptop bisnis dengan bodi kokoh dan keyboard yang nyaman.',
    },
    {
      'nama': 'Mouse Wireless',
      'kategori': 'Aksesoris',
      'harga': 'Rp 150.000',
      'gambar': 'https://example.com/GANTI_URL_4.png',
      'deskripsi': 'Mouse nirkabel ergonomis, koneksi stabil dan baterai awet.',
    },
    {
      'nama': 'Keyboard Mechanical',
      'kategori': 'Aksesoris',
      'harga': 'Rp 450.000',
      'gambar': 'https://example.com/GANTI_URL_5.png',
      'deskripsi': 'Keyboard mechanical dengan switch responsif untuk mengetik dan gaming.',
    },
    {
      'nama': 'Tas Ransel Laptop',
      'kategori': 'Aksesoris',
      'harga': 'Rp 350.000',
      'gambar': 'https://example.com/GANTI_URL_6.png',
      'deskripsi': 'Tas ransel muat laptop hingga 15 inci, cocok untuk kuliah dan kerja.',
    },
  ];

  // Widget judul untuk tiap bagian
  Widget _judul(String teks, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          Icon(ikon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            teks,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Gambar produk dari internet, dengan loading dan cadangan jika gagal
  static Widget _gambar(String url, {double? size}) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: size,
          height: size,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stack) => SizedBox(
        width: size,
        height: size,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Katalog Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Setengah atas: judul + ListView vertikal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _judul('Daftar Produk', Icons.list),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => _bukaDetail(context, item),
                          contentPadding: const EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _gambar(item['gambar']!, size: 60),
                          ),
                          title: Text(
                            item['nama']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['deskripsi']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['harga']!,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: Chip(
                            label: Text(
                              item['kategori']!,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Colors.blue[50],
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Setengah bawah: judul + GridView
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _judul('Galeri Produk', Icons.grid_view),
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => _bukaDetail(context, item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(8),
                                  child: _gambar(item['gambar']!),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['nama']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item['deskripsi']!,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['harga']!,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Pindah ke halaman detail sambil membawa data produk yang diklik
  void _bukaDetail(BuildContext context, Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProduk(produk: item)),
    );
  }
}

// Halaman detail produk (menerima data dari halaman Katalog)
class DetailProduk extends StatelessWidget {
  final Map<String, String> produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          produk['nama']!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // Gambar besar
          Container(
            color: Colors.white,
            height: 300,
            padding: const EdgeInsets.all(24),
            child: Katalog._gambar(produk['gambar']!),
          ),
          // Informasi produk
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(produk['kategori']!),
                  backgroundColor: Colors.blue[50],
                ),
                const SizedBox(height: 8),
                Text(
                  produk['nama']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['harga']!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 32),
                const Text(
                  'Deskripsi Produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  produk['deskripsi']!,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
      // Tombol beli di bagian bawah
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke Keranjang'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${produk['nama']} ditambahkan ke keranjang'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

## 6. Yang diharapkan setelah selesai
- Layar utama "Katalog Produk" menampilkan **Daftar Produk** (ListView) di setengah atas dan **Galeri Produk** (GridView 2 kolom) di setengah bawah, masing-masing 6 produk.
- Mengetuk produk dari daftar maupun galeri membuka halaman `DetailProduk` berisi gambar, kategori, nama, harga, dan deskripsi.
- Tombol "Tambah ke Keranjang" memunculkan SnackBar "<nama produk> ditambahkan ke keranjang".
- Selama URL gambar masih placeholder, gambar menampilkan ikon `image_not_supported`. Itu normal dan akan hilang setelah URL diganti.
