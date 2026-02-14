enum StockStatus { inStock, lowStock, outOfStock }

class InventoryModel {
  final String id;
  final String name;
  final String manufacturer;
  final String quantity;
  final String expiry;
  final StockStatus status;

  InventoryModel({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.quantity,
    required this.expiry,
    required this.status,
  });
}
