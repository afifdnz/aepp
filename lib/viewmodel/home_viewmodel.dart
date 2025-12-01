import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeViewmodel extends GetxController {
  final ProductRepository repository;
  HomeViewmodel({required this.repository});

  var tabIndex = 0.obs;
  // var selectedCategoryIndex = 0.obs;
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'icon': Icons.phone_android_outlined, 'name': 'Smartphones'},
    {'id': 4, 'icon': Icons.headset_outlined, 'name': 'Accessories'},
    {'id': 2, 'icon': Icons.laptop_chromebook_outlined, 'name': 'Laptops'},
    {'id': 3, 'icon': Icons.tablet_android_rounded, 'name': 'Tablets'},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  void fetchProduct() async {
    try {
      isLoading(true);
      print("Sebelum Product");
      var product = await repository.getProducts();
      print("Product: ${product}");
      productList.assignAll(product);
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

  void changeCategory(int index) {
    int categoryId = categories[index]['id'] as int;
    String categoryName = categories[index]['name'] as String;

    Get.toNamed(
      Routes.PRODUCT_LIST,
      arguments: {'category_id': categoryId, 'category_name': categoryName},
      // id: 1,
    );
  }

  // void changeCategory(int index) {
  //   var categoryName = categories[index]['name'] as String;
  //   if (categories[index]['name'] == 'Accessories') {
  //     categoryName = 'mobile-accessories';
  //   }
  //   Get.toNamed(
  //     Routes.PRODUCT_LIST,
  //     arguments: {'category': categoryName},
  //
  //     // --- INI PERBAIKANNYA ---
  //     // Beri tahu GetX untuk menggunakan navigator 'nested'
  //     // yang "berlabuh" di rute DASHBOARD.
  //     // -------------------------
  //   );
  // }
}
