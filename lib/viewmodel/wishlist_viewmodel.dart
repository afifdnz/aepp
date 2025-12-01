import 'package:get/get.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/wishlist_item_model.dart';
import 'package:shop/repositories/wishlist_repository.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shop/services/cart_services.dart';
import 'package:shop/services/wishlist_service.dart';

class WishlistViewModel extends GetxController {
  final WishlistService wishlistService = Get.find<WishlistService>();
  final CartService cartService = Get.find<CartService>();

  List<ProductModel> get wishlistItems =>
      wishlistService.wishlistItems.map((e) => e.product).toList();

  // RxList<ProductModel> get wishlistItems => wishlistService.wishlistItems;
  RxList<WishlistItemModel> get rawWishlistItems =>
      wishlistService.wishlistItems;

  void removeFromWishlist(ProductModel product) {
    wishlistService.toggleWishlist(
      product,
    ); // Method ini sudah menangani 'remove'
  }

  void addToCart(ProductModel product) {
    cartService.addToCart(product);
    // (Opsional) Hapus dari wishlist setelah ditambahkan ke keranjang
    // wishlistService.toggleWishlist(product);
  }

  void goToCart() {
    Get.toNamed(Routes.CART);
  }

  // final WishlistRepository repository;
  // WishlistViewModel({required this.repository});
  //
  // var isLoading = false.obs;
  // var wishlistItems = <ProductModel>[].obs;
  var selectedFilterIndex = 0.obs;
  final List<String> filterTabs = [
    'All',
    'Tablets',
    'Laptops',
    'Phones',
    'Accessories',
  ];
  //
  // onInit() {
  //   super.onInit();
  //   fetchWishListItems();
  // }
  //
  // void fetchWishListItems() async {
  //   try {
  //     isLoading(true);
  //     var items = await repository.getWishlistItems();
  //     wishlistItems.assignAll(items);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load wishlist.');
  //     print(e);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  //
  void changeFilter(int index) {
    selectedFilterIndex.value = index;
  }

  //
  // void removeFromWishlist(ProductModel product) {
  //   wishlistItems.remove(product);
  //   Get.snackbar('Removed', '${product.name} removed from wishlist.');
  // }
  //
  // void addToCart(ProductModel product) {
  //   Get.snackbar('Added to Cart', '${product.name} added to cart.');
  // }
  //
  // void goToCart() {
  //   Get.toNamed(Routes.CART);
  // }
}
