// services/cart_service.dart
import 'package:get/get.dart';
import 'package:shop/models/cart_item_model.dart'; // Sesuaikan path
import 'package:shop/models/product_model.dart'; // Sesuaikan path
import 'package:flutter/material.dart'; // Untuk Snackbar

class CartService extends GetxService {
  // Ini adalah "database" memori kita.
  // Daftar ini akan hidup selamanya.
  final cartItems = <CartItemModel>[].obs;

  // --- GETTERS (untuk dibaca oleh ViewModel) ---

  // Getter reaktif untuk total jumlah
  // 'fold' adalah cara cepat untuk menjumlahkan list
  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  // --- METHODS (untuk dipanggil oleh ViewModel) ---

  void addToCart(ProductModel product) {
    // Cek apakah item sudah ada di keranjang
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // Jika sudah ada, tambahkan quantity-nya
      cartItems[index].incrementQuantity();
    } else {
      // Jika belum ada, tambahkan item baru ke daftar
      cartItems.add(CartItemModel(product: product, quantity: 1));
    }

    // Panggil refresh() untuk memberi tahu Obx bahwa list internal berubah
    cartItems.refresh();

    Get.snackbar(
      'Added to Cart',
      '${product.name} added to cart.',
      backgroundColor: Colors.black.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(15),
    );
  }

  void incrementQuantity(CartItemModel item) {
    item.incrementQuantity();
    cartItems.refresh(); // Update UI
  }

  void decrementQuantity(CartItemModel item) {
    if (item.quantity > 1) {
      item.decrementQuantity();
    } else {
      // Jika kuantitas 1, hapus item
      removeFromCart(item);
    }
    cartItems.refresh(); // Update UI
  }

  void removeFromCart(CartItemModel item) {
    cartItems.remove(item);
    Get.snackbar(
      'Removed',
      '${item.product.name} removed from cart.',
      backgroundColor: Colors.black.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
  }
}
