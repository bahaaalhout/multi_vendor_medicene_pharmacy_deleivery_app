import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatelessWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  NavigateBackButton(),
                  20.horizontalSpace,
                  Text(
                    'Change your password',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 20.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.verticalSpace,
                    // Subtitle
                    Text(
                      'Protect your account with strong password.',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                    32.verticalSpace,
                    // Current password field
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return _buildPasswordField(
                          label: 'Current password',
                          value: state.currentPassword,
                          showPassword: state.showCurrentPassword,
                          onChanged: (value) {
                            context
                                .read<ChangePasswordCubit>()
                                .updateCurrentPassword(value);
                          },
                          onToggleVisibility: () {
                            context
                                .read<ChangePasswordCubit>()
                                .toggleCurrentPasswordVisibility();
                          },
                        );
                      },
                    ),
                    24.verticalSpace,
                    // New password field
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPasswordField(
                              label: 'New password',
                              value: state.newPassword,
                              showPassword: state.showNewPassword,
                              onChanged: (value) {
                                context
                                    .read<ChangePasswordCubit>()
                                    .updateNewPassword(value);
                              },
                              onToggleVisibility: () {
                                context
                                    .read<ChangePasswordCubit>()
                                    .toggleNewPasswordVisibility();
                              },
                            ),
                            if (state.newPassword.isNotEmpty) ...[
                              16.verticalSpace,
                              // Password strength indicator
                              _buildPasswordStrengthIndicator(state),
                              16.verticalSpace,
                              // Password requirements
                              _buildPasswordRequirements(state),
                            ],
                          ],
                        );
                      },
                    ),
                    24.verticalSpace,
                    // Confirm new password field
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return _buildPasswordField(
                          label: 'Confirm new password',
                          value: state.confirmPassword,
                          showPassword: state.showConfirmPassword,
                          onChanged: (value) {
                            context
                                .read<ChangePasswordCubit>()
                                .updateConfirmPassword(value);
                          },
                          onToggleVisibility: () {
                            context
                                .read<ChangePasswordCubit>()
                                .toggleConfirmPasswordVisibility();
                          },
                        );
                      },
                    ),
                    40.verticalSpace,
                    // Confirm button
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TextButton(
                            onPressed: state.isLoading
                                ? null
                                : () async {
                                    await context
                                        .read<ChangePasswordCubit>()
                                        .changePassword();
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: state.isLoading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Confirm',
                                    style: AppTextStyles.medium14
                                        .copyWith(color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String value,
    required bool showPassword,
    required ValueChanged<String> onChanged,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.neutralLightActive,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.semiBold10.copyWith(
              color: AppColors.neutralDark,
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.collapsed(offset: value.length),
                  obscureText: !showPassword,
                  onChanged: onChanged,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              TextButton(
                onPressed: onToggleVisibility,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Text(
                      showPassword ? 'Hide' : 'Show',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      size: 18.sp,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator(ChangePasswordState state) {
    double strengthValue = 0.0;
    String strengthText = 'Weak';
    Color strengthColor = Colors.red;

    switch (state.passwordStrength) {
      case PasswordStrength.weak:
        strengthValue = 0.25;
        strengthText = 'Weak';
        strengthColor = Colors.red;
        break;
      case PasswordStrength.medium:
        strengthValue = 0.5;
        strengthText = 'Medium';
        strengthColor = Colors.orange;
        break;
      case PasswordStrength.strong:
        strengthValue = 0.75;
        strengthText = 'Strong';
        strengthColor = Colors.blue;
        break;
      case PasswordStrength.excellent:
        strengthValue = 1.0;
        strengthText = 'Excellent';
        strengthColor = Colors.green;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Password strength",
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: strengthValue,
                  backgroundColor: AppColors.neutralLightActive,
                  valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
                  minHeight: 4.h,
                ),
              ),
            ),
            12.horizontalSpace,
            Text(
              strengthText,
              style: AppTextStyles.reqular12.copyWith(
                color: AppColors.neutralDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements(ChangePasswordState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password must contain:',
          style: AppTextStyles.semiBold12.copyWith(
            color: AppColors.primaryDarker,
          ),
        ),
        12.verticalSpace,
        _buildRequirementItem(
          'One Character',
          state.hasUppercase,
        ),
        8.verticalSpace,
        _buildRequirementItem(
          'One lowercase character',
          state.hasLowercase,
        ),
        8.verticalSpace,
        _buildRequirementItem(
          '8 characters minimum',
          state.hasMinLength,
        ),
      ],
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 16.sp,
          color: isMet ? Colors.green : AppColors.neutralNormal,
        ),
        8.horizontalSpace,
        Text(
          text,
          style: AppTextStyles.semiBold12.copyWith(
            color: isMet ? AppColors.primaryBlue : AppColors.neutralDark,
          ),
        ),
      ],
    );
  }
}

