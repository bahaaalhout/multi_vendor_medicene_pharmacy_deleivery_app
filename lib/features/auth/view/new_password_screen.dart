import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  String password = '';
  String confirmPassword = '';

  bool obscureNew = true;
  bool obscureConfirm = true;

  bool get isMatching =>
      password == confirmPassword && confirmPassword.isNotEmpty;
  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(password);
  bool get hasSpecial => RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);

  bool get isPasswordValid =>
      hasMinLength && hasUppercase && hasNumber && hasSpecial;

  bool get isFormValid =>
      isPasswordValid &&
      password == confirmPassword &&
      confirmPassword.isNotEmpty;
  void _submit() {
    print("Password reset success");
    // Call API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text('New Password', style: AppTextStyles.medium25),
            8.verticalSpace,
            Text(
              'Please write your new password',
              style: AppTextStyles.medium14,
            ),
            32.verticalSpace,

            /// New Password Field
            TextFormField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: obscureNew,
              decoration: InputDecoration(
                hintText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureNew ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.neutralNormalActive,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureNew = !obscureNew;
                    });
                  },
                ),
                hintStyle: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralNormalActive,
                ),
                contentPadding: EdgeInsets.all(16.r),
                border: _border(),
                enabledBorder: _border(),
                focusedBorder: _border(),
              ),
            ),

            16.verticalSpace,

            /// Confirm Password Field
            TextFormField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              obscureText: obscureConfirm,
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirm ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.neutralNormalActive,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirm = !obscureConfirm;
                    });
                  },
                ),
                hintStyle: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralNormalActive,
                ),
                contentPadding: EdgeInsets.all(16.r),
                border: _border(),
                enabledBorder: _border(),
                focusedBorder: _border(),
              ),
            ),

            /// Match validation
            if (confirmPassword.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Row(
                  children: [
                    Icon(
                      isMatching ? Icons.check_circle : Icons.cancel,
                      size: 14.sp,
                      color: isMatching ? Colors.green : Colors.red,
                    ),
                    6.horizontalSpace,
                    Text(
                      isMatching ? 'Passwords match' : 'Passwords do not match',
                      style: AppTextStyles.reqular10.copyWith(
                        color: isMatching ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

            16.verticalSpace,

            PasswordRequirements(password: password),
            24.verticalSpace,

            AbsorbPointer(
              absorbing: !isFormValid,
              child: Opacity(
                opacity: isFormValid ? 1 : 0.5,
                child: AppButton(
                  title: 'Reset',
                  onPressed: () {
                    _submit();
                    context.go(AppRoutes.login);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.r),
      borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
    );
  }
}

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(password);
  bool get hasSpecial => RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);

  Widget _buildRequirement(String text, bool isValid) {
    final color = isValid ? Colors.green : AppColors.neutralDark;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 14.sp,
            color: isValid ? Colors.green : AppColors.neutralNormal,
          ),
          6.horizontalSpace,
          Text(text, style: AppTextStyles.reqular10.copyWith(color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Requirements',
          style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDark),
        ),
        6.verticalSpace,
        _buildRequirement('At least 8 characters', hasMinLength),
        _buildRequirement('At least one uppercase letter', hasUppercase),
        _buildRequirement('At least one number', hasNumber),
        _buildRequirement(
          'Includes one special character (e.g., ! @ # \$)',
          hasSpecial,
        ),
      ],
    );
  }
}
