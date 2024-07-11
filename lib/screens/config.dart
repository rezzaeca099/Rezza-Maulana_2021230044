import 'dart:convert';
import 'package:http/http.dart' as http;

class Config {
  static const String apiUrl = 'http://mobilecomputing.my.id/api_rezza'; // Ganti dengan URL server Anda

  static Future<Map<String, dynamic>> register(String username, String password) async {
    final url = Uri.parse('$apiUrl/register.php'); // Panggil file register.php
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/login.php'); // Panggil file login.php
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
