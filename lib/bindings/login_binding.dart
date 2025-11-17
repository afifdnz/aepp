import 'package:get/get.dart';
import 'package:shop/viewmodel/login_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
