import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/orders_repository.dart';
import '../helpers/order_filters.dart';
import '../helpers/orders_tab.dart';
import '../models/my_order_summary_model.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersInitialState());

  Future<void> fetchOrders() async {
    emit(OrdersLoadingState(
      allOrders: state.allOrders,
      visibleOrders: state.visibleOrders,
      tab: state.tab,
    ));

    try {
      final orders = await OrdersRepository.fetchMyOrders(
        page: 1,
        limit: 50,
      );

      final filtered = OrderFilters.applyTab(orders, state.tab);

      emit(OrdersSuccessState(
        allOrders: orders,
        visibleOrders: _sortOrders(filtered),
        tab: state.tab,
      ));
    } catch (e) {
      log('fetchOrders error: $e');

      emit(OrdersErrorState(
        message: e.toString(),
        allOrders: state.allOrders,
        visibleOrders: state.visibleOrders,
        tab: state.tab,
      ));
    }
  }

  void changeTab(OrdersTab tab) {
    final filtered = OrderFilters.applyTab(state.allOrders, tab);

    emit(OrdersSuccessState(
      allOrders: state.allOrders,
      visibleOrders: _sortOrders(filtered),
      tab: tab,
    ));
  }

  List<MyOrderSummaryModel> _sortOrders(List<MyOrderSummaryModel> orders) {
    final list = [...orders];

    list.sort((a, b) {
      final ap = _priority(a.status);
      final bp = _priority(b.status);

      if (ap != bp) return ap.compareTo(bp);
      return b.createdAt.compareTo(a.createdAt);
    });

    return list;
  }

  int _priority(MyOrderStatus status) {
    switch (status) {
      case MyOrderStatus.enRoute:
        return 0;
      case MyOrderStatus.processing:
      case MyOrderStatus.placed:
        return 1;
      case MyOrderStatus.delivered:
        return 2;
      case MyOrderStatus.cancelled:
        return 3;
      case MyOrderStatus.unknown:
        return 4;
    }
  }
}