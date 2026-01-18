import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            categoryModel.imageUrl,
            width: 100.w,
            height: 100.h,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          categoryModel.name,
          style: AppTextStyles.bold14.copyWith(color: AppColors.primaryNormal),
        ),
        SizedBox(height: 8.h),
        Text(
          categoryModel.description,
          style: AppTextStyles.reqular12.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
      ],
    );
  }
}
