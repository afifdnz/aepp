import 'package:get/get.dart';
import 'package:shop/repositories/wishlist_repository.dart';
import 'package:shop/viewmodel/wishlist_viewmodel.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WishlistRepository>(() => WishlistRepository());
    Get.lazyPut<WishlistViewModel>(() => WishlistViewModel());
  }
}
