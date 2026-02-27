import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DifferentScheduleNote extends StatelessWidget {
  const DifferentScheduleNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Text(
        'These medications have different schedules.\nCreate a separate reminder for each medication.',
        style: AppTextStyles.reqular12.copyWith(color: const Color(0xFFB91C1C)),
      ),
    );
  }
}
