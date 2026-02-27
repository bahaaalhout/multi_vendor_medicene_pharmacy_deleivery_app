import 'package:flutter/material.dart';
import '../models/my_order_summary_model.dart';

class MyOrderStatusUI {
  static String label(MyOrderStatus status) {
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

  static Color color(MyOrderStatus status) {
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
}