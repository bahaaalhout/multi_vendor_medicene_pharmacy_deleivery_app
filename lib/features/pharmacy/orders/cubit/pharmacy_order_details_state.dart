import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';
import '../../../../core/models/order_model.dart';

part 'pharmacy_order_details_state.freezed.dart';

@freezed
abstract class PharmacyOrderDetailsState with _$PharmacyOrderDetailsState {
  const factory PharmacyOrderDetailsState({
    @Default('') String pharmacyName,
  }) = _PharmacyOrderDetailsState;
}

