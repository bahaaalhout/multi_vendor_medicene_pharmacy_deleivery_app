import 'package:flutter_bloc/flutter_bloc.dart';
import 'pharmacy_orders_state.dart';
import '../../../../data/fake_data.dart';
import '../../../../core/models/order_model.dart';

class PharmacyOrdersCubit extends Cubit<PharmacyOrdersState> {
  PharmacyOrdersCubit() : super(PharmacyOrdersState(orders: sampleOrders)) {
    _filterOrders();
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _filterOrders();
  }

  void updateStatusFilter(OrderStatusFilter filter) {
    emit(state.copyWith(selectedStatusFilter: filter));
    _filterOrders();
  }

  void _filterOrders() {
    List<OrderModel> filtered = state.orders;

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        return order.customerName.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
               order.id.toLowerCase().contains(state.searchQuery.toLowerCase());
      }).toList();
    }

    // Apply status filter
    if (state.selectedStatusFilter != OrderStatusFilter.all) {
      filtered = filtered.where((order) {
        switch (state.selectedStatusFilter) {
          case OrderStatusFilter.newOrders:
            return order.status == OrderStatus.placed;
          case OrderStatusFilter.delivered:
            return order.status == OrderStatus.delivered;
          case OrderStatusFilter.past:
            return order.status == OrderStatus.receiveConfirmed;
          default:
            return true;
        }
      }).toList();
    }

    emit(state.copyWith(filteredOrders: filtered));
  }
}