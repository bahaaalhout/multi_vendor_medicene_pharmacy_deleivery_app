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
  });
}

enum FormType { tablet, syrup, capsule, injection, cream, ointment }
