import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shop/models/product_image_model.dart';
import 'package:shop/models/auth_response_model.dart';

class AuthRepository {
  final String _baseUrl = "https://aepp-project-mobile-aepp.hf.space/api";

  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
    String? tanggalLahir,
  }) async {
    final body = json.encode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'tanggal_lahir': tanggalLahir == null || tanggalLahir.isEmpty
          ? null
          : tanggalLahir,
    });

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("Body awal: ${body}");
      print("🔥 STATUS CODE: ${response.statusCode}");
      print("🔥 BODY BALASAN SERVER: ${response.body}");

      if (response.statusCode != 201) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<AuthResponseModel> login(String email, String password) async {
    final body = json.encode({'email': email, 'password': password});
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print("Body awal: ${body}");
    print("🔥 STATUS CODE: ${response.statusCode}");
    print("🔥 BODY BALASAN SERVER: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return AuthResponseModel.fromJson(data);
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to login');
    }
  }

  // Future<String> login(String email, String password) async {
  //   final body = json.encode({'email': email, 'passwrod': password});
  //
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/users/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: body,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final String token = data['token'];
  //     return token;
  //   } else {
  //     final errorData = json.decode(response.body);
  //     throw Exception(errorData['message'] ?? 'Failed to login');
  //   }
  // }
}
