import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductRepository {
  final String _baseUrl = "http://dummyjson.com/products/category/tablets";

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      print("Status Code: ${response.statusCode}");
      print("Status Code: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsListJson = data['products'];
        return productsListJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load products (Status Code : ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect or parse data: $e');
    }
  }

  Future<ProductModel> getProductsById(int id) async {
    try {
      final response = await http.get(
        Uri.parse("http://dummyjson.com/products/${id}"),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ProductModel.fromJson(data);
      } else {
        throw Exception(
          'Failed to load products (Status Code : ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect or parse data: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    // API menggunakan nama kategori huruf kecil, misal: "smartphones"
    final url =
        "https://dummyjson.com/products/category/${categoryName.toLowerCase()}";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsListJson = data['products'];
        return productsListJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load products for category $categoryName (Status Code : ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect or parse data: $e');
    }
  }
}
