import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/services/auth_service.dart';

import '../models/my_order_details_model.dart';
import '../models/my_order_summary_model.dart';

class OrdersRepository {
  static Future<List<MyOrderSummaryModel>> fetchMyOrders({
    int page = 1,
    int limit = 50,
    String filter = 'ALL',
    String sortOrder = 'desc',
  }) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final uri = Uri.parse("${AuthService.baseUrl}/orders").replace(
      queryParameters: {
        "page": page.toString(),
        "limit": limit.toString(),
        "filter": filter,
        "sortOrder": sortOrder,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Orders statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Fetch orders failed: ${response.statusCode} - ${response.body}",
      );
    }

    final decoded = jsonDecode(response.body);

    // Swagger: { success: true, data: [], meta: {...} }
    final data = (decoded is Map) ? decoded["data"] : null;

    final orders = <MyOrderSummaryModel>[];
    if (data is List) {
      for (final item in data) {
        if (item is Map<String, dynamic>) {
          orders.add(MyOrderSummaryModel.fromJson(item));
        } else if (item is Map) {
          orders.add(MyOrderSummaryModel.fromJson(item.cast<String, dynamic>()));
        }
      }
    }

    return orders;
  }

  static Future<MyOrderDetailsModel> fetchOrderDetails(int id) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final uri = Uri.parse("${AuthService.baseUrl}/orders/$id");

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Order details statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Fetch details failed: ${response.statusCode} - ${response.body}",
      );
    }

    final decoded = jsonDecode(response.body);

    final data = (decoded is Map && decoded["data"] is Map)
        ? decoded["data"]
        : decoded;

    if (data is Map) {
      return MyOrderDetailsModel.fromJson(data.cast<String, dynamic>());
    }

    throw Exception("Invalid order details response");
  }

  static Future<void> cancelOrder(int id) async {
    final token = await AuthService().getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception("Missing access token (login required)");
    }

    final uri = Uri.parse("${AuthService.baseUrl}/orders/$id/cancel");

    final response = await http.patch(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    log("Cancel statusCode: ${response.statusCode}");
    log(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        "Cancel failed: ${response.statusCode} - ${response.body}",
      );
    }
  }
}