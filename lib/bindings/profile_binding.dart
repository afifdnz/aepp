// bindings/profile_binding.dart
import 'package:get/get.dart';
import 'package:shop/viewmodel/profile_viewmodel.dart'; // Sesuaikan path

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewModel>(() => ProfileViewModel());
  }
}
