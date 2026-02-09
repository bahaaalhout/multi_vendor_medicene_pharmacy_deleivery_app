import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AddChip extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  const AddChip({
    super.key,
    required this.onTap,
    this.label = 'Add',
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.w, color: AppColors.primaryNormal),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.medium10.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
