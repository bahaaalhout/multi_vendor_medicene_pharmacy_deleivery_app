enum MyOrderStatus {
  placed,
  processing,
  enRoute,
  delivered,
  cancelled,
  unknown,
}

class MyOrderSummaryModel {
  final int id;
  final MyOrderStatus status;
  final DateTime createdAt;
  final double totalAmount;
  final String currency;

  MyOrderSummaryModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.totalAmount,
    required this.currency,
  });

  static MyOrderStatus _statusFromServer(String? s) {
    final v = (s ?? '').toUpperCase();

    switch (v) {
      case 'PENDING':
      case 'PLACED':
      case 'UNDER_REVIEW':
        return MyOrderStatus.placed;

      case 'PROCESSING':
      case 'PICKED_UP':
        return MyOrderStatus.processing;

      case 'EN_ROUTE':
        return MyOrderStatus.enRoute;

      case 'DELIVERED':
      case 'CONFIRMED':
      case 'RECEIVE_CONFIRMED':
        return MyOrderStatus.delivered;

      case 'CANCELLED':
      case 'CANCELED':
        return MyOrderStatus.cancelled;

      default:
        return MyOrderStatus.unknown;
    }
  }

  factory MyOrderSummaryModel.fromJson(Map json) {
    return MyOrderSummaryModel(
      id: (json['id'] ?? 0) as int,
      status: _statusFromServer(json['status']?.toString()),
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
              DateTime.now(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: (json['currency'] ?? 'ILS').toString(),
    );
  }
}