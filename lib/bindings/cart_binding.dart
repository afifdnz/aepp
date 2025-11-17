import 'package:get/get.dart';
import 'package:shop/repositories/cart_repository.dart';
import 'package:shop/viewmodel/cart_viewmodel.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CartRepository>(() => CartRepository());
    Get.lazyPut<CartViewModel>(() => CartViewModel());
  }
}
