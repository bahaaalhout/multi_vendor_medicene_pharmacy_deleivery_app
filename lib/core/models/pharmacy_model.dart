import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/address_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

class PharmacyModel {
  final String id;
  final String name;
  final String image;
  final String phone;
  final AddressModel address;
  final double rating;
  final int reviewCount;
  final double deliveryFee;
  final String deliveryTime;
  final double distance;
  final List<MedicineModel> medicines;

  PharmacyModel({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.distance,
    this.medicines = const [],
  });
}
