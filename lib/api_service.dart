import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // ----------------------------------------------------------------
  // 1. Dynamic URL Handling (Port 5000)
  // ----------------------------------------------------------------
  String get baseUrl {
    if (Platform.isAndroid) {
      // Android Emulator must use 10.0.2.2 to reach your PC
      return "http://10.0.2.2:5000/api";
    } else {
      // Windows, Web, or iOS use localhost
      return "http://localhost:5000/api";
    }
  }

  // ----------------------------------------------------------------
  // 2. Login Function
  // Returns: Map<String, dynamic> (Success data) or throws Exception
  // ----------------------------------------------------------------
  Future<Map<String, dynamic>> login(String username, String password) async {
    final String url = "$baseUrl/Auth/login";

    try {
      print("🔌 ApiService connecting to: $url");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      print("📝 Response Code: ${response.statusCode}");
      print("📝 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Success: Parse the JSON and return it
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception("Incorrect Username or Password");
      } else if (response.statusCode == 404) {
        throw Exception("User does not exist");
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      // Network errors (Server down, wrong port, etc.)
      throw Exception("Connection Failed: $e");
    }
  }
}