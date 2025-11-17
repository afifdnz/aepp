import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:shop/services/auth_service.dart';

class LoginViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = Get.find<AuthService>();

  var isLoading = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || !email.isEmail || password.isEmpty) {
      Get.snackbar('Error', 'Please enter a valid email and password');
      return;
    }
    isLoading(true);

    try {
      await authService.login(email, password);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }

    // await Future.delayed(const Duration(seconds: 1));
    //
    // isLoading(false);
    //
    // Get.snackbar('Success', 'Welcome back!');
    //
    // Get.offAllNamed(Routes.DASHBOARD);
  }

  void goToSignUp() {
    Get.toNamed(Routes.REGISTER_STEP_1);
  }
}
