import 'package:get/get.dart';
import 'package:shop/models/user_model.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:shop/repositories/auth_repository.dart';

class AuthService extends GetxService {
  final AuthRepository _repository = Get.find<AuthRepository>();
  var isLoggedIn = false.obs;

  var currentUser = Rxn<UserModel>();

  var token = Rxn<String>();

  int _nextUserId = 1;

  Future<void> signUp({
    required String name,
    required String email,
    required String tanggalLahir,
    required String password,
    required String username,
  }) async {
    await _repository.register(
      name: name,
      username: username,
      email: email,
      password: password,
      tanggalLahir: tanggalLahir,
    );

    await login(email, password);
    // if (_users.any((user) => user.email == email)) {
    //   Get.snackbar('Error', 'Email already exists.');
    //   throw Exception('Emai already exists');
    // }
    // if (_users.any((user) => user.username == username)) {
    //   Get.snackbar('Error', 'Username already taken.');
    //   throw Exception('Username already taken');
    // }
    //
    // final newUser = UserModel(
    //   id: _nextUserId++,
    //   name: name,
    //   email: email,
    //   username: username,
    //   dob: dob.isEmpty ? null : dob,
    //   password: password,
    // );
    //
    // _users.add(newUser);
    //
    // isLoggedIn.value = true;
    // currentUser.value = newUser;

    // Get.offAllNamed(Routes.DASHBOARD);
  }

  Future<void> login(String email, String password) async {
    // final apiToken = await _repository.login(email, password);
    final authResponse = await _repository.login(email, password);
    token.value = authResponse.token;

    currentUser.value = authResponse.user;

    isLoggedIn.value = true;

    Get.offAllNamed(Routes.DASHBOARD);
  }

  // Future<void> login(String email, String password) async {
  //   final user = _users.firstWhereOrNull((user) => user.email == email);
  //   if (user == null) {
  //     Get.snackbar('Error', 'Email not found.');
  //     throw Exception('Email not found');
  //   }
  //   if (user.password != password) {
  //     Get.snackbar('Error', "Incorrect password.");
  //     throw Exception("Incorrect password");
  //   }
  //
  //   isLoggedIn.value = true;
  //   currentUser.value = user;
  //
  //   Get.offAllNamed(Routes.DASHBOARD);
  // }

  void logout() {
    isLoggedIn.value = false;
    currentUser.value = null;
    token.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}
