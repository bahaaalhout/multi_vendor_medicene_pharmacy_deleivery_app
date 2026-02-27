import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/models/low_stock_alert_model.dart';

class LowStockRepository {
  Future<List<LowStockAlertModel>> getLowStockAlerts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return lowStockAlerts;
  }
}

final lowStockAlerts = [
  const LowStockAlertModel(
    id: '1',
    medicineName: 'Atorvastatin 20mg',
    currentStock: 5,
    maxStock: 30,
    status: StockAlertStatus.lowStock,
    daysUntilOutOfStock: 2,
  ),
  const LowStockAlertModel(
    id: '2',
    medicineName: 'Paracetamol 500mg',
    currentStock: 3,
    maxStock: 40,
    status: StockAlertStatus.lowStock,
  ),
  const LowStockAlertModel(
    id: '3',
    medicineName: 'Metformin 850mg',
    currentStock: 0,
    maxStock: 25,
    status: StockAlertStatus.outOfStock,
  ),
];
