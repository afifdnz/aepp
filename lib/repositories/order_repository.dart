// repositories/order_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderRepository {
  // Ingat: Ganti localhost dengan IP jika di emulator/HP fisik
  final String _baseUrl = "https://aepp-project-mobile-aepp.hf.space/api";

  Future<void> checkout(int userId) async {
    final url = '$_baseUrl/orders/checkout';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_id": userId, // Sesuai permintaan API Anda
        }),
      );

      // Cek status code (biasanya 200 OK atau 201 Created)
      if (response.statusCode != 200 && response.statusCode != 201) {
        // Coba baca pesan error dari server jika ada
        print("Checkout Failed: ${response.body}");
        throw Exception('Failed to place order');
      }
    } catch (e) {
      throw Exception('Checkout Error: $e');
    }
  }
}
