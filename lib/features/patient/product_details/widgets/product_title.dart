import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 1,
                  color: AppColors.successLightActive,
                ),
              ),
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: AppColors.successDarkHover,
                ),
              ),
            ),
            4.horizontalSpace,
            StyledText(title: 'Available'),
            4.horizontalSpace,
            Text(
              '(in stock)',
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ],
        ),
        Text(
          name,
          style: AppTextStyles.reqular16.copyWith(
            color: AppColors.primaryDark,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
            decorationColor: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }
}
