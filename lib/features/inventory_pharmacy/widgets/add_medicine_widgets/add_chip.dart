import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  final String label;

  final Color bg;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusChip({
    super.key,
    required this.label,

    required this.bg,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1.0 : 0.3,
        child: Container(
          alignment: Alignment.center,
          height: 29.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.neutralDarkActive,
            ),
          ),
        ),
      ),
    );
  }
}
