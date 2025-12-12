import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/wishlist_item_model.dart';

class WishlistRepository {
  final String _baseUrl = "https://aepp-project-mobile-aepp.hf.space/api";
  // final List<ProductModel> _dummyProducts = [
  //   // ProductModel(
  //   //   id: 1,
  //   //   name: 'Beats Solo 2',
  //   //   description: 'Experience your music with immersive sound.',
  //   //   price: 109.09,
  //   //   imageUrl:
  //   //       'https://cdn.dummyjson.com/product-images/tablets/ipad-mini-2021-starlight/thumbnail.webp',
  //   // ),
  // ];

  Future<List<WishlistItemModel>> getWishlistItems(int userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId/wishlist'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => WishlistItemModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  Future<void> deleteWishlist(int wishlistId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/wishlist/$wishlistId'),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete wishlist item');
    }
  }

  Future<void> addToWishlist(int userId, int productId) async {
    final url = '$_baseUrl/wishlist';
    final body = json.encode({"user_id": userId, "product_id": productId});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("[POST]: Berhasil menambahkan ke wishlist");
      } else {
        print("Gagal add wishlist: ${response.body}");
        throw Exception('Failed to add to wishlist');
      }
    } catch (e) {
      throw Exception('Error adding to wishlist: $e');
    }
  }

  // Future<List<ProductModel>> getWishlistItems() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return _dummyProducts;
  // }
}
