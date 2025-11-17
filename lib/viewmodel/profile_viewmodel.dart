import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop/services/auth_service.dart';

class ProfileViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  String get username => authService.currentUser.value?.username ?? "Guest";
  String get userHandle => authService.currentUser.value?.email ?? "@guest";

  void goToMyAccount() {
    Get.snackbar('Navigate', 'Navigating to My Account....');
  }

  void goToMyOrders() {
    Get.snackbar('Navigate', 'Navigating to My Orders.....');
  }

  void goToShippingAddress() {
    Get.snackbar('Navigate', 'Navigating to Snipping Address');
  }

  void goToAboutApp() {
    Get.snackbar('Navigate', 'Navigating to About App......');
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        authService.logout();
        // nanti tambahkan proses logout
      },
    );
  }
}
