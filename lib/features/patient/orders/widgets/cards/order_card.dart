import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/helpers/order_actions_menu.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_details_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/models/my_order_summary_model.dart';




class OrderCard extends StatefulWidget {
  final MyOrderSummaryModel order;
  final MyOrderDetailsModel? details; 

  const OrderCard({
    super.key,
    required this.order,
    this.details,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isBlurred = false;
  final GlobalKey _moreKey = GlobalKey();

  Future<void> _openMenuAt(Offset position) async {
    setState(() => _isBlurred = true);

    await showOrderActionsMenu(
      context: context,
      tapPosition: position,
      order: widget.order,
    );

    if (mounted) setState(() => _isBlurred = false);
  }

  Future<void> _openMenuFromMoreIcon() async {
    final ctx = _moreKey.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox;
    final topLeft = box.localToGlobal(Offset.zero);
    final size = box.size;

    final anchor = Offset(topLeft.dx + size.width, topLeft.dy + size.height);
    await _openMenuAt(anchor);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (d) => _openMenuAt(d.globalPosition),
      child: Stack(
        children: [
          _CardContent(
            order: widget.order,
            details: widget.details,
            moreKey: _moreKey,
            onMoreTap: _openMenuFromMoreIcon,
          ),
          if (_isBlurred)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0.08)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final MyOrderSummaryModel order;
  final MyOrderDetailsModel? details;
  final GlobalKey moreKey;
  final VoidCallback onMoreTap;

  const _CardContent({
    required this.order,
    required this.details,
    required this.moreKey,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusUi = _MyOrderStatusUI.from(order.status);

    // ✅ Info rows
    final addressText = details?.deliveryAddress.addressText;
    final driverName = details?.delivery?.driver?.name;
    final driverPhone = details?.delivery?.driver?.phoneNumber;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: order.status == MyOrderStatus.enRoute
            ? const Color(0xFFF1F3FF)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutralNormal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Order #${order.id}',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.primaryDarkActive,
                ),
              ),
              SizedBox(width: 8.w),
              _StatusPill(ui: statusUi),
              const Spacer(),
              InkWell(
                key: moreKey,
                borderRadius: BorderRadius.circular(10.r),
                onTap: onMoreTap,
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: Icon(Icons.more_horiz, size: 20.sp),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Text(
            _dateLine(order.createdAt),
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.primaryNormal,
            ),
          ),

          SizedBox(height: 12.h),

          // ✅ InfoRow 1: Address (لو مش موجود اعرض نص افتراضي)
          _InfoRow(
            leading: SvgPicture.asset("assets/icons/location_icon.svg"),
            text: (addressText?.trim().isNotEmpty ?? false)
                ? addressText!.trim()
                : 'Delivery address not set',
          ),

          SizedBox(height: 8.h),

          // ✅ InfoRow 2: Driver (اختياري)
          _InfoRow(
            leading: SvgPicture.asset("assets/icons/user_icon.svg"),
            text: (driverName?.trim().isNotEmpty ?? false)
                ? 'Driver: $driverName${(driverPhone?.trim().isNotEmpty ?? false) ? ' • $driverPhone' : ''}'
                : 'Driver not assigned yet',
          ),

          // ✅ Divider after 2 info rows
          SizedBox(height: 12.h),
          Divider(
            height: 1,
            thickness: 0.6,
            color: AppColors.neutralNormal.withOpacity(0.35),
          ),
          SizedBox(height: 12.h),

          // Footer totals
          Row(
            children: [
              Text(
                statusUi.shortLabel,
                style: AppTextStyles.reqular12.copyWith(
                  color: AppColors.neutralDark,
                ),
              ),
              const Spacer(),
              Text(
                'Total: ${order.totalAmount.toStringAsFixed(2)} ${order.currency}',
                style: AppTextStyles.reqular12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dateLine(DateTime date) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December',
    ];
    final m = months[date.month - 1];
    return 'Ordered on $m ${date.day}, ${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final Widget leading;
  final String text;

  const _InfoRow({required this.leading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18.w,
          height: 18.w,
          child: FittedBox(fit: BoxFit.contain, child: leading),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.medium14.copyWith(
              color: const Color.fromRGBO(51, 51, 51, 1),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final _MyOrderStatusUI ui;
  const _StatusPill({required this.ui});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ui.bg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ui.border),
      ),
      child: Text(
        ui.label,
        style: AppTextStyles.medium12.copyWith(color: ui.text),
      ),
    );
  }
}

/// ✅ بديل OrderStatusUI لكن لموديلك MyOrderStatus
class _MyOrderStatusUI {
  final String label;
  final String shortLabel;
  final Color bg;
  final Color border;
  final Color text;

  _MyOrderStatusUI({
    required this.label,
    required this.shortLabel,
    required this.bg,
    required this.border,
    required this.text,
  });

  static _MyOrderStatusUI from(MyOrderStatus s) {
    switch (s) {
      case MyOrderStatus.enRoute:
        return _MyOrderStatusUI(
          label: 'En route',
          shortLabel: 'On the way',
          bg: AppColors.warningLightActive,
          border: AppColors.warningNormalActive,
          text: AppColors.warningDark,
        );

      case MyOrderStatus.processing:
        return _MyOrderStatusUI(
          label: 'Processing',
          shortLabel: 'Processing',
          bg: AppColors.primaryLight,
          border: AppColors.primaryDark,
          text: AppColors.primaryNormal,
        );

      case MyOrderStatus.delivered:
        return _MyOrderStatusUI(
          label: 'Delivered',
          shortLabel: 'Delivered',
          bg: AppColors.successLightActive,
          border: AppColors.successNormalActive,
          text: AppColors.successNormalActive,
        );

      case MyOrderStatus.cancelled:
        return _MyOrderStatusUI(
          label: 'Cancelled',
          shortLabel: 'Cancelled',
          bg: AppColors.errorLightActive,
          border: AppColors.errorDark,
          text: AppColors.errorNormalActive,
        );

      case MyOrderStatus.placed:
        return _MyOrderStatusUI(
          label: 'Placed',
          shortLabel: 'Placed',
          bg: AppColors.primaryLight,
          border: AppColors.primaryDark,
          text: AppColors.primaryNormal,
        );

      case MyOrderStatus.unknown:
        return _MyOrderStatusUI(
          label: 'Unknown',
          shortLabel: 'Unknown',
          bg: AppColors.neutralLight,
          border: AppColors.neutralNormal,
          text: AppColors.neutralDark,
        );
    }
  }
}