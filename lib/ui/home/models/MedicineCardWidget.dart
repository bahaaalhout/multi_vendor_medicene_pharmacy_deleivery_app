class MedicineModel {
  final String id;
  final String name; // Pain Relief-X 400 mg
  final String subtitle; // Tablets - 30 Tablets
  final double price; // 12.00
  final double? oldPrice; // 15.00 (optional)
  final String imageAsset;

  const MedicineModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageAsset,
    this.oldPrice,
  });
}
