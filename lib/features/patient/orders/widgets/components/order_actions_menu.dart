import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

enum OrderMenuAction { trackOrder, viewDetails }

Future<OrderMenuAction?> showOrderActionsMenu({
  required BuildContext context,
  required Offset tapPosition,
  required OrderModel order,
}) async {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  // Menu position near the long-press point
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
        child: _OrderMenuCard(order: order),
      ),
    ],
  );
}

class _OrderMenuCard extends StatelessWidget {
  final OrderModel order;
  const _OrderMenuCard({required this.order});

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
            _EtaChip(text: _estimatedDeliveryText(order)),
          ],
        ),
      ),
    );
  }

  // ✅ FIXED TIME: ETA = NOW + estimatedTimeMinutes
  // This matches typical UX and avoids wrong times when createdAt is old.
  String _estimatedDeliveryText(OrderModel order) {
    final now = DateTime.now();
    final eta = now.add(Duration(minutes: order.estimatedTimeMinutes.round()));

    final time = _format12h(eta);
    final today = _isSameDay(now, eta);

    if (today) {
      return 'Estimated delivery\nToday, $time';
    }
    return 'Estimated delivery\n${_month(eta.month)} ${eta.day}, $time';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

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
    final primaryColor = const Color(0xFF2F4BB8);

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primaryNormal : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: primaryColor, width: 1.2),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.medium12.copyWith(
            color: isPrimary ? Colors.white : AppColors.primaryNormal,
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
        color: AppColors.successLightActive,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.medium10.copyWith(color: AppColors.successDark),
      ),
    );
  }
}
