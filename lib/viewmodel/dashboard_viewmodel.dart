import 'package:get/get.dart';
import 'package:shop/routes/app_routes.dart';

class DashboardViewModel extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    if (tabIndex.value == index) return;

    tabIndex.value = index;

    switch (index) {
      case 0:
        Get.rootDelegate.toNamed(Routes.HOME);
        break;
      case 1:
        Get.rootDelegate.toNamed(Routes.WISHLIST);
        break;
      case 2:
        Get.rootDelegate.toNamed(Routes.PROFILE);
        break;
    }
  }

  void updateTabIndexOnRouteChanged(String? route) {
    if (route == null) return;

    if (route.startsWith(Routes.HOME) ||
        route.startsWith(Routes.PRODUCT_LIST)) {
      tabIndex.value = 0;
    } else if (route.startsWith(Routes.WISHLIST)) {
      tabIndex.value = 1;
    } else if (route.startsWith(Routes.PROFILE)) {
      tabIndex.value = 2;
    }
  }
}
