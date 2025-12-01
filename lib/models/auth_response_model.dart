// models/auth_response_model.dart
import 'package:shop/models/user_model.dart'; // Sesuaikan path

class AuthResponseModel {
  final UserModel user;
  final String token;

  AuthResponseModel({required this.user, required this.token});

  // Factory constructor untuk parsing JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Asumsi API Anda mengembalikan:
    // {
    //   "token": "...",
    //   "user": { "ID": 1, "Name": "...", ... }
    // }
    return AuthResponseModel(
      user: UserModel.fromJson(json),
      token: json['token'] ?? json['Token'] ?? '',
    );
  }
}
