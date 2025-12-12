// repositories/product_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/product_model.dart'; // Sesuaikan path

class ProductRepository {
  final String _baseUrl =
      "https://aepp-project-mobile-aepp.hf.space/api"; // URL API Anda

  // FUNGSI 1 (Sudah Aman, tapi pastikan seperti ini)
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);

      print(decodedData);
      print("Status Code: ${response.statusCode}");
      print("Status Code: ${response.body}");

      // Null check
      if (decodedData == null || decodedData is! List) {
        print('API Error: /products returned null or non-list data.');
        return []; // Kembalikan list kosong
      }

      final List<dynamic> data = decodedData;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  // Future<List<ProductModel>> getProducts() async {
  //   try {
  //     final response = await http.get(Uri.parse('$_baseUrl/products'));
  //     print("Status Code: ${response.statusCode}");
  //     print("Status Code: ${response.body}");
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       final List<dynamic> productsListJson = data['products'];
  //       return productsListJson
  //           .map((json) => ProductModel.fromJson(json))
  //           .toList();
  //     } else {
  //       throw Exception(
  //         'Failed to load products (Status Code : ${response.statusCode})',
  //       );
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to connect or parse data: $e');
  //   }
  // }

  // FUNGSI 2 (INI YANG PERLU DIPERBAIKI)
  // Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
  //   final url = '$_baseUrl/products/category/${categoryName.toLowerCase()}';
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200) {
  //     final dynamic decodedData = json.decode(response.body);
  //     // --- TAMBAHKAN NULL CHECK INI ---
  //     if (decodedData == null || decodedData is! List) {
  //       print('API Error: /products/category/$categoryName returned null.');
  //       return []; // Kembalikan list kosong agar tidak crash
  //     }
  //     // -------------------------------
  //
  //     final List<dynamic> data = decodedData;
  //     return data.map((json) => ProductModel.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load products for category $categoryName');
  //   }
  // }

  Future<List<ProductModel>> getProductsByCategoryId(int categoryId) async {
    final url = '$_baseUrl/categories/$categoryId/products';
    print("CATEGORY ID: $categoryId");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic decodeData = json.decode(response.body);
      print(decodeData);
      if (decodeData == null || decodeData is! List) {
        print('API Error: returned null.');
        return [];
      }
      final List<dynamic> data = decodeData;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for category ID $categoryId');
    }
  }

  // FUNGSI 3 (Tambahkan null check di sini juga)
  Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/products/$id'));

    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);

      // --- TAMBAHKAN NULL CHECK INI ---
      if (decodedData == null || decodedData is! Map) {
        print('API Error: /product/$id returned null or non-map data.');
        throw Exception('Product not found (null response)');
      }
      // -------------------------------

      final Map<String, dynamic> data = Map<String, dynamic>.from(decodedData);
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load product detail');
    }
  }
}
