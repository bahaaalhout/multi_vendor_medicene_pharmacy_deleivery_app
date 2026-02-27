import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl =
      "https://gsg-project-group-1-production.up.railway.app";

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final accessToken = data["data"]["tokens"]["accessToken"];
      final refreshToken = data["data"]["tokens"]["refreshToken"];

      await _saveTokens(accessToken, refreshToken);
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", access);
    await prefs.setString("refreshToken", refresh);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}