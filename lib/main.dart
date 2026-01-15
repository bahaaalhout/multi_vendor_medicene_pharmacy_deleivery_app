import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/profile/screens/profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/prescription/screens/upload_prescription_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Multi Vendor Medicene Pharmacy Deleivery App',
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: AppTextStyles.header1,
            headlineMedium: AppTextStyles.header2,
            headlineSmall: AppTextStyles.header3,
            titleLarge: AppTextStyles.subtitle,
            bodySmall: AppTextStyles.small,
            bodyMedium: AppTextStyles.body,
            bodyLarge: AppTextStyles.bold,
            labelLarge: AppTextStyles.buttonText,
            labelMedium: AppTextStyles.linkText,
          ),
        ),
        home: const UploadPrescriptionScreen(),
      ),
    );
  }
}
