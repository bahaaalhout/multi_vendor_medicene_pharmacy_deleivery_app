import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/lgoin_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/login_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/app_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Success")));
          context.pushReplacement(AppRoutes.onboarding);
        }

        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Error")),
          );
        }
      },
      builder: (context, state) {
        if (state.status == LoginStatus.loading) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            AppButton(
              title: 'Login',
              onPressed: () {
                context.go(AppRoutes.home);
                // context.read<LoginCubit>().login();
              },
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: AppTextStyles.reqular12.copyWith(
                    color: AppColors.neutralDark,
                  ),
                ),
                6.horizontalSpace,
                InkWell(
                  onTap: () {
                    context.pushReplacement(AppRoutes.signUp);
                  },
                  child: Text(
                    'Register Here',
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
