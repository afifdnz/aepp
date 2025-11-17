// services/wishlist_service.dart
import 'package:get/get.dart';
import 'package:shop/models/product_model.dart'; // Sesuaikan path

class WishlistService extends GetxService {
  final wishlistItems = <ProductModel>[].obs;

  // Cek apakah produk ada di wishlist
  bool isFavorite(int productId) {
    return wishlistItems.any((product) => product.id == productId);
  }

  void toggleWishlist(ProductModel product) {
    if (isFavorite(product.id)) {
      // Hapus dari wishlist
      wishlistItems.removeWhere((p) => p.id == product.id);
      Get.snackbar('Removed', '${product.name} removed from wishlist.');
    } else {
      // Tambah ke wishlist
      wishlistItems.add(product);
      Get.snackbar('Added', '${product.name} added to wishlist.');
    }
  }
}
