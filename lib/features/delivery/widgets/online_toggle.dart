
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OnlineToggle extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onChanged;

  const OnlineToggle({required this.isOnline, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('Online/Offline', style: AppTextStyles.reqular20),
          ),
          SizedBox(
            height: AppSizes.spacing34.h,
            child: Switch(
              value: isOnline,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.successNormalHover,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.neutralNormal,
              onChanged: (value) {
                onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}