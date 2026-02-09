import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RatingSection extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onChanged;

  const RatingSection({
    super.key,
    required this.selectedRating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive, width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pharmacy Rating",
                style: AppTextStyles.medium16.copyWith(
                  color: AppColors.neutralDarkActive,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  'All',
                  style: AppTextStyles.reqular14.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [1, 2, 3, 4, 5].map((star) {
              return Column(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      star == selectedRating
                          ? 'assets/icons/Star_colored.svg'
                          : 'assets/icons/star_outlined.svg',
                    ),
                    onPressed: () => onChanged(star),
                  ),
                  Text(
                    star.toString(),
                    style: star == selectedRating
                        ? AppTextStyles.semiBold16.copyWith(
                            color: AppColors.primaryNormal,
                          )
                        : AppTextStyles.medium16.copyWith(
                            color: AppColors.neutralDarkActive,
                          ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
