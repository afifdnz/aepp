import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:shop/model/product_model.dart';
import 'package:shop/viewmodel/about_viewmodel.dart';
import 'package:shop/widgets/product_card.dart';

class About extends GetView<AboutViewmodel> {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        // Obx membungkus widget agar reaktif

        // --- 1. Saat Loading ---
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- 2. Jika Ada Error ---
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${controller.errorMessage.value}',
              textAlign: TextAlign.center,
            ),
          );
        }

        // --- 3. Jika Sukses dan Data Ada ---
        if (controller.product.value != null) {
          final product = controller.product.value!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(product.imageUrl),
                _buildProductInfo(product),
                const SizedBox(
                  height: 100,
                ), // Memberi ruang agar tidak tertutup tombol
              ],
            ),
          );
        }

        // Fallback jika terjadi sesuatu
        return const Center(child: Text('No product data available.'));
      }),
      bottomNavigationBar: _buildAddToCartButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'About Product',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[100],
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 50,
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(ProductModel product) {
    // String staticDescription = product.description;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: FilledButton(
          onPressed: () {
            Get.snackbar(
              'Success',
              '${controller.product.value!.name} added to cart',
              backgroundColor: Colors.black.withOpacity(0.8),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(15),
              borderRadius: 10,
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF222222),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Add to cart',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
