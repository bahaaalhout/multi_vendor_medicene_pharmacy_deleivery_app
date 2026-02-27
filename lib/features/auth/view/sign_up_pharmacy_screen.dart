import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/auth/view/widgets/welcome_section.dart';

class SignUpPharmacyScreen extends StatelessWidget {
  const SignUpPharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [WelcomeAuth(), 24.verticalSpace]),
            ),
          ),
        ),
      ),
    );
  }
}
