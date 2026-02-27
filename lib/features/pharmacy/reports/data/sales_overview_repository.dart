import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

/// Repository for pharmacy sales data.
/// Replace with API calls when backend is ready.
class SalesOverviewRepository {
  /// Fetches orders for the pharmacy.
  /// [pharmacyId] - optional, filter by pharmacy. If null, uses default pharmacy.
  Future<List<OrderModel>> getPharmacyOrders({String? pharmacyId}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final orders = pharmacySalesOrders;
    if (pharmacyId != null) {
      return orders.where((o) => o.pharmacyId == pharmacyId).toList();
    }
    return orders;
  }
}
