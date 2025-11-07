class ProductModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  // final String images;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    // required this.images,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      // images: json['images'] as String,
      imageUrl: json['thumbnail'] as String,
      description: json['description'] as String,
    );
  }
}
