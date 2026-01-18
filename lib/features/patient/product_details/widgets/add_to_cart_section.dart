import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_container.dart';

class AddToCartSection extends StatelessWidget {
  const AddToCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: InkWell(
                  onTap: () {},
                  child: StyledContainer(
                    horizontalPadding: 0,
                    verticalPadding: 16,
                    containerColor: AppColors.primaryNormal,
                    text: 'Add to cart from \$12.00',
                    textStyle: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.primaryLight,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
            8.horizontalSpace,
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryNormal,
                ),
                width: 81.w,
                height: 56.h,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/cart_medicine_icon.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Estimated Delivery at',
              style: AppTextStyles.reqular12.copyWith(
                letterSpacing: 0,
                color: AppColors.primaryDarkActive,
              ),
            ),

            Text(
              ' 11:30am',
              style: AppTextStyles.semiBold12.copyWith(
                letterSpacing: 0,
                color: AppColors.primaryDarkActive,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
