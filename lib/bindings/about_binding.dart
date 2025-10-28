import 'package:get/get.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:shop/view/about.dart';
import 'package:shop/viewmodel/about_viewmodel.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<AboutViewmodel>(
      () => AboutViewmodel(repository: Get.find<ProductRepository>()),
    );
  }
}
