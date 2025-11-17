class ProductImageModel {
  final int id;
  final int productId;
  final String imageUrl;

  ProductImageModel({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['ID'],
      productId: json['ProductID'],
      imageUrl: json['ImageURL'],
    );
  }
}
