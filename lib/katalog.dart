import 'package:flutter/material.dart';

import 'about_page.dart';

class Katalog extends StatefulWidget {
  const Katalog({super.key});

  // Warna utama aplikasi (cukup ubah di sini untuk mengganti tema)
  static const MaterialColor warnaUtama = Colors.deepPurple;

  // Data produk (gambar diambil dari internet)
  static const List<Map<String, String>> items = [
    {
      'nama': 'ASUS Vivobook 14',
      'kategori': 'Laptop',
      'harga': 'Rp 7.500.000',
      'rating': '4.5',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2025/05/15/asus-vivobook-s14-s3407qa-1747296614666.jpeg?w=800',
      'deskripsi':
          'Laptop tipis dan ringan, cocok untuk kuliah dan kerja harian.',
    },
    {
      'nama': 'Acer Nitro 5',
      'kategori': 'Gaming',
      'harga': 'Rp 13.999.000',
      'rating': '4.7',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2024/09/05/laptop-gaming-acer-nitro-1_43.jpeg?w=480',
      'deskripsi': 'Laptop gaming bertenaga dengan kartu grafis dedicated.',
    },
    {
      'nama': 'Lenovo ThinkPad E14',
      'kategori': 'Laptop',
      'harga': 'Rp 9.800.000',
      'rating': '4.6',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2020/11/27/lenovo-thinkpad-e14-gen-2.jpeg?w=1200',
      'deskripsi': 'Laptop bisnis dengan bodi kokoh dan keyboard yang nyaman.',
    },
    {
      'nama': 'Mouse Wireless',
      'kategori': 'Aksesoris',
      'harga': 'Rp 150.000',
      'rating': '4.4',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2021/05/09/logitech-mx-master-3-4_169.mpo?w=1200',
      'deskripsi': 'Mouse nirkabel ergonomis, koneksi stabil dan baterai awet.',
    },
    {
      'nama': 'Keyboard Mechanical',
      'kategori': 'Aksesoris',
      'harga': 'Rp 450.000',
      'rating': '4.8',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2022/06/06/review-logitech-g413-tkl-se-cocok-buat-main-game-dan-kerja-kantoran-5_169.jpeg?w=650',
      'deskripsi': 'Keyboard mechanical dengan switch responsif untuk mengetik dan gaming.',
    },
    {
      'nama': 'Tas Ransel Laptop',
      'kategori': 'Aksesoris',
      'harga': 'Rp 350.000',
      'rating': '4.3',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2021/05/14/polo-trands-1.jpeg?w=1280',
      'deskripsi': 'Tas ransel muat laptop hingga 15 inci, cocok untuk kuliah dan kerja.',
    },
    {
      'nama': 'ASUS ROG Strix G16',
      'kategori': 'Gaming',
      'harga': 'Rp 24.500.000',
      'rating': '4.8',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2026/09/30/asus-1790757609033.jpeg?w=800',
      'deskripsi':
          'Laptop gaming kelas atas dengan layar 16 inci refresh rate tinggi.',
    },
    {
      'nama': 'Headset Gaming',
      'kategori': 'Aksesoris',
      'harga': 'Rp 399.000',
      'rating': '4.2',
      'gambar': 'https://awsimages.detik.net.id/community/media/visual/2021/11/06/fantech-wh01-wireless-headphone-5.png?w=600&q=90',
      'deskripsi': 'Headset dengan mikrofon jernih dan bantalan telinga empuk.',
    },
    {
      'nama': 'Hardisk Eksternal 1TB',
      'kategori': 'Aksesoris',
      'harga': 'Rp 850.000',
      'rating': '4.6',
      'gambar': 'https://upload.wikimedia.org/wikipedia/commons/9/91/Toshiba_1_TB_External_USB_Hard_Drive.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original',
      'deskripsi': 'Penyimpanan portable USB 3.0, cepat dan ringkas.',
    },
  ];

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
  State<Katalog> createState() => _KatalogState();
}

class _KatalogState extends State<Katalog> {
  // Menyimpan nama produk yang ditandai favorit
  final Set<String> _favorit = {};

  // Widget judul untuk tiap bagian
  Widget _judul(String teks, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          Icon(ikon, color: Katalog.warnaUtama),
          const SizedBox(width: 8),
          Text(
            teks,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Tambah atau hapus favorit, lalu tampilkan SnackBar
  void _ubahFavorit(String nama) {
    final sudahFavorit = _favorit.contains(nama);
    setState(() {
      if (sudahFavorit) {
        _favorit.remove(nama);
      } else {
        _favorit.add(nama);
      }
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          sudahFavorit
              ? '$nama dihapus dari favorit'
              : '$nama ditambahkan ke favorit',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Katalog.items;

    // GridView responsif: 3 kolom pada layar lebar, 2 kolom pada ponsel
    final lebar = MediaQuery.of(context).size.width;
    final jumlahKolom = lebar >= 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Katalog Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Katalog.warnaUtama,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'home',
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.deepPurple),
                    SizedBox(width: 12),
                    Text('Beranda'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.deepPurple),
                    SizedBox(width: 12),
                    Text('Tentang Aplikasi'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.deepPurple),
                    SizedBox(width: 12),
                    Text('Pengaturan'),
                  ],
                ),
              ),
            ],
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
                            child: Katalog._gambar(item['gambar']!, size: 60),
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
                              Row(
                                children: [
                                  Text(
                                    item['harga']!,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    item['rating']!,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Chip(
                            label: Text(
                              item['kategori']!,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Katalog.warnaUtama[50],
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
                    crossAxisCount: jumlahKolom,
                    childAspectRatio: 0.85,
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      final sudahFavorit = _favorit.contains(item['nama']);
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
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(8),
                                        child: Katalog._gambar(item['gambar']!),
                                      ),
                                    ),
                                    // Tombol favorit di pojok kanan atas
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () =>
                                            _ubahFavorit(item['nama']!),
                                        icon: Icon(
                                          sudahFavorit
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: sudahFavorit
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['harga']!,
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              item['rating']!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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

  // Menampilkan rating dalam bentuk bintang (penuh, setengah, kosong)
  Widget _bintang(double rating) {
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (rating >= i + 1) {
            return const Icon(Icons.star, color: Colors.amber, size: 20);
          }
          if (rating >= i + 0.5) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 20);
          }
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }),
        const SizedBox(width: 6),
        Text('(${produk['rating']})'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          produk['nama']!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Katalog.warnaUtama,
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
                  backgroundColor: Katalog.warnaUtama[50],
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
                const SizedBox(height: 8),
                _bintang(double.parse(produk['rating']!)),
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
