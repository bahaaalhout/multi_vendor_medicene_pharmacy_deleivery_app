import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';

import 'cart_item_model.dart';
import 'address_model.dart';

enum OrderStatus {
  placed,
  pickedUp,
  enRoute,
  delivered,
  receiveConfirmed,
  cancelled,
}

class OrderModel {
  final String id;
  final OrderStatus status;
  final List<CartItemModel> items;
  final AddressModel deliveryAddress;
  final DateTime createdAt;
  final String? deliveryInstructions;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String? customerImageUrl;
  final double estimatedTimeMinutes;
  final String paymentMethod;
  final String? paymentDetails;

  const OrderModel({
    required this.id,
    required this.status,
    required this.items,
    required this.deliveryAddress,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    this.customerImageUrl,
    required this.estimatedTimeMinutes,
    required this.paymentMethod,
    this.deliveryInstructions,
    this.paymentDetails,
  });

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  PharmacyModel get pharmacy => items.first.pharmacyOffer.pharmacy;
  String get pharmacyId => items.first.pharmacyOffer.pharmacy.id;
  String get pharmacyName => items.first.pharmacyOffer.pharmacy.name;
  AddressModel get pharmacyAddress =>
      items.first.pharmacyOffer.pharmacy.address;
}
