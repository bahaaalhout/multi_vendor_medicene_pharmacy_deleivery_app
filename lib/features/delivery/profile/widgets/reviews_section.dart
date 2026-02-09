import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/models/review_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/profile/widgets/review_card.dart';

class ReviewsSection extends StatelessWidget {
  final List<ReviewData> reviews;

  const ReviewsSection({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16.w,
        vertical: AppSizes.spacing12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive, width: 1.w),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Sort
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.primaryDarker,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Newest',
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralDark,
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing12.w),
                  SvgPicture.asset(
                    'assets/icons/sort_ascending.svg',
                    width: AppSizes.iconSize20.w,
                    height: AppSizes.iconSize20.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryNormal,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: AppSizes.spacing16.h),

          // Reviews List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index]);
            }, separatorBuilder: (BuildContext context, int index) => AppSizes.spacing16.verticalSpace,
          ),
        ],
      ),
    );
  }
}
