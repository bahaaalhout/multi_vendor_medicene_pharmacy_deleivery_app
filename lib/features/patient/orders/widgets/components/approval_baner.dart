import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class ApprovalBanner extends StatelessWidget {
  const ApprovalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warningLightActive,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/warning_icon.svg"),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Order Waiting for Your Approval',
              style: AppTextStyles.medium16.copyWith(color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}
