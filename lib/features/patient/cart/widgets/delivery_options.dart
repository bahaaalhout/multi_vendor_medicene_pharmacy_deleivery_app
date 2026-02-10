import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/cubit/option_cubit.dart';
import 'delivery_option_widget.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OptionCubit(),
      child: Column(
        children: [
          Row(
            children: [
              Text('Delivery Options', style: AppTextStyles.bold20),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(60.r),
                onTap: () {},
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.r),
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.primaryLightActive,
                    ),
                  ),
                  child: SvgPicture.asset('assets/icons/more_icon.svg'),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              spacing: 8.h,
              children: const [
                DeliveryOptionWidget(
                  deliveryType: 'Standard',
                  deliveryIcon: 'standard_delivery',
                ),
                DeliveryOptionWidget(
                  deliveryType: 'Express',
                  deliveryIcon: 'express_delivery',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
