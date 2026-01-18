import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'info_chip.dart';

class DeliveryInfoChips extends StatelessWidget {
  final double timeMinutes;
  final double distanceKm;
  final Widget? deliveryInfoBadge;

  const DeliveryInfoChips({
    super.key,
    required this.timeMinutes,
    required this.distanceKm,
    this.deliveryInfoBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoChip(
          icon: Icons.access_time,
          text: FormattingUtils.formatTime(timeMinutes),
        ),
        SizedBox(width: AppSizes.spacing8.w),
        InfoChip(
          icon: Icons.route,
          text: FormattingUtils.formatDistance(distanceKm),
        ),
        const Spacer(),

        if (deliveryInfoBadge != null) deliveryInfoBadge!,
      ],
    );
  }
}
