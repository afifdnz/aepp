import 'package:get/get.dart';
import 'package:shop/viewmodel/dashboard_viewmodel.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashboardViewModel>(() => DashboardViewModel());
  }
}
