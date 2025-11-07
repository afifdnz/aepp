import 'package:shop/models/product_model.dart';

class WishlistRepository {
  final List<ProductModel> _dummyProducts = [
    ProductModel(
      id: 1,
      name: 'Beats Solo 2',
      description: 'Experience your music with immersive sound.',
      price: 109.09,
      imageUrl:
          'https://cdn.dummyjson.com/product-images/tablets/ipad-mini-2021-starlight/thumbnail.webp',
    ),
  ];

  Future<List<ProductModel>> getWishlistItems() async {
    await Future.delayed(const Duration(seconds: 500));
    return _dummyProducts;
  }
}
