import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/add_reminder_widgets/reminder_badge_group.dart';
import '../../models/reminder_item.dart';

class ReminderListItem extends StatelessWidget {
  final ReminderItem item;

  const ReminderListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final t = item.time;
    final hour12 = (t.hour % 12 == 0) ? 12 : (t.hour % 12);
    final ampm = (t.hour >= 12) ? 'pm' : 'am';
    final timeText = '$hour12:${t.minute.toString().padLeft(2, '0')} $ampm';

    final qtyText = _qtyLabel(item.medicine.quantity, item.medicine.form);
    final strengthText = item.medicine.strength;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: item.done
            ? AppColors.neutralLightHover
            : const Color.fromRGBO(239, 243, 251, 1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE9EDF3)),
        boxShadow: item.done
            ? []
            : [
                const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.network(
              item.medicine.imageUrls.first,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 24),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.medicine.brandName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryNormal,
                  ),
                ),
                SizedBox(height: 4.h),
                ReminderBadgeGroup(
                  isCompleted: item.done,
                  quantityText: qtyText,
                  strengthText: strengthText,
                  doseCount: item.dose,
                  timeText: timeText,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(
            item.done
                ? 'assets/icons/done_icon.svg'
                : 'assets/icons/wait_icon.svg',
          ),
        ],
      ),
    );
  }
}

String _qtyLabel(int qty, FormType form) {
  final unit = switch (form) {
    FormType.tablet => 'Tablet',
    FormType.capsule => 'Capsule',
    FormType.syrup => 'Bottle',
    FormType.injection => 'Injection',
    FormType.cream => 'Cream',
    FormType.ointment => 'Ointment',
  };
  return qty == 1 ? '1 $unit' : '$qty ${unit}s';
}
