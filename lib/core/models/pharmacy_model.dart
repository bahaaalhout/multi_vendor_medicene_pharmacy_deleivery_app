import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address.dart';

class PharmacyModel {
  final String id;
  final String name;
  final String image;
  final Address address;
  final double rating;
  final int reviewCount;
  final double deliveryFee;
  final String deliveryTime;
  final double distance;

  PharmacyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.distance,
  });
}
