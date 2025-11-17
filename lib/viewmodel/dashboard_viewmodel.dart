// viewmodels/dashboard_viewmodel.dart
import 'package:get/get.dart';
import 'package:shop/routes/app_routes.dart'; // Sesuaikan path

class DashboardViewModel extends GetxController {
  var tabIndex = 0.obs;

  // 1. INI KUNCINYA: Ambil 'rootDelegate' yang sudah ada
  // 'Get.rootDelegate' dibuat oleh GetMaterialApp dan dijamin ada.
  final GetDelegate delegate = Get.rootDelegate;

  @override
  void onInit() {
    super.onInit();

    // 2. Pasang listener di onInit. Ini aman karena 'delegate' sudah ada.
    delegate.addListener(() {
      updateTabIndexOnRouteChanged(
        // Gunakan 'currentConfiguration?.location' untuk mendapatkan path
        delegate.currentConfiguration?.location ?? '',
      );
    });
  }

  // 3. Method 'changeTabIndex' Anda sudah benar
  void changeTabIndex(int index) {
    if (tabIndex.value == index) return;

    // ViewModel tidak perlu mengubah tabIndex di sini,
    // listener di atas akan melakukannya secara otomatis.

    // Gunakan 'delegate' yang sama untuk bernavigasi
    switch (index) {
      case 0:
        delegate.toNamed(Routes.HOME);
        break;
      case 1:
        delegate.toNamed(Routes.WISHLIST);
        break;
      case 2:
        delegate.toNamed(Routes.PROFILE);
        break;
    }
  }

  // 4. Method 'updateTabIndexOnRouteChanged' Anda sudah benar
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
