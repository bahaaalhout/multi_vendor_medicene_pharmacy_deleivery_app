import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/sales_model.dart';

class TagsOfMedicine extends StatelessWidget {
  const TagsOfMedicine({super.key, required this.salesModel});

  final SalesModel salesModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: salesModel.tags.take(3).length,
        separatorBuilder: (_, __) => SizedBox(width: 4.w),
        itemBuilder: (context, index) {
          final tag = salesModel.tags[index];
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
