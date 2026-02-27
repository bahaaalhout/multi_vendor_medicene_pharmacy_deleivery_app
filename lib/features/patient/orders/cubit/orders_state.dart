import '../helpers/orders_tab.dart';
import '../models/my_order_summary_model.dart';

abstract class OrdersState {
  final List<MyOrderSummaryModel> allOrders;
  final List<MyOrderSummaryModel> visibleOrders;
  final OrdersTab tab;

  const OrdersState({
    required this.allOrders,
    required this.visibleOrders,
    required this.tab,
  });
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState()
      : super(allOrders: const [], visibleOrders: const [], tab: OrdersTab.all);
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState({
    required super.allOrders,
    required super.visibleOrders,
    required super.tab,
  });
}

class OrdersSuccessState extends OrdersState {
  const OrdersSuccessState({
    required super.allOrders,
    required super.visibleOrders,
    required super.tab,
  });
}

class OrdersErrorState extends OrdersState {
  final String message;

  const OrdersErrorState({
    required this.message,
    required super.allOrders,
    required super.visibleOrders,
    required super.tab,
  });
}