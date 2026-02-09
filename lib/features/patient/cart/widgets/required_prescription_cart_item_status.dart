import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RequiredPrescriptionCartItemStatus extends StatelessWidget {
  const RequiredPrescriptionCartItemStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.warningLightActive,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: ListTile(
            leading: Icon(Icons.upload),

            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Upload Prescription ',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                  TextSpan(
                    text: '(required)',
                    style: AppTextStyles.semiBold10.copyWith(
                      color: AppColors.warningDarker,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        12.verticalSpace,

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('• '),
            Expanded(
              child: Text(
                'You can’t go for checkout without uploading the prescription',
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.neutralDarker,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
