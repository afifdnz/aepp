// services/cart_service.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/repositories/cart_repository.dart';
import 'package:shop/repositories/order_repository.dart';
import 'package:shop/services/auth_service.dart';

class CartService extends GetxService {
  final CartRepository _repository = Get.find<CartRepository>();
  final OrderRepository _repositoryOrder = Get.find<OrderRepository>();
  final AuthService _authService = Get.find<AuthService>();

  final cartItems = <CartItemModel>[].obs;

  // Getter untuk total harga
  double get totalAmount => cartItems.fold(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  @override
  void onInit() {
    super.onInit();
    // Fetch cart saat login berubah atau saat aplikasi mulai
    ever(_authService.isLoggedIn, (loggedIn) {
      if (loggedIn) fetchCart();
    });
  }

  // --- 1. FETCH CART ---
  void fetchCart() async {
    if (!_authService.isLoggedIn.value) return;

    try {
      final userId = _authService.currentUser.value!.id;
      final items = await _repository.getCart(userId);
      cartItems.assignAll(items);
    } catch (e) {
      print("Error fetching cart: $e");
    }
  }

  // --- 2. ADD TO CART ---
  void addToCart(ProductModel product) async {
    if (!_authService.isLoggedIn.value) {
      Get.snackbar('Error', 'Please login first');
      return;
    }

    try {
      final userId = _authService.currentUser.value!.id;

      // Cek apakah item sudah ada di list LOKAL?
      // Jika ya, kita update quantity-nya saja (Optional, tergantung logika bisnis)
      // Untuk amannya, kita POST saja, lalu fetch ulang.

      await _repository.addToCart(userId, product.id, 1);

      Get.snackbar('Success', 'Added to cart');
      fetchCart(); // Refresh data dari server agar dapat cart_item_id yang baru
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart');
    }
  }

  // --- 3. UPDATE QUANTITY (INCREMENT) ---
  void incrementQuantity(CartItemModel item) async {
    try {
      final newQty = item.quantity + 1;

      // Optimistic Update (Update UI dulu biar cepat)
      item.quantity = newQty;
      cartItems.refresh();

      // Panggil API (Gunakan item.id yaitu cart_item_id)
      await _repository.updateCartItem(item.id, newQty);
    } catch (e) {
      // Revert jika gagal
      item.quantity = item.quantity - 1;
      cartItems.refresh();
      Get.snackbar('Error', 'Failed to update quantity');
    }
  }

  // --- 4. UPDATE QUANTITY (DECREMENT) ---
  void decrementQuantity(CartItemModel item) async {
    if (item.quantity > 1) {
      try {
        final newQty = item.quantity - 1;

        // Optimistic Update
        item.quantity = newQty;
        cartItems.refresh();

        // Panggil API
        await _repository.updateCartItem(item.id, newQty);
      } catch (e) {
        item.quantity = item.quantity + 1;
        cartItems.refresh();
      }
    } else {
      // Jika sisa 1 dan dikurang, tanya mau hapus atau tidak?
      removeCartItem(item);
    }
  }

  // --- 5. DELETE ITEM ---
  void removeCartItem(CartItemModel item) async {
    try {
      // Hapus dari list lokal dulu
      cartItems.remove(item);

      // Panggil API
      await _repository.deleteCartItem(item.id);
    } catch (e) {
      // Kembalikan jika gagal
      cartItems.add(item);
      Get.snackbar('Error', 'Failed to remove item');
    }
  }

  Future<void> checkout() async {
    // Validasi Login
    if (!_authService.isLoggedIn.value) {
      Get.snackbar('Error', 'Please login to checkout');
      return;
    }

    // Validasi Keranjang Kosong
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Cart is empty');
      return;
    }

    try {
      final userId = _authService.currentUser.value!.id;

      // 1. Panggil API Checkout
      await _repositoryOrder.checkout(userId);

      // 2. JIKA SUKSES: BERSIHKAN KERANJANG LOKAL
      // Karena backend sudah menghapus data di database,
      // UI kita juga harus dikosongkan.
      cartItems.clear();

      // 3. Tampilkan Pesan Sukses
      Get.defaultDialog(
        title: "Order Success!",
        middleText: "Your order has been placed successfully.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Tutup dialog
          // Opsional: Arahkan ke halaman riwayat pesanan
          // Get.toNamed(Routes.ORDER_HISTORY);
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Checkout failed. Please try again.');
      print(e);
    }
  }
}
