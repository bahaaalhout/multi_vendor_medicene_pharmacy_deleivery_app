import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CreateButton extends StatelessWidget {
  final int count;
  final bool isDifferent;
  final VoidCallback onTap;

  const CreateButton({
    super.key,
    required this.count,
    required this.isDifferent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Create Reminder'
        : (isDifferent
              ? 'Create reminders separately'
              : 'Create Reminder for $count Medications');

    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Material(
        color: AppColors.primaryNormal,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
