import 'package:shop/models/cart_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop/models/product_model.dart';

class CartRepository {
  // final List<ProductModel> _dummyProducts = [
  //   //   id: 2,
  //   // ProductModel(
  //   //   name: 'Xiaomi Headset',
  //   //   description: 'High-quality sound with comfortable design.',
  //   //   price: 49.99,
  //   //   imageUrl: 'https://cdn.dummyjson.com/product-images/20/thumbnail.jpg',
  //   // ),
  // ];

  // Future<List<CartItemModel>> getCartItems() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return [
  //     CartItemModel(product: _dummyProducts[0], quantity: 2),
  //     // CartItemModel(product: _dummyProducts[1], quantity: 1),
  //   ];
  // }

  final String _baseUrl = "http://172.25.16.1:8080/api";

  Future<List<CartItemModel>> getCart(int userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/users/$userId/cart'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => CartItemModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> addToCart(int userId, int productId, int quantity) async {
    print(
      "DEBUG: Mencoba add cart dengan UserID: $userId dan ProductID: $productId",
    );
    final response = await http.post(
      Uri.parse('$_baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
      }),
    );
    print(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add to cart');
    }
  }

  Future<void> updateCartItem(int cartItemId, int newQuantity) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/cart/$cartItemId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"quantity": newQuantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart quantity');
    }
  }

  Future<void> deleteCartItem(int cartItemId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/cart/$cartItemId'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }
}
