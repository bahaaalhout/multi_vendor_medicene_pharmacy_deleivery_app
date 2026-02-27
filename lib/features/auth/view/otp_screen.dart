import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text('Forget Your Password', style: AppTextStyles.medium25),
            8.verticalSpace,
            RichText(
              text: TextSpan(
                text: 'Please Enter the code we send to',
                style: AppTextStyles.reqular12.copyWith(
                  color: AppColors.neutralDarkHover,
                ),
                children: [
                  TextSpan(
                    text: ' $email',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.primaryNormal,
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24.w,
              children: [OTPField(), OTPField(), OTPField(), OTPField()],
            ),
            24.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Didn’t get the code?',
                  style: AppTextStyles.reqular12.copyWith(
                    color: AppColors.neutralDarkHover,
                  ),
                  children: [
                    TextSpan(
                      text: ' Resend it',

                      style: AppTextStyles.semiBold12.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            AppButton(title: 'Verify', onPressed: () {}),
            120.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class OTPField extends StatelessWidget {
  const OTPField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 53.h,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.r),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
          ),
        ),
      ),
    );
  }
}
