// services/wishlist_service.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop/repositories/wishlist_repository.dart';
import 'package:shop/models/product_model.dart'; // Sesuaikan path
import 'package:shop/services/auth_service.dart';
import 'package:shop/models/wishlist_item_model.dart';

class WishlistService extends GetxService {
  final WishlistRepository _repository = Get.find<WishlistRepository>();
  final AuthService _authService = Get.find<AuthService>();

  // Kita simpan LIST OF WISHLIST ITEM, bukan Product lagi
  final wishlistItems = <WishlistItemModel>[].obs;

  // --- HELPER: Cek apakah produk ada di wishlist ---
  bool isFavorite(int productId) {
    // Kita cek apakah ada item di list yang punya product_id tersebut
    return wishlistItems.any((item) => item.product.id == productId);
  }

  // --- 1. FETCH DATA ---
  void fetchWishlist() async {
    if (!_authService.isLoggedIn.value) return;

    try {
      final int userId = _authService.currentUser.value!.id;
      final items = await _repository.getWishlistItems(userId);
      wishlistItems.assignAll(items);
    } catch (e) {
      print("Error fetching wishlist: $e");
    }
  }

  // --- 2. ADD TO WISHLIST ---
  void addToWishlist(ProductModel product) async {
    // ... (Cek login sama seperti sebelumnya) ...
    final int userId = _authService.currentUser.value!.id;

    try {
      await _repository.addToWishlist(userId, product.id);

      // PENTING: Setelah add, kita harus fetch ulang
      // supaya kita dapat 'wishlist_id' yang baru dibuat oleh server
      fetchWishlist();

      Get.snackbar('Success', 'Added to wishlist');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add');
    }
  }

  // --- 3. DELETE FROM WISHLIST (Logika Baru) ---
  void removeFromWishlist(ProductModel product) async {
    try {
      // CARI 'wishlist_id' DULU
      // Kita cari item di list lokal yang product id-nya cocok
      final wishlistItem = wishlistItems.firstWhere(
        (item) => item.product.id == product.id,
      );

      // Hapus dari Server menggunakan wishlist_id
      await _repository.deleteWishlist(wishlistItem.id);

      // Hapus dari Lokal (UI update instan)
      wishlistItems.remove(wishlistItem);

      Get.snackbar('Removed', 'Removed from wishlist');
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to remove');
    }
  }

  // Toggle tetap sama, logika di dalamnya yang berubah
  void toggleWishlist(ProductModel product) {
    if (isFavorite(product.id)) {
      removeFromWishlist(product); // Panggil fungsi delete baru
    } else {
      addToWishlist(product);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Otomatis load saat aplikasi jalan
    ever(_authService.isLoggedIn, (loggedIn) {
      if (loggedIn) fetchWishlist();
    });
  }
}
