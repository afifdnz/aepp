import 'package:get/get.dart';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/repositories/cart_repository.dart';
import 'package:shop/services/cart_services.dart';

class CartViewModel extends GetxController {
  final CartService cartService = Get.find<CartService>();

  // 3. Buat 'getter' untuk meneruskan data ke View

  // 'cartItems' di View akan langsung membaca dari service
  RxList<CartItemModel> get cartItems => cartService.cartItems;

  // 'totalAmount' di View akan langsung membaca dari service
  double get totalAmount => cartService.totalAmount;

  // 4. Buat method 'pass-through'
  // View akan memanggil ini, dan ini akan memanggil service

  void incrementQuantity(CartItemModel item) {
    cartService.incrementQuantity(item);
  }

  void decrementQuantity(CartItemModel item) {
    cartService.decrementQuantity(item);
  }

  void removeCartItem(CartItemModel item) {
    cartService.removeFromCart(item);
  }

  void checkout() {
    // Logika checkout
    Get.snackbar('Checkout', 'Proceeding to checkout!');
  }

  // final CartRepository repository;
  // CartViewModel({required this.repository});
  //
  // var isLoading = true.obs;
  // var cartItems = <CartItemModel>[].obs;
  // var totalAmount = 0.0.obs;
  //
  // onInit() {
  //   super.onInit();
  //   fetchCartItems();
  // }
  //
  // void fetchCartItems() async {
  //   try {
  //     isLoading(true);
  //     var items = await repository.getCartItems();
  //     cartItems.assignAll(items);
  //     _calculateTotalAmount();
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to load cart items. Please check your connection.',
  //     );
  //     print(e);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  //
  // void _calculateTotalAmount() {
  //   double total = 0;
  //   for (var item in cartItems) {
  //     total += item.subtotal;
  //   }
  //   totalAmount.value = total;
  // }
  //
  // void incrementQuantity(int index) {
  //   cartItems[index].quantity++;
  //   cartItems.refresh(); // Beri tahu Obx untuk refresh UI
  //   _calculateTotalAmount();
  // }
  //
  // void decrementQuantity(int index) {
  //   if (cartItems[index].quantity > 1) {
  //     cartItems[index].quantity--;
  //     cartItems.refresh();
  //     _calculateTotalAmount();
  //   } else {
  //     removeCartItem(index);
  //   }
  // }
  //
  // void removeCartItem(int index) {
  //   cartItems.removeAt(index);
  //   cartItems.refresh();
  //   _calculateTotalAmount();
  //   Get.snackbar('Item Removed', 'Product has been removed from cart.');
  // }
  //
  // void checkout() {
  //   // Logika untuk proses checkout
  //   Get.snackbar('Checkout', 'Proceeding to checkout!');
  //   // Di sini Anda akan menavigasi ke halaman pembayaran/konfirmasi
  // }
}
