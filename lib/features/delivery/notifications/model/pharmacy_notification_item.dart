enum PharmacyNotificationType {
  newOrderRequest,
  prescriptionUnclear,
  lowStock,
  orderReadyForPickup,
}

class PharmacyNotificationItem {
  final String id;
  final PharmacyNotificationType type;
  final String title;
  final String description;
  final DateTime createdAt;
  bool isRead;

  //payload (optional)
  final String? orderId; // #1340
  final String? customerName;
  final String? imageUrl; // prescription image
  final int? stockLeft;

  PharmacyNotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isRead = false,
    this.orderId,
    this.customerName,
    this.imageUrl,
    this.stockLeft,
  });
}
