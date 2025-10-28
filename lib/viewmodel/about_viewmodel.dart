import 'package:shop/model/product_model.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutViewmodel extends GetxController {
  final ProductRepository repository;
  AboutViewmodel({required this.repository});

  var product = Rxn<ProductModel>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
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
      product.value = await repository.getProductsById(id);
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
}
