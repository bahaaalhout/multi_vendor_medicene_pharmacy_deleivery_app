import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/pharmacy_icon.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_container.dart';

class NearbyPharmacyCard extends StatelessWidget {
  const NearbyPharmacyCard({super.key, required this.pharmacy});
  final PharmacyModel pharmacy;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.neutralLightHover,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                PharmacyIcon(),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pharmacy.name,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '${pharmacy.address.area}, ${pharmacy.address.city}',
                      style: AppTextStyles.reqular12.copyWith(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '\$12.50',
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                StyledContainer(
                  assetName: 'assets/icons/Star.svg',
                  horizontalPadding: 8,
                  verticalPadding: 7,
                  containerColor: Colors.white,
                  text: '${pharmacy.rating}',
                  textStyle: AppTextStyles.semiBold10.copyWith(
                    color: AppColors.neutralDarker,
                    letterSpacing: 0,
                  ),
                ),
                4.horizontalSpace,
                StyledContainer(
                  assetName: 'assets/icons/mingcute_time-line.svg',
                  horizontalPadding: 8,
                  verticalPadding: 7,
                  containerColor: Colors.white,
                  text: pharmacy.deliveryTime,
                  textStyle: AppTextStyles.medium10.copyWith(
                    color: AppColors.neutralDarkActive,
                    letterSpacing: 0,
                  ),
                ),
                4.horizontalSpace,
                StyledContainer(
                  assetName: 'assets/icons/distance.svg',
                  horizontalPadding: 8,
                  verticalPadding: 7,
                  containerColor: Colors.white,
                  text: '${pharmacy.distance} km',
                  textStyle: AppTextStyles.medium10.copyWith(
                    color: AppColors.neutralDarkActive,
                    fontSize: 10,
                    letterSpacing: 0,
                  ),
                ),
                Spacer(),
                StyledContainer(
                  horizontalPadding: 8,
                  verticalPadding: 8,
                  containerColor: AppColors.successLightHover,
                  text: pharmacy.deliveryFee == 0
                      ? 'Free Delivery'
                      : 'Delivery fees ${pharmacy.deliveryFee}\$',
                  textStyle: AppTextStyles.semiBold8.copyWith(
                    color: AppColors.successDarker,
                    fontSize: 8,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
