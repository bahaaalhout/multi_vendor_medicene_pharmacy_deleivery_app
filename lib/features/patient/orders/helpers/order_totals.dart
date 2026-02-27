import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/cart_item_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';

extension OrderTotals on OrderModel {
  double get totalPrice {
    return items.fold<double>(0, (sum, item) => sum + _itemTotal(item));
  }

  double _itemTotal(CartItemModel item) {
    final offer = item.pharmacyOffer;

    final unit = (offer.discountedPrice != null && offer.discountedPrice! > 0)
        ? offer.discountedPrice!
        : offer.price;

    return unit * item.quantity;
  }
}