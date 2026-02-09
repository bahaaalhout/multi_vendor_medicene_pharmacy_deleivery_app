import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/models/review_data.dart';

class DeliveryProfileState {
  final String name;
  final String email;
  final String location;
  final String phone;
  final String status;
  final String carType;
  final int totalDeliveries;
  final double totalEarnings;
  final List<ReviewData> reviews;

  DeliveryProfileState({
    required this.name,
    required this.email,
    required this.location,
    required this.phone,
    required this.status,
    required this.carType,
    required this.totalDeliveries,
    required this.totalEarnings,
    required this.reviews,
  });
}
