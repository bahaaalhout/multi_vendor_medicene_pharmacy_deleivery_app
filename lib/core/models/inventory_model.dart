import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_inventory_model.dart';

enum StockStatus { inStock, lowStock, outOfStock }

class InventoryModel {
  final int medicineId;
  final int stockQuantity;
  final double sellPrice;
  final double costPrice;
  final int minStock;
  final String batchNumber;
  final String expiryDate;
  final String shelfLocation;
  final String notes;
  final MedicineInventoryModel? medicine;

  InventoryModel({
    required this.medicineId,
    required this.stockQuantity,
    required this.sellPrice,
    required this.costPrice,
    required this.minStock,
    required this.batchNumber,
    required this.expiryDate,
    required this.shelfLocation,
    required this.notes,
    this.medicine,
  });

  Map<String, dynamic> toJson() {
    return {
      "medicineId": medicineId,
      "stockQuantity": stockQuantity,
      "sellPrice": sellPrice,
      "costPrice": costPrice,
      "minStock": minStock,
      "batchNumber": batchNumber,
      "expiryDate": expiryDate,
      "shelfLocation": shelfLocation,
      "notes": notes,
    };
  }

  StockStatus get status {
    if (stockQuantity <= 0) return StockStatus.outOfStock;
    if (stockQuantity <= minStock) return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  String get quantity => stockQuantity.toString();
  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      medicineId: json['medicineId'],
      stockQuantity: json['stockQuantity'],
      sellPrice: (json['sellPrice'] ?? 0).toDouble(),
      costPrice: (json['costPrice'] ?? 0).toDouble(),
      minStock: json['minStock'],
      batchNumber: json['batchNumber'] ?? 'Unknown Batch',
      expiryDate: json['expiryDate'] ?? 'Unknown Expiry',
      shelfLocation: json['shelfLocation'] ?? 'Unknown Shelf',
      notes: json['notes'] ?? '',
      medicine: json['medicine'] != null
          ? MedicineInventoryModel.fromJson(json['medicine'])
          : null,
    );
  }
}
