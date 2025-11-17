import 'package:get/get.dart';
import 'package:shop/viewmodel/register_viewmodel.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<RegisterViewModel>(() => RegisterViewModel(), fenix: true);
  }
}
