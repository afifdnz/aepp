import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:shop/services/auth_service.dart';

class RegisterViewModel extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  void goToStep2() {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      Get.snackbar('Error', 'Nama dan Email tidak boleh kosong.');
      return;
    }
    if (!emailController.text.isEmail) {
      Get.snackbar('Error', 'Format email tidak valid.');
      return;
    }
    Get.toNamed(Routes.REGISTER_STEP_2);
  }

  void goToStep3() {
    if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password minimal 6 karakter.');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwrod dan konfirmasi password tidak cocok.');
      return;
    }
    Get.toNamed(Routes.REGISTER_STEP_3);
  }

  void submitRegistration() async {
    if (usernameController.text.isEmpty) {
      Get.snackbar('Error', "Username tidak boleh kosong");
      return;
    }

    isLoading(true);
    try {
      await authService.signUp(
        name: nameController.text,
        email: emailController.text,
        tanggalLahir: dobController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
    } catch (e) {
      Get.snackbar('Registration Failed', e.toString());
    } finally {
      isLoading(false);
    }

    // if (usernameController.text.isEmpty) {
    //   Get.snackbar('Error', 'Username tidak boleh kosong');
    //   return;
    // }
    //
    // isLoading(true);
    // try {
    //   await authService.signUp(
    //     name: nameController.text,
    //     email: emailController.text,
    //     dob: dobController.text,
    //     password: passwordController.text,
    //     username: usernameController.text,
    //   );
    // } catch (e) {
    //   print(e);
    // } finally {
    //   isLoading(false);
    // }

    //
    // print("Name: ${nameController.text}");
    // print("Email: ${emailController.text}");
    // print("DOB: ${dobController.text}");
    // print("Password: ${passwordController.text}");
    // print("Username: ${usernameController}");
    //
    // await Future.delayed(const Duration(seconds: 1));
    // isLoading(false);
    //
    // Get.snackbar('Success', 'Akun berhasil dibuat, ${nameController.text}');
    // Get.offAllNamed(Routes.DASHBOARD);
  }

  void goToLogin() {
    Get.back();
  }
}
