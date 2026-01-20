import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/sales_info.dart';

class MedicineModel {
  final String id;
  final String brandName;
  final String genericName;
  final String description;
  final List<String> warnings;
  final String type;
  final String brand;
  final String strength;
  final FormType form;
  final int quantity;
  final bool requiresPrescription;
  final List<String> imageUrls;
  final double rating;
  final String details;
  final String effects;
  final String directions;
  final List<String> reviews;
  final SaleInfo? salesInfo;

  MedicineModel({
    required this.id,
    required this.brandName,
    required this.genericName,
    required this.description,
    required this.warnings,
    required this.form,
    required this.quantity,
    required this.strength,
    required this.requiresPrescription,
    required this.imageUrls,
    required this.rating,
    required this.brand,
    required this.type,
    required this.details,
    required this.effects,
    required this.directions,
    required this.reviews,
    this.salesInfo,
  });
  bool get isOnSale => salesInfo != null;
}

enum FormType { tablet, syrup, capsule, injection, cream, ointment }
