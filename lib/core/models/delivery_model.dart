import 'order_model.dart';

enum DeliveryStatus {
  available,
  accepted,
  pickedUp,
  enRoute,
  delivered,
  confirmed,
}

enum DeliveryStep {
  pickup,
  onTheWay,
  delivered,
}

class DeliveryModel {
  final String id;
  final OrderModel order;
  final DeliveryStatus status;
  final double distanceKm;
  final double timeMinutes;
  final double price;
  final double rating;
  final String? customerOtp;
  final String? proofImageUrl;
  final String? statusMessage;

  const DeliveryModel({
    required this.id,
    required this.order,
    required this.status,
    required this.distanceKm,
    required this.timeMinutes,
    required this.price,
    required this.rating,
    this.customerOtp,
    this.proofImageUrl,
    this.statusMessage,
  });

  DeliveryStep get currentStep {
    switch (status) {
      case DeliveryStatus.available:
      case DeliveryStatus.accepted:
        return DeliveryStep.pickup;
      case DeliveryStatus.pickedUp:
      case DeliveryStatus.enRoute:
        return DeliveryStep.onTheWay;
      case DeliveryStatus.delivered:
      case DeliveryStatus.confirmed:
        return DeliveryStep.delivered;
    }
  }

  bool isStepCompleted(DeliveryStep step) {
    final currentIndex = DeliveryStep.values.indexOf(currentStep);
    final stepIndex = DeliveryStep.values.indexOf(step);
    return stepIndex < currentIndex;
  }

  bool isStepActive(DeliveryStep step) {
    return currentStep == step;
  }

  // Status checks
  bool get canPickup => status == DeliveryStatus.accepted;
  bool get canStartDelivery => status == DeliveryStatus.pickedUp;
  bool get canComplete => status == DeliveryStatus.enRoute;
  bool get isCompleted => status == DeliveryStatus.delivered || status == DeliveryStatus.confirmed;

  DeliveryModel copyWith({
    String? id,
    OrderModel? order,
    DeliveryStatus? status,
    double? distanceKm,
    double? timeMinutes,
    double? price,
    double? rating,
    String? customerOtp,
    String? proofImageUrl,
    String? statusMessage,
  }) {
    return DeliveryModel(
      id: id ?? this.id,
      order: order ?? this.order,
      status: status ?? this.status,
      distanceKm: distanceKm ?? this.distanceKm,
      timeMinutes: timeMinutes ?? this.timeMinutes,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      customerOtp: customerOtp ?? this.customerOtp,
      proofImageUrl: proofImageUrl ?? this.proofImageUrl,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}
