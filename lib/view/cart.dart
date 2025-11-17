// views/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/cart_viewmodel.dart';
import 'package:shop/models/cart_item_model.dart';

class Cart extends GetView<CartViewModel> {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        // if (controller.isLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your cart is empty!',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start adding some amazing products.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.back(), // Kembali ke halaman sebelumnya
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          );
        }
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return _buildCartItemCard(context, item, index);
                    },
                  ),
                  // const SizedBox(
                  //   height: 100,
                  // ), // Spasi agar tidak tertutup footer
                  // // Tambahan opsional: Banner wishlist
                  // _buildWishlistSuggestion(context),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
            // _buildStickyFooter(), // Footer "Total Amount" dan "Checkout"
          ],
        );
      }),
      bottomNavigationBar: _buildStickyFooter(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Cart'),
      // Tidak ada ikon Wishlist di sini
    );
  }

  // Widget untuk setiap item di keranjang
  Widget _buildCartItemCard(
    BuildContext context,
    CartItemModel item,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // Warna abu-abu muda
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Quantity Stepper
                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onTap: () => controller.decrementQuantity(item),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    _quantityButton(
                      icon: Icons.add,
                      onTap: () => controller.incrementQuantity(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () => controller.removeCartItem(item),
                icon: const Icon(Icons.close, color: Colors.grey),
                iconSize: 20,
              ),
              const SizedBox(height: 10), // Spasi agar ikon tidak terlalu dekat

              Text(
                '\$${item.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper untuk tombol plus/minus kuantitas
  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }

  // Widget Opsional: Sugesti Wishlist
  Widget _buildWishlistSuggestion(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'See your Wishlist',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              // Aksi navigasi ke Wishlist
              // Get.toNamed(Routes.WISHLIST);
            },
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
          ),
        ],
      ),
    );
  }

  // Footer yang menempel di bawah
  Widget _buildStickyFooter() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        decoration: const BoxDecoration(
          color: Color(0xFF222222), // Warna hitam pekat
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Penting agar tidak memenuhi tinggi
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount:',
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Obx(() {
                  final _ = controller.cartItems.length;

                  return Text(
                    '\$${controller.totalAmount.toStringAsFixed(2)}',
                    style: Get.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 30),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.checkout,
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
