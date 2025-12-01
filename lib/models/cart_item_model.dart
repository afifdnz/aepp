import 'package:shop/models/product_model.dart';

class CartItemModel {
  // final ProductModel product;
  // int quantity;
  //
  // CartItemModel({required this.product, required this.quantity});
  //
  // void incrementQuantity() {
  //   quantity++;
  // }
  //
  // void decrementQuantity() {
  //   if (quantity > 1) {
  //     quantity--;
  //   }
  // }
  //
  // double get subtotal => product.price * quantity;

  final int id;
  final int userId;
  final int productId;
  int quantity;
  final ProductModel product;

  CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  double get subtotal => product.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 1,
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }
}
