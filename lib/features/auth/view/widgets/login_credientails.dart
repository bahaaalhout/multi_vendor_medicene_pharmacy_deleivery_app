import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/lgoin_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class LoginCredientails extends StatelessWidget {
  const LoginCredientails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.primaryDarkActive,
          ),
        ),
        8.verticalSpace,
        TextFormField(
          onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: AppTextStyles.reqular14.copyWith(
              color: AppColors.neutralNormalActive,
            ),
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
          ),
        ),
        16.verticalSpace,
        Text(
          'Password',
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.primaryDarkActive,
          ),
        ),
        8.verticalSpace,
        TextFormField(
          obscureText: true,
          onChanged: (value) =>
              context.read<LoginCubit>().passwordChanged(value),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.remove_red_eye),
            hintText: 'Enter your email',
            hintStyle: AppTextStyles.reqular14.copyWith(
              color: AppColors.neutralNormalActive,
            ),
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
          ),
        ),
        8.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              context.push(AppRoutes.forgetPassword);
            },
            child: Text(
              'Forget Password?',
              style: AppTextStyles.semiBold14.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
