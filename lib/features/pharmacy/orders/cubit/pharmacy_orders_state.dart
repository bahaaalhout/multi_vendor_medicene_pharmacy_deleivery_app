import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/order_model.dart';

part 'pharmacy_orders_state.freezed.dart';

@freezed
abstract class PharmacyOrdersState with _$PharmacyOrdersState {
  const factory PharmacyOrdersState({
    @Default('Pharmcy Name') String pharmacyName,
    @Default('') String searchQuery,
    @Default(OrderStatusFilter.all) OrderStatusFilter selectedStatusFilter,
    @Default(<OrderModel>[]) List<OrderModel> orders,
    @Default(<OrderModel>[]) List<OrderModel> filteredOrders,
  }) = _PharmacyOrdersState;
}

enum OrderStatusFilter {
  all,
  newOrders,
  delivered,
  past
}