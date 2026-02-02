import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

enum HistoryFilter { all, newOrder, complete, preparing }

class HistoryState {
  final HistoryFilter selectedFilter;
  final List<OrderModel> orders;
  final bool isLoading;

  HistoryState({
    this.selectedFilter = HistoryFilter.all,
    List<OrderModel>? orders,
    this.isLoading = false,
  }) : orders = orders ?? [];

  HistoryState copyWith({
    HistoryFilter? selectedFilter,
    List<OrderModel>? orders,
    bool? isLoading,
  }) {
    return HistoryState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<OrderModel> get filteredOrders {
    switch (selectedFilter) {
      case HistoryFilter.all:
        return orders;
      case HistoryFilter.newOrder:
        return orders
            .where((order) => order.status == OrderStatus.placed)
            .toList();
      case HistoryFilter.complete:
        return orders
            .where(
              (order) =>
                  order.status == OrderStatus.delivered ||
                  order.status == OrderStatus.receiveConfirmed,
            )
            .toList();
      case HistoryFilter.preparing:
        return orders
            .where(
              (order) =>
                  order.status == OrderStatus.pickedUp ||
                  order.status == OrderStatus.enRoute,
            )
            .toList();
    }
  }
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryState()) {
    loadOrders();
  }

  void loadOrders() {
    emit(state.copyWith(isLoading: true));
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(state.copyWith(
        orders: sampleOrders,
        isLoading: false,
      ));
    });
  }

  void changeFilter(HistoryFilter filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  void copyOrderId(String orderId) {
    // Handle copy to clipboard
    // You can use Flutter's Clipboard.setData here
  }
}
