class MyDeliveryAddressModel {
  final String addressText;
  final double lat;
  final double lng;

  MyDeliveryAddressModel({
    required this.addressText,
    required this.lat,
    required this.lng,
  });

  factory MyDeliveryAddressModel.fromJson(Map json) {
    return MyDeliveryAddressModel(
      addressText: (json['addressText'] ?? '').toString(),
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }
}

class MyOrderItemModel {
  final int inventoryId;
  final int medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  MyOrderItemModel({
    required this.inventoryId,
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory MyOrderItemModel.fromJson(Map json) {
    return MyOrderItemModel(
      inventoryId: (json['inventoryId'] ?? 0) as int,
      medicineId: (json['medicineId'] ?? 0) as int,
      medicineName: (json['medicineName'] ?? '').toString(),
      quantity: (json['quantity'] ?? 0) as int,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }
}

class MyPharmacyOrderModel {
  final int pharmacyOrderId;
  final int pharmacyId;
  final String pharmacyName;
  final String status;
  final double subtotal;
  final bool requiresPrescription;
  final String prescriptionStatus;
  final List<MyOrderItemModel> items;
  final String rejectionReason;

  MyPharmacyOrderModel({
    required this.pharmacyOrderId,
    required this.pharmacyId,
    required this.pharmacyName,
    required this.status,
    required this.subtotal,
    required this.requiresPrescription,
    required this.prescriptionStatus,
    required this.items,
    required this.rejectionReason,
  });

  factory MyPharmacyOrderModel.fromJson(Map json) {
    List<MyOrderItemModel> items = [];
    if (json['items'] is List) {
      for (Map it in json['items']) {
        items.add(MyOrderItemModel.fromJson(it));
      }
    }

    return MyPharmacyOrderModel(
      pharmacyOrderId: (json['pharmacyOrderId'] ?? 0) as int,
      pharmacyId: (json['pharmacyId'] ?? 0) as int,
      pharmacyName: (json['pharmacyName'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      requiresPrescription: (json['requiresPrescription'] ?? false) as bool,
      prescriptionStatus: (json['prescriptionStatus'] ?? '').toString(),
      items: items,
      rejectionReason: (json['rejectionReason'] ?? '').toString(),
    );
  }
}

class MyDriverModel {
  final int id;
  final String name;
  final String phoneNumber;

  MyDriverModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory MyDriverModel.fromJson(Map json) {
    return MyDriverModel(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
    );
  }
}

class MyDeliveryModel {
  final int id;
  final String status;
  final MyDriverModel? driver;

  MyDeliveryModel({
    required this.id,
    required this.status,
    required this.driver,
  });

  factory MyDeliveryModel.fromJson(Map json) {
    final driverJson = json['driver'];
    return MyDeliveryModel(
      id: (json['id'] ?? 0) as int,
      status: (json['status'] ?? '').toString(),
      driver: driverJson is Map ? MyDriverModel.fromJson(driverJson) : null,
    );
  }
}

class MyOrderDetailsModel {
  final int id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  final double subAmount;
  final double deliveryFee;
  final double totalAmount;
  final String currency;

  final MyDeliveryAddressModel deliveryAddress;
  final List<MyPharmacyOrderModel> pharmacyOrders;
  final MyDeliveryModel? delivery;

  MyOrderDetailsModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subAmount,
    required this.deliveryFee,
    required this.totalAmount,
    required this.currency,
    required this.deliveryAddress,
    required this.pharmacyOrders,
    required this.delivery,
  });

  factory MyOrderDetailsModel.fromJson(Map json) {
    List<MyPharmacyOrderModel> pharmacyOrders = [];
    if (json['pharmacyOrders'] is List) {
      for (Map po in json['pharmacyOrders']) {
        pharmacyOrders.add(MyPharmacyOrderModel.fromJson(po));
      }
    }

    final addressJson =
        json['deliveryAddress'] is Map ? json['deliveryAddress'] : {};
    final deliveryJson = json['delivery'];

    return MyOrderDetailsModel(
      id: (json['id'] ?? 0) as int,
      status: (json['status'] ?? '').toString(),
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
              DateTime.now(),
      updatedAt:
          DateTime.tryParse((json['updatedAt'] ?? '').toString()) ??
              DateTime.now(),
      subAmount: (json['subAmount'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: (json['currency'] ?? 'ILS').toString(),
      deliveryAddress: MyDeliveryAddressModel.fromJson(addressJson),
      pharmacyOrders: pharmacyOrders,
      delivery: deliveryJson is Map ? MyDeliveryModel.fromJson(deliveryJson) : null,
    );
  }
}