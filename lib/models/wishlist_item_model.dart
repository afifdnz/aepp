import 'package:shop/models/product_model.dart';
import 'package:shop/models/category_model.dart';

class WishlistItemModel {
  final int id;
  final int userId;
  final int productId;
  final ProductModel product;

  WishlistItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.product,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      // id: json['id'] ?? json['ID'] ?? 0,
      // userId: json['user_id'] ?? json['UserID'] ?? 0,
      // product: ProductModel.fromJson(json['Product'] ?? json['product']),
      id: json['id'] ?? 0,
      // Gunakan 'user_id' (snake_case) sesuai JSON Anda
      userId: json['user_id'] ?? 0,
      // Gunakan 'product_id' (snake_case) sesuai JSON Anda
      productId: json['product_id'] ?? 0,

      // Parsing Product
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : ProductModel(
              id: 0,
              categoryId: 0,
              name: 'Unknown',
              description: '',
              price: 0,
              stockQuantity: 0,
              category: CategoryModel(id: 0, name: ''),
              productImages: [],
            ),
    );
  }
}
