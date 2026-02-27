import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/for_delete.dart';

class InventoryApiService {
  String baseUrl = 'https://gsg-project-group-1-production.up.railway.app';
  Future<void> addMedicineToInventory(InventoryModel request) async {
    final url = Uri.parse('$baseUrl/inventory');
    final token = await AuthService().getAccessToken();
    try {
      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        String errorMessage =
            "Failed to add medicine. Status code: ${response.statusCode}";
        try {
          final errorBody = jsonDecode(response.body);
          if (errorBody['message'] != null) {
            errorMessage = errorBody['message'];
          }
        } catch (_) {}

        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<InventoryModel>> getInventoryList({
    int page = 1,
    int limit = 10,
  }) async {
    final token = await AuthService().getAccessToken();
    final url = Uri.parse('$baseUrl/inventory?page=$page&limit=$limit');

    try {
      final response = await http.get(
        url,
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Parse the JSON string into a Dart Map/List
        final dynamic decodedData = jsonDecode(response.body);

        // Since many paginated APIs wrap their data in a "content" or "data" key,
        // we check for that, otherwise we assume it's a direct list.
        List<dynamic> itemsList = decodedData is List
            ? decodedData
            : (decodedData['content'] ?? decodedData['data'] ?? []);

        // Convert the raw JSON into your InventoryModel using the fromJson factory we made
        return itemsList.map((json) => InventoryModel.fromJson(json)).toList();
      } else {
        throw Exception(
          "Failed to load inventory. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<void> deleteMedicine(int id) async {
    final token = await AuthService().getAccessToken();
    final url = Uri.parse('$baseUrl/inventory/$id');

    try {
      final response = await http.delete(
        url,
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
          "Failed to delete medicine. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
