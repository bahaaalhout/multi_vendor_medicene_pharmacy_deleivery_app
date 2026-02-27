import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/sign_up_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/sign_up_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully")),
          );

          context.go(AppRoutes.onboarding);
        }

        if (state.status == SignupStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      builder: (context, state) {
        if (state.status == SignupStatus.loading) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            AppButton(
              title: 'Sign up',
              onPressed: () {
                context.read<SignupCubit>().register();
              },
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: AppTextStyles.reqular12.copyWith(
                    color: AppColors.neutralDark,
                  ),
                ),
                6.horizontalSpace,
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoutes.login);
                  },
                  child: Text(
                    'Sign in',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.primaryNormal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
