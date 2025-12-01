// views/wishlist_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/models/product_model.dart'; // Sesuaikan path
import 'package:shop/viewmodel/wishlist_viewmodel.dart';

class Wishlist extends GetView<WishlistViewModel> {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFilterTabs(),
          Expanded(
            child: Obx(() {
              // if (controller.isLoading.value) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              if (controller.wishlistItems.isEmpty) {
                return const Center(child: Text('Your wishlist is empty.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: controller.wishlistItems.length,
                // itemBuilder: (context, index) {
                //   final product = controller.wishlistItems[index];
                //   return _buildWishlistItemCard(context, product);
                // },
                itemBuilder: (context, index) {
                  final product = controller.rawWishlistItems[index].product;
                  return _buildWishlistItemCard(context, product);
                },
              );
            }),
          ),
        ],
      ),
      // TIDAK ADA BottomNavigationBar di sini
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // 'leading' akan otomatis ditambahkan (tombol kembali)
      // jika ini adalah sub-halaman, tapi karena ini tab utama,
      // 'leading' tidak akan ada, yang mungkin Anda inginkan.
      // Jika Anda MAU tombol kembali, tambahkan:
      // leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
      title: const Text('Favorite'),
      actions: [
        IconButton(
          onPressed: controller.goToCart,
          icon: const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }

  // Widget untuk tab filter horizontal
  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filterTabs.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected = controller.selectedFilterIndex.value == index;
              final tabName = controller.filterTabs[index];
              return GestureDetector(
                onTap: () => controller.changeFilter(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(
                            bottom: BorderSide(color: Colors.black, width: 2.0),
                          )
                        : null,
                  ),
                  child: Text(
                    tabName,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  // Widget untuk setiap item di wishlist
  Widget _buildWishlistItemCard(BuildContext context, ProductModel product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // Warna abu-abu muda
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Gambar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),

          // Info Teks (Nama & Harga)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () => controller.removeFromWishlist(product),
                icon: const Icon(Icons.close, color: Colors.grey),
                iconSize: 20,
              ),
              IconButton(
                onPressed: () => controller.addToCart(product),
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          // Tombol Aksi (Hapus & Tambah ke Keranjang)
          // IconButton(
          //   onPressed: () => controller.addToCart(product),
          //   icon: Container(
          //     padding: const EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: const Icon(
          //       Icons.shopping_cart,
          //       color: Colors.white,
          //       size: 20,
          //     ),
          //   ),
          // ),
          // IconButton(
          //   onPressed: () => controller.removeFromWishlist(product),
          //   icon: const Icon(Icons.close, color: Colors.grey),
          //   iconSize: 20,
          // ),
        ],
      ),
    );
  }
}
