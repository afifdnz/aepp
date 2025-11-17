// views/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/viewmodel/dashboard_viewmodel.dart';
import 'package:shop/routes/app_routes.dart';

// 1. GANTI MENJADI 'StatelessWidget'
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. CARI CONTROLLER SECARA MANUAL
    // Ini menjamin controller sudah ada berkat DashboardBinding
    final DashboardViewModel controller = Get.find<DashboardViewModel>();

    return Scaffold(
      // 3. GUNAKAN GetRouterOutlet BIASA (TANPA BUILDER)
      body: GetRouterOutlet(
        initialRoute: Routes.HOME,
        anchorRoute: Routes.DASHBOARD,

        // 4. BERIKAN 'delegate' DARI CONTROLLER
        // Ini adalah 'Get.rootDelegate' yang sama
        // yang didengarkan oleh ViewModel.
        delegate: controller.delegate,
      ),

      // BottomNav Anda tetap sama dan akan berfungsi
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),

        child: Obx(() {
          return BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            backgroundColor: const Color(0xFF222222),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[600],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                activeIcon: Icon(Icons.favorite),
                label: 'WishList',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        }),
      ),
    );
  }
}

