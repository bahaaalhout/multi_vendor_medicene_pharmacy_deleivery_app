import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_details_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_summary_model.dart';


enum OrderMenuAction { trackOrder, viewDetails }

Future<OrderMenuAction?> showOrderActionsMenu({
  required BuildContext context,
  required Offset tapPosition,
  required MyOrderSummaryModel order,
  MyOrderDetailsModel? details, 
}) async {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  // Menu position near the long-press / anchor
  final position = RelativeRect.fromRect(
    Rect.fromPoints(tapPosition, tapPosition),
    Offset.zero & overlay.size,
  );

  return showMenu<OrderMenuAction>(
    context: context,
    position: position,
    color: Colors.transparent, // we render our own container
    elevation: 0,
    items: [
      PopupMenuItem<OrderMenuAction>(
        enabled: false,
        padding: EdgeInsets.zero,
        child: _OrderMenuCard(order: order, details: details),
      ),
    ],
  );
}

class _OrderMenuCard extends StatelessWidget {
  final MyOrderSummaryModel order;
  final MyOrderDetailsModel? details;

  const _OrderMenuCard({
    required this.order,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 220.w,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              blurRadius: 18,
              spreadRadius: 0,
              offset: Offset(0, 8),
              color: Color(0x22000000),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuButton(
              title: 'Track Order',
              isPrimary: true,
              onTap: () {
                Navigator.pop(context, OrderMenuAction.trackOrder);
              },
            ),
            SizedBox(height: 10.h),
            _MenuButton(
              title: 'View Details',
              isPrimary: false,
              onTap: () {
                Navigator.pop(context, OrderMenuAction.viewDetails);
              },
            ),
            SizedBox(height: 10.h),
            _EtaChip(text: estimatedDeliveryText(order, details)),
          ],
        ),
      ),
    );
  }

  ///  ETA UX:

  String estimatedDeliveryText(MyOrderSummaryModel order, MyOrderDetailsModel? details) {
    final estimatedMinutes = _estimateMinutesFromStatus(order.status);

    final now = DateTime.now();
    final eta = now.add(Duration(minutes: estimatedMinutes));

    final time = _format12h(eta);
    final today = _isSameDay(now, eta);

    final header = 'Estimated delivery';
    if (today) return '$header\nToday, $time';
    return '$header\n${_month(eta.month)} ${eta.day}, $time';
  }

  int _estimateMinutesFromStatus(MyOrderStatus s) {
    switch (s) {
      case MyOrderStatus.placed:
        return 45;
      case MyOrderStatus.processing:
        return 30;
      case MyOrderStatus.enRoute:
        return 15;
      case MyOrderStatus.delivered:
        return 0;
      case MyOrderStatus.cancelled:
        return 0;
      case MyOrderStatus.unknown:
        return 35;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _format12h(DateTime d) {
    int h = d.hour % 12;
    if (h == 0) h = 12;
    final m = d.minute.toString().padLeft(2, '0');
    final ap = d.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ap';
  }

  String _month(int m) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[m - 1];
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2F4BB8);

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isPrimary ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: primaryColor,
            width: 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isPrimary ? Colors.white : primaryColor,
          ),
        ),
      ),
    );
  }
}

class _EtaChip extends StatelessWidget {
  final String text;
  const _EtaChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD6F3DF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2E7D32),
          height: 1.25,
        ),
      ),
    );
  }
}