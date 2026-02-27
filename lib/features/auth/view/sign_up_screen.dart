import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/auth.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/cubit/sign_up_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/google_sign_in.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/login_credientails.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/sign_up_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/sign_up_credientals.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/welcome_section.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(AuthService()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WelcomeAuth(),
                    24.verticalSpace,
                    GoogleSignIn(),
                    24.verticalSpace,
                    SignUpCredientals(),
                    24.verticalSpace,
                    SignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
