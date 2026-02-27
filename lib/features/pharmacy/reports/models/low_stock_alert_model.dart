enum StockAlertStatus { lowStock, outOfStock }

class LowStockAlertModel {
  final String id;
  final String medicineName;
  final int currentStock;
  final int maxStock;
  final StockAlertStatus status;
  final int? daysUntilOutOfStock;

  const LowStockAlertModel({
    required this.id,
    required this.medicineName,
    required this.currentStock,
    required this.maxStock,
    required this.status,
    this.daysUntilOutOfStock,
  });

  String get stockLabel => '$currentStock/$maxStock ';

  bool get isOutOfStock => status == StockAlertStatus.outOfStock;
}
