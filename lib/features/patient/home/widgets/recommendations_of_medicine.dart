import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RecommendationsOfMedicine extends StatelessWidget {
  const RecommendationsOfMedicine({super.key, required this.medicineModel});

  final MedicineModel medicineModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: medicineModel.salesInfo?.recommendations.take(3).length ?? 0,
        separatorBuilder: (_, __) => SizedBox(width: 4.w),
        itemBuilder: (context, index) {
          final tag = medicineModel.salesInfo!.recommendations[index];
          return Chip(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            backgroundColor: AppColors.warningLightActive,
            label: Text(
              tag,
              style: AppTextStyles.semiBold10.copyWith(
                color: AppColors.warningDarker,
              ),
            ),
          );
        },
      ),
    );
  }
}
