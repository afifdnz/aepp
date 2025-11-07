import 'package:shop/models/cart_item_model.dart';
import 'package:shop/models/product_model.dart';

class CartRepository {
  final List<ProductModel> _dummyProducts = [
    ProductModel(
      id: 1,
      name: 'Beats Solo 2',
      description: 'Experience your music with immersive sound.',
      price: 109.09,
      imageUrl:
          'https://cdn.dummyjson.com/product-images/tablets/ipad-mini-2021-starlight/thumbnail.webp',
    ),
    // ProductModel(
    //   id: 2,
    //   name: 'Xiaomi Headset',
    //   description: 'High-quality sound with comfortable design.',
    //   price: 49.99,
    //   imageUrl: 'https://cdn.dummyjson.com/product-images/20/thumbnail.jpg',
    // ),
  ];

  Future<List<CartItemModel>> getCartItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      CartItemModel(product: _dummyProducts[0], quantity: 2),
      // CartItemModel(product: _dummyProducts[1], quantity: 1),
    ];
  }
}
