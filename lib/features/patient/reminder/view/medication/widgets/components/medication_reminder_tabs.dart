import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

enum MedicationReminderTab { prescriptions, recent }

class MedicationReminderTabs extends StatelessWidget {
  final MedicationReminderTab selected;
  final int prescriptionsCount;
  final ValueChanged<MedicationReminderTab> onChanged;

  const MedicationReminderTabs({
    super.key,
    required this.selected,
    required this.prescriptionsCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabItem(
          title: 'Prescriptions ($prescriptionsCount active)',
          isSelected: selected == MedicationReminderTab.prescriptions,
          onTap: () => onChanged(MedicationReminderTab.prescriptions),
        ),
        SizedBox(width: 12.w),
        _TabItem(
          title: 'Frequently ordered',
          isSelected: selected == MedicationReminderTab.recent,
          onTap: () => onChanged(MedicationReminderTab.recent),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: SizedBox(
          height: 40.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.medium12.copyWith(
                  color: isSelected
                      ? AppColors.neutralDarker
                      : AppColors.neutralDark,
                ),
              ),

              SizedBox(height: 13.h),

              SizedBox(
                height: 1.h,
                width: double.infinity,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: isSelected ? 1 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutralDarker,
                      borderRadius: BorderRadius.circular(1.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
