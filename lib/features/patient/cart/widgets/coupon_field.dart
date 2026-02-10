import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/cubit/coupon_cubit.dart';

class CouponField extends StatelessWidget {
  CouponField({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponCubit(),
      child: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: BlocBuilder<CouponCubit, bool>(
          builder: (context, isEnabled) {
            return TextField(
              controller: _controller,
              cursorColor: AppColors.primaryDarker,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.primaryDarker,
              ),
              onChanged: (value) {
                context.read<CouponCubit>().onTextChanged(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.discount,
                  color: AppColors.primaryNormal,
                ),

                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 12.h,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      backgroundColor: isEnabled
                          ? AppColors.primaryNormal
                          : AppColors.neutralNormalHover,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: isEnabled
                        ? () {
                            context.read<CouponCubit>().submitCoupon(
                              _controller.text.trim(),
                            );
                          }
                        : null,
                    child: Text(
                      'Apply',
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralLight,
                      ),
                    ),
                  ),
                ),

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                hintText: 'Enter your coupon',
                hintStyle: AppTextStyles.medium14.copyWith(
                  color: AppColors.neutralDarkActive,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: AppColors.neutralLightActive,
                    width: 1.w,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
