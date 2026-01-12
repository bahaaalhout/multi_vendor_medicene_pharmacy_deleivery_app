import 'package:multi_vendor_medicene_pharmacy_deleivery_app/Features/home/models/MedicineModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/Features/home/models/PharmacyModel.dart';

class PharmacyOfferModel {
  final String id;
  final PharmacyModel pharmacy;
  final MedicineModel medicine;
  final double price;
  final double? discountPercent;
  final double? discountedPrice;
  final bool isAvailable;

  PharmacyOfferModel({
    required this.id,
    required this.pharmacy,
    required this.medicine,
    required this.price,
    this.discountPercent,
    this.discountedPrice,
    required this.isAvailable,
  });
}
