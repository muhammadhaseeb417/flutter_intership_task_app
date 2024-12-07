import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/users";

  /// Login API
  static Future<Map<String, dynamic>> login(String email) async {
    final url = Uri.parse("$baseUrl?email=$email");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        if (users.isNotEmpty) {
          return {
            "success": true,
            "message": "Login successful",
            "data": users.first
          };
        } else {
          return {"success": false, "message": "User not found"};
        }
      } else {
        return {"success": false, "message": "Failed to connect to server"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Signup API
  static Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    final url = Uri.parse(baseUrl);
    final body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {
          "success": true,
          "message": "Signup successful",
          "data": data,
        };
      } else {
        return {
          "success": false,
          "message": "Signup failed. Try again later.",
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// OTP Verification API
  static Future<Map<String, dynamic>> verifyOtp(
      String email, String otp) async {
    final url = Uri.parse(baseUrl);
    final body = jsonEncode({
      "email": email,
      "otp": otp,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 201) {
        return {
          "success": true,
          "message": "OTP verification successful",
        };
      } else {
        return {
          "success": false,
          "message": "Invalid OTP or verification failed.",
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
