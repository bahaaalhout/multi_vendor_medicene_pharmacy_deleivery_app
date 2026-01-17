import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class TitleOfHeaders extends StatelessWidget {
  const TitleOfHeaders({
    super.key,
    required this.title,
    required this.navigateToPage,
  });
  final String title;
  final Function() navigateToPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.bold20.copyWith(color: AppColors.neutralDarker),
        ),
        InkWell(
          onTap: navigateToPage,
          child: Row(
            children: [
              Text(
                'see all',
                style: AppTextStyles.reqular14.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                radius: 12.r,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 12.r,
                  color: AppColors.primaryNormal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
