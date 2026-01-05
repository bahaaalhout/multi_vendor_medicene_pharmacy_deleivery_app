import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
