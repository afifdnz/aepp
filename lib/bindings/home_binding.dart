import 'package:get/get.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:shop/viewmodel/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<HomeViewmodel>(
      () => HomeViewmodel(repository: Get.find<ProductRepository>()),
    );
  }
}
