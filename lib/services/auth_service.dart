import 'package:get/get.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/routes/app_routes.dart';

class AuthService extends GetxService {
  var isLoggedIn = false.obs;

  var currentUser = Rxn<UserModel>();

  final _users = <UserModel>[].obs;
  int _nextUserId = 1;

  Future<void> signUp({
    required String name,
    required String email,
    required String dob,
    required String password,
    required String username,
  }) async {
    if (_users.any((user) => user.email == email)) {
      Get.snackbar('Error', 'Email already exists.');
      throw Exception('Emai already exists');
    }
    if (_users.any((user) => user.username == username)) {
      Get.snackbar('Error', 'Username already taken.');
      throw Exception('Username already taken');
    }

    final newUser = UserModel(
      id: _nextUserId++,
      name: name,
      email: email,
      username: username,
      dob: dob.isEmpty ? null : dob,
      password: password,
    );

    _users.add(newUser);

    isLoggedIn.value = true;
    currentUser.value = newUser;

    Get.offAllNamed(Routes.DASHBOARD);
  }

  Future<void> login(String email, String password) async {
    final user = _users.firstWhereOrNull((user) => user.email == email);
    if (user == null) {
      Get.snackbar('Error', 'Email not found.');
      throw Exception('Email not found');
    }
    if (user.password != password) {
      Get.snackbar('Error', "Incorrect password.");
      throw Exception("Incorrect password");
    }

    isLoggedIn.value = true;
    currentUser.value = user;

    Get.offAllNamed(Routes.DASHBOARD);
  }

  void logout() {
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}
