import 'package:get/get.dart';
import 'package:shop/repositories/product_repository.dart';
import 'package:shop/viewmodel/product_list_viewmodel.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProductListViewmodel>(
      () => ProductListViewmodel(repository: Get.find<ProductRepository>()),
    );
  }
}
