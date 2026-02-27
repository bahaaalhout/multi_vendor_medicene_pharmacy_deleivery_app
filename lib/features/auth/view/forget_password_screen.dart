import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
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
            Text(
              'Please write your email to receive a confirmation code to set a new password.',
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.neutralDarkHover,
              ),
            ),
            24.verticalSpace,
            TextFormField(
              controller: emailController,
              onChanged: (String p1) {
                p1;
              },
              decoration: InputDecoration(
                hintStyle: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralNormalActive,
                ),
                contentPadding: EdgeInsets.all(16.r),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: BorderSide(
                    color: AppColors.neutralNormal,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: BorderSide(
                    color: AppColors.neutralNormal,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.r),
                  borderSide: BorderSide(
                    color: AppColors.neutralNormal,
                    width: 1,
                  ),
                ),
              ),
            ),
            240.verticalSpace,
            AppButton(
              title: 'Send Code',
              onPressed: () {
                if (emailController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your email")),
                  );
                  return;
                }
                context.push(AppRoutes.otp, extra: emailController.text.trim());
              },
            ),
          ],
        ),
      ),
    );
  }
}
