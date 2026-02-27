import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      "https://gsg-project-group-1-production.up.railway.app";
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final accessToken = data["data"]["tokens"]["accessToken"];
      final refreshToken = data["data"]["tokens"]["refreshToken"];

      await _saveTokens(accessToken, refreshToken);
    } else {
      final message = data["message"] ?? "Login failed";
      throw Exception(message);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final accessToken = data["data"]?["tokens"]?["accessToken"];
      final refreshToken = data["data"]?["tokens"]?["refreshToken"];

      if (accessToken != null && refreshToken != null) {
        await _saveTokens(accessToken, refreshToken);
      }
    } else {
      throw Exception(data["message"] ?? "Signup failed");
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", access);
    await prefs.setString("refreshToken", refresh);
  }

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refreshToken");

    if (refreshToken == null) {
      throw Exception("No refresh token found");
    }

    final response = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final newAccess = data["data"]["accessToken"];
      final newRefresh = data["data"]["refreshToken"];

      await _saveTokens(newAccess, newRefresh);
    } else {
      throw Exception("Session expired");
    }
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
