import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/view/widgets/user_type_widget.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({super.key});

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  String? selectedType;

  final List<String> userTypes = ['Patient', 'Pharmacist', 'Delivery'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNormal,
      body: Stack(
        children: [
          Center(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Image.asset('assets/images/splash_logo.png'),
            ),
          ),

          Column(
            children: [
              const Spacer(),
              Container(
                margin: EdgeInsets.all(24.r),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Select User Type:',
                          style: AppTextStyles.semiBold20,
                        ),
                        SizedBox(height: 16.h),

                        ...userTypes.map((type) {
                          final isSelected = type == selectedType;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = type;
                              });

                              Future.delayed(const Duration(seconds: 1), () {
                                if (!mounted) return;

                                switch (type) {
                                  case 'Patient':
                                    context.go(AppRoutes.login);
                                    break;

                                  case 'Pharmacist':
                                    context.go(AppRoutes.signUpPharmacy);
                                    break;

                                  case 'Delivery':
                                    context.go(AppRoutes.login);
                                    break;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: UserTypeWidget(
                                userType: type,
                                isSelected: isSelected,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
