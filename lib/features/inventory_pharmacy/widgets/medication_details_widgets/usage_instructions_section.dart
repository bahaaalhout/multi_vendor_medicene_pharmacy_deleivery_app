import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/bullet_points.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/sub_header_text.dart';

class UsageInstructionsSection extends StatelessWidget {
  const UsageInstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.neutralNormal),
              ),
            ),
            child: Text(
              'Usage & Instructions',
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ),
          16.verticalSpace,
          SubHeader(title: "Dosage"),
          BulletPoint(text: "One tablet every 4–6 hours"),
          8.verticalSpace,
          BulletPoint(text: "Do not exceed 4 tablets in 24 hours"),
          16.verticalSpace,

          SubHeader(title: "Storage"),
          BulletPoint(text: "Store at room temperature"),
          8.verticalSpace,

          BulletPoint(text: "Away from moisture and heat"),
          16.verticalSpace,
          SubHeader(title: "Safety"),
          BulletPoint(text: "One tablet every 4–6 hours"),
          8.verticalSpace,

          BulletPoint(text: "Do not exceed 4 tablets in 24 hours"),
          16.verticalSpace,
          SubHeader(title: "Batch Nur"),
          BulletPoint(text: "PAC-56789-22"),
          8.verticalSpace,

          BulletPoint(text: "Store at room temperature"),
          8.verticalSpace,

          BulletPoint(text: "Away from moisture and heat"),
        ],
      ),
    );
  }
}
