import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/onboarding/models/on_boarding_model.dart';

class ContentBoard extends StatelessWidget {
  const ContentBoard({super.key, required this.page});

  final OnBoardingModel page;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              page.title,
              style: AppTextStyles.semiBold30.copyWith(color: Colors.white),
            ),
          ),
          12.verticalSpace,
          Text(
            page.subtitle,
            style: AppTextStyles.semiBold18.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
