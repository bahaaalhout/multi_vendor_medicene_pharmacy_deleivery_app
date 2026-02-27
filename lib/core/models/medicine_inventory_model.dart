class MedicineInventoryModel {
  final int id;
  final String name;
  final String manufacturer;
  final String category;
  final String type;
  final bool requiresPrescription;
  final String? imageUrl;

  MedicineInventoryModel({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.category,
    required this.type,
    required this.requiresPrescription,
    this.imageUrl,
  });

  factory MedicineInventoryModel.fromJson(Map<String, dynamic> json) {
    return MedicineInventoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Medicine',
      manufacturer: json['manufacturer'] ?? 'Unknown Manufacturer',
      category: json['category'] ?? 'General',
      type: json['type'] ?? 'Tablet',
      requiresPrescription: json['requiresPrescription'] ?? false,
      imageUrl: json['imageUrl'],
    );
  }
}
