import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/delivery_model.dart';

part 'delivery_order_state.freezed.dart';

@freezed
abstract class DeliveryOrderState with _$DeliveryOrderState {
  const factory DeliveryOrderState({
    @Default(false) bool showProductDetails,
    required DeliveryModel delivery,
  }) = _DeliveryOrderState;
}
