import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/cubit/option_cubit.dart';

class DeliveryOptionWidget extends StatelessWidget {
  const DeliveryOptionWidget({
    super.key,
    required this.deliveryType,
    required this.deliveryIcon,
  });

  final String deliveryType;
  final String deliveryIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionCubit, String?>(
      builder: (context, selectedType) {
        final bool isSelected = selectedType == deliveryType;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              context.read<OptionCubit>().select(deliveryType);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  width: 1,
                  color: isSelected
                      ? AppColors.primaryDarker
                      : Colors.transparent,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/$deliveryIcon.svg'),
                      12.horizontalSpace,
                      Text(
                        '$deliveryType Delivery',
                        style: AppTextStyles.semiBold16,
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '3.00',
                              style: AppTextStyles.semiBold18.copyWith(
                                color: AppColors.successDark,
                              ),
                            ),
                            TextSpan(
                              text: '\$',
                              style: AppTextStyles.semiBold12.copyWith(
                                color: AppColors.successDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  16.verticalSpace,

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: AppColors.neutralLightActive,
                        ),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '30-45',
                            style: AppTextStyles.medium14.copyWith(
                              color: AppColors.neutralDarkActive,
                            ),
                          ),
                          TextSpan(
                            text: ' min • Secure handling',
                            style: AppTextStyles.reqular14.copyWith(
                              color: AppColors.neutralDarkActive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
