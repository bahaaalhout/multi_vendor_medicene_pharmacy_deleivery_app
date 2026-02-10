import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/title_of_section_of_checkout.dart';

class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleOfSectionCheckout(title: 'Price Breakdown', fun: () {}),
        16.verticalSpace,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.neutralNormal, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Column(children: [Prices(), 12.verticalSpace, TotalPrice()]),
        ),
      ],
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Total  ',
                  style: AppTextStyles.semiBold18.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
                TextSpan(
                  text: '(8 items)',
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '60',
                  style: AppTextStyles.bold24.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
                TextSpan(
                  text: '\$',
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Prices extends StatelessWidget {
  const Prices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutralNormal, width: .5),
        ),
      ),
      child: Column(
        children: [
          PriceItem(title: 'Subtotal', price: 60),
          12.verticalSpace,
          PriceItem(title: 'Deleivery Fee', price: 00),
          12.verticalSpace,
          PriceItem(title: 'Discount', price: 00),
          16.verticalSpace,
        ],
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  const PriceItem({super.key, required this.title, required this.price});
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold16.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
        Text('$price\$', style: AppTextStyles.semiBold16),
      ],
    );
  }
}
