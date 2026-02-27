import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_summary_model.dart';

class OrderCard extends StatelessWidget {
  final MyOrderSummaryModel order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  String _statusLabel(MyOrderStatus status) {
    switch (status) {
      case MyOrderStatus.placed:
        return 'Waiting Approval';
      case MyOrderStatus.processing:
        return 'Processing';
      case MyOrderStatus.enRoute:
        return 'On the way';
      case MyOrderStatus.delivered:
        return 'Delivered';
      case MyOrderStatus.cancelled:
        return 'Cancelled';
      case MyOrderStatus.unknown:
        return 'Unknown';
    }
  }

  Color _statusColor(MyOrderStatus status) {
    switch (status) {
      case MyOrderStatus.placed:
        return Colors.orange;
      case MyOrderStatus.processing:
        return Colors.blue;
      case MyOrderStatus.enRoute:
        return Colors.indigo;
      case MyOrderStatus.delivered:
        return Colors.green;
      case MyOrderStatus.cancelled:
        return Colors.red;
      case MyOrderStatus.unknown:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _statusLabel(order.status);
    final color = _statusColor(order.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text('Order #${order.id}'),
        subtitle: Text(
          'Total: ${order.totalAmount.toStringAsFixed(2)} ${order.currency}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label, style: TextStyle(color: color)),
        ),
      ),
    );
  }
}