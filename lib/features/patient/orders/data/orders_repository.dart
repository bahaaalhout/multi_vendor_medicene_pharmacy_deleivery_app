import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/services/auth_service.dart';

import '../models/my_order_summary_model.dart';
import '../models/my_order_details_model.dart';

class OrdersRepository {
  static Future<List<MyOrderSummaryModel>> fetchMyOrders({
    int page = 1,
    int limit = 50,
  }) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final url = "${AuthService.baseUrl}/orders/my?page=$page&limit=$limit";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Orders statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Fetch orders failed: ${response.statusCode} - ${response.body}");
    }

    final decoded = jsonDecode(response.body);

    List<MyOrderSummaryModel> orders = [];
    if (decoded is Map && decoded["data"] is List) {
      for (Map map in decoded["data"]) {
        orders.add(MyOrderSummaryModel.fromJson(map));
      }
    }

    return orders;
  }

  static Future<MyOrderDetailsModel> fetchOrderDetails(int id) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final url = "${AuthService.baseUrl}/orders/my/$id";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Order details statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Fetch details failed: ${response.statusCode} - ${response.body}");
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map) {
      return MyOrderDetailsModel.fromJson(decoded);
    }

    throw Exception("Invalid order details response");
  }

  static Future<void> cancelOrder(int id) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final url = "${AuthService.baseUrl}/orders/my/$id/cancel";

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Cancel statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Cancel failed: ${response.statusCode} - ${response.body}");
    }
  }
}