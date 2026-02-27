import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/helpers/order_filters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/helpers/orders_tab.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_summary_model.dart';


class OrderTabs extends StatelessWidget {
  final OrdersTab current;
  final ValueChanged<OrdersTab> onChanged;
  final List<MyOrderSummaryModel> allOrders;

  const OrderTabs({
    super.key,
    required this.current,
    required this.onChanged,
    required this.allOrders,
  });

  int _count(OrdersTab tab) => OrderFilters.applyTab(allOrders, tab).length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _tab('All', OrdersTab.all, _count(OrdersTab.all)),
          const SizedBox(width: 8),
          _tab('Active', OrdersTab.active, _count(OrdersTab.active)),
          const SizedBox(width: 8),
          _tab('Delivered', OrdersTab.delivered, _count(OrdersTab.delivered)),
          const SizedBox(width: 8),
          _tab('Cancelled', OrdersTab.cancelled, _count(OrdersTab.cancelled)),
        ],
      ),
    );
  }

  Widget _tab(String label, OrdersTab tab, int count) {
    final isSelected = tab == current;

    final bg = isSelected ? Colors.blue : Colors.blue.shade50;
    final txt = isSelected ? Colors.white : Colors.blue.shade900;
    final fw = isSelected ? FontWeight.w700 : FontWeight.w500;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$label ($count)',
              style: TextStyle(color: txt, fontWeight: fw),
            ),
          ),
        ),
      ),
    );
  }
}