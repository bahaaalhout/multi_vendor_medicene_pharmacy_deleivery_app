import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/models/review_data.dart';

class ReviewCard extends StatelessWidget {
  final ReviewData review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16.w,
        vertical: AppSizes.spacing16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Row(
        children: [
          // Avatar
          SizedBox(
            width: AppSizes.spacing48.r,
            height: AppSizes.spacing48.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius20.r),
              child: Image.network(
                review.imageUrl ?? "",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset('assets/icons/person.png'),
              ),
            ),
          ),

          SizedBox(width: AppSizes.spacing16.w),

          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.name,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.primaryDarker,
                      ),
                    ),
                    Text(
                      review.time,
                      style: AppTextStyles.reqular10.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.spacing8.h),

                Text(
                  review.comment,
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}