import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';

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
