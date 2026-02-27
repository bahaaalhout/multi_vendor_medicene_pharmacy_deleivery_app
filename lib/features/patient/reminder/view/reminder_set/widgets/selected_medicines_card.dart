import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/main_frame.dart';

class SelectedMedicinesCard extends StatelessWidget {
  final List<MedicineModel> meds;
  final int timesPerDay;
  final String frequency;
  final String untilText;
  final String firstTime;

  const SelectedMedicinesCard({
    super.key,
    required this.meds,
    required this.timesPerDay,
    required this.frequency,
    required this.untilText,
    required this.firstTime,
  });

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      color: AppColors.neutralLight,
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected medicines',
            style: AppTextStyles.semiBold14.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),

          ...meds.map((m) {
            final img = (m.imageUrls.isNotEmpty) ? m.imageUrls.first : null;

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: img == null
                        ? const Icon(Icons.medication_outlined)
                        : Image.network(img, fit: BoxFit.contain),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.brandName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.semiBold16.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          m.genericName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.reqular12.copyWith(
                            color: AppColors.primaryDarkActive,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          SizedBox(height: 6.h),

          Text(
            '$timesPerDay times $frequency · Until $untilText',
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.primaryDarkActive,
            ),
          ),
          SizedBox(height: 2.h),

          Text(
            'First reminder at $firstTime',
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.primaryDarkActive,
            ),
          ),
        ],
      ),
    );
  }
}