import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_offer_model.dart';

enum CartItemStatus {
  prescriptionRequired,
  prescriptionUnderReview,
  ready,
}

class CartItemModel {
  final String id;
  final PharmacyOfferModel pharmacyOffer;
  final int quantity;
  final bool requiresPrescription;
  final CartItemStatus status;
  final String? statusNote;

  const CartItemModel({
    required this.id,
    required this.pharmacyOffer,
    required this.quantity,
    required this.requiresPrescription,
    required this.status,
    this.statusNote,
  });
}
