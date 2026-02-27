import '../models/my_order_summary_model.dart';
import 'orders_tab.dart';

class OrderFilters {
  static List<MyOrderSummaryModel> applyTab(
    List<MyOrderSummaryModel> orders,
    OrdersTab tab,
  ) {
    switch (tab) {
      case OrdersTab.all:
        return orders;

      case OrdersTab.active:
        return orders.where((o) {
          return o.status != MyOrderStatus.delivered &&
              o.status != MyOrderStatus.cancelled;
        }).toList();

      case OrdersTab.delivered:
        return orders
            .where((o) => o.status == MyOrderStatus.delivered)
            .toList();

      case OrdersTab.cancelled:
        return orders
            .where((o) => o.status == MyOrderStatus.cancelled)
            .toList();
    }
  }
}