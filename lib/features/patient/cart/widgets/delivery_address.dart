import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/checkout_text_field.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/title_of_section_of_checkout.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleOfSectionCheckout(title: 'Delivery Address', fun: () {}),
        24.verticalSpace,
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.all(16.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: AppColors.neutralNormal, width: 1.w),
          ),
          leading: Icon(
            Icons.my_location,
            size: 24.r,
            color: AppColors.secondaryNormal,
          ),
          title: Text(
            'Use Your Current Location',
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primaryDarker,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryNormal,
          ),
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(color: AppColors.neutralNormal, thickness: 1),
            ),
            16.horizontalSpace,
            Text(
              'OR',
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Divider(color: AppColors.neutralNormal, thickness: 1),
            ),
          ],
        ),
        16.verticalSpace,
        CheckOutTextField(
          controller: TextEditingController(),
          hintText: 'Address line 1',
        ),
        8.verticalSpace,
        CheckOutTextField(
          controller: TextEditingController(),
          hintText: 'Address line 2',
        ),
        8.verticalSpace,
        CheckOutTextField(
          controller: TextEditingController(),
          hintText: 'Street Number',
        ),
        8.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CheckOutTextField(
                controller: TextEditingController(),
                hintText: 'City, State',
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: CheckOutTextField(
                controller: TextEditingController(),
                hintText: 'Postal Code',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
