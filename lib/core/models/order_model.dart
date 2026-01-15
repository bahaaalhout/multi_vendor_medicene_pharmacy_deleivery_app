import 'cart_item_model.dart';
import 'address_model.dart';

enum OrderStatus {
  placed,
  pickedUp,
  enRoute,
  delivered,
  receiveConfirmed,
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
    required this.estimatedTimeMinutes,
    required this.paymentMethod,
    this.deliveryInstructions,
    this.paymentDetails,
  });

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  String get pharmacyId => items.first.pharmacyOffer.pharmacy.id;
  String get pharmacyName => items.first.pharmacyOffer.pharmacy.name;
  AddressModel get pharmacyAddress => items.first.pharmacyOffer.pharmacy.address;
}