import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/checkout_text_field.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        12.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutralLightActive, width: .5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 12.h,
            children: [
              CheckOutTextField(
                controller: TextEditingController(),
                hintText: 'User Name',
              ),
              CheckOutTextField(
                controller: TextEditingController(),
                hintText: 'Write your email address',
              ),
              Row(
                children: [
                  CountryCodePicker(
                    favorite: ['PS', 'EG', 'SA', 'AE', 'OM', 'IQ'],
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.neutralLightActive,
                        width: .5,
                      ),
                    ),
                    initialSelection: 'PS',
                    padding: EdgeInsets.zero,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CheckOutTextField(
                      controller: TextEditingController(),
                      hintText: 'Enter phone number',
                      keyType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
