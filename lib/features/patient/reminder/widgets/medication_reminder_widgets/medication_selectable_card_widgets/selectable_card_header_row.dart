import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_badges.dart';

class SelectableCardHeaderRow extends StatelessWidget {
  final MedicineModel medicine;
  final String? badgeText;

  const SelectableCardHeaderRow({
    super.key,
    required this.medicine,
    required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.network(
            medicine.imageUrls.first,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.medication_outlined),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.brandName,
                style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                medicine.genericName,
                style: AppTextStyles.reqular12.copyWith(
                  color: AppColors.primaryDarkActive,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),

              Wrap(
                spacing: 4.w,
                children: [
                  if (badgeText != null) MedicationBadge(text: badgeText!),
                  MedicationBadge(text: medicine.strength),
                  MedicationBadge(text: _formLabel(medicine.form)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formLabel(FormType form) {
    switch (form) {
      case FormType.tablet:
        return 'Tablet';
      case FormType.syrup:
        return 'Syrup';
      case FormType.capsule:
        return 'Capsule';
      case FormType.injection:
        return 'Injection';
      case FormType.cream:
        return 'Cream';
      case FormType.ointment:
        return 'Ointment';
    }
  }
}
