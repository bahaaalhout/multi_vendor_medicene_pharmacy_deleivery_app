import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_model.dart';

part 'delivery_model.freezed.dart';

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

@freezed
abstract class DeliveryModel with _$DeliveryModel {
  const factory DeliveryModel({
    required String id,
    required OrderModel order,
    required DeliveryStatus status,
    required double distanceKm,
    required double timeMinutes,
    required double price,
    required double rating,
    String? customerOtp,
    String? proofImageUrl,
    String? statusMessage,
  }) = _DeliveryModel;

  }

extension DeliveryModelX on DeliveryModel { 
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

}
