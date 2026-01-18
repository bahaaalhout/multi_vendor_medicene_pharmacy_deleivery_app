import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/sales_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/tags_of_medicine.dart';

class SalesItem extends StatelessWidget {
  const SalesItem({super.key, required this.salesModel});
  final SalesModel salesModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                salesModel.imageUrl,
                width: 100.w,
                height: 100.h,
              ),
            ),
            SizedBox(height: 8.h),

            SizedBox(
              width: 170.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    salesModel.name,
                    style: AppTextStyles.bold14.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primaryNormal,
                    size: 20.r,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            TagsOfMedicine(salesModel: salesModel),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${salesModel.discountedPrice}",
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "\$${salesModel.originalPrice}",
                  style: AppTextStyles.medium10.copyWith(
                    color: AppColors.neutralDark,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,

          child: Container(
            margin: EdgeInsets.only(left: 4.w, top: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.successDark,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: Text(
              "${salesModel.discountPercentage}% OFF",
              style: AppTextStyles.medium10.copyWith(
                color: AppColors.successLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
