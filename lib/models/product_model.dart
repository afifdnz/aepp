// models/product_model.dart
import 'package:shop/models/category_model.dart';
import 'package:shop/models/product_image_model.dart';

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final int stockQuantity;
  // Kita bikin ini nullable (?) biar aman
  final CategoryModel? category;
  final List<ProductImageModel> productImages;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    this.category, // Tidak required lagi
    required this.productImages,
  });

  String get imageUrl {
    if (productImages.isNotEmpty) {
      return productImages.first.imageUrl;
    }
    return 'https://via.placeholder.com/300.png?text=No+Image';
  }

  // Getter aman untuk nama kategori
  String get categoryName => category?.name ?? 'Uncategorized';

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // 1. Parsing Images (Tetap sama)
    List<ProductImageModel> images = [];
    if (json['product_images'] != null) {
      var list = json['product_images'] as List;
      images = list.map((i) => ProductImageModel.fromJson(i)).toList();
    }

    // 2. Parsing Category (LEBIH PINTAR)
    CategoryModel? categoryData;
    try {
      // Cek berbagai kemungkinan key
      var catJson = json['category'] ?? json['Category'];

      if (catJson != null) {
        // KASUS A: Jika Category adalah OBJEK (Map)
        if (catJson is Map<String, dynamic>) {
          categoryData = CategoryModel.fromJson(catJson);
        }
        // KASUS B: Jika Category hanyalah ANGKA (ID)
        else if (catJson is int) {
          // Kita buat objek Category sementara hanya dengan ID
          categoryData = CategoryModel(id: catJson, name: 'Category $catJson');
        }
      }
    } catch (e) {
      print(
        "Warning: Gagal parsing category untuk product id ${json['id']} - Error: $e",
      );
    }

    // Jika masih null, gunakan default
    final finalCategory =
        categoryData ?? CategoryModel(id: 0, name: 'Uncategorized');

    return ProductModel(
      id: json['id'] ?? json['ID'] ?? 0,
      categoryId: json['category_id'] ?? json['CategoryID'] ?? 0,
      name: json['name'] ?? json['Name'] ?? '',
      description: json['description'] ?? json['Description'] ?? '',
      price: (json['price'] ?? json['Price'] ?? 0).toDouble(),
      stockQuantity: json['stock_quantity'] ?? json['StockQuantity'] ?? 0,

      category: finalCategory, // Gunakan hasil parsing yang aman

      productImages: images,
    );
  }
}
