import 'package:shop/models/product_model.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/services/cart_services.dart';
import 'package:shop/services/wishlist_service.dart';

class AboutViewmodel extends GetxController {
  final ProductRepository repository;
  AboutViewmodel({required this.repository});

  final CartService cartService = Get.find<CartService>();
  final WishlistService wishlistService = Get.find<WishlistService>();

  var isLoading = true.obs;
  var product = Rxn<ProductModel>();
  var errorMessage = ''.obs;
  var isFavorite = false.obs;
  // late Rx<ProductModel> product;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null && args.containsKey('id')) {
      final int productId = args['id'] as int;
      fetchProduct(productId);
    } else {
      isLoading(false);
      errorMessage('Product ID Not Found.');
    }
  }

  void fetchProduct(int id) async {
    try {
      isLoading(true);
      errorMessage('');
      product.value = await repository.getProductById(id);

      if (product.value != null) {
        isFavorite.value = wishlistService.isFavorite(product.value!.id);
      }
    } catch (e) {
      print("Error fetching product: $e");
      Get.snackbar(
        'Error',
        'Failed to load product. Please check your connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void checkIfFavorite(ProductModel? p) {
    if (p == null) {
      isFavorite.value = true;
      return;
    }
    isFavorite.value = false;
  }

  void toggleFavorite() {
    if (product.value != null) {
      wishlistService.toggleWishlist(product.value!);
      // Update state lokal
      isFavorite.value = wishlistService.isFavorite(product.value!.id);
    }
  }

  void addToCart() {
    if (product.value != null) {
      cartService.addToCart(product.value!);
    }
  }

  // void addToCart() {
  //   if (product.value != null) {
  //     Get.snackbar(
  //       'Added to Cart.',
  //       '${product.value!.name} added to cart.',
  //     );
  //   }
  // }
}
