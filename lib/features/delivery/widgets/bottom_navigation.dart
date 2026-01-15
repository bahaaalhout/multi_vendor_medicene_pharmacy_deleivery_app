import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.spacing16.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spacing12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                isActive: true,
                tabIndex: 0,
              ),
              _buildNavItem(
                icon: Icons.history,
                label: 'History',
                isActive: false,
                tabIndex: 1,
              ),
              _buildNavItem(
                icon: Icons.local_shipping,
                label: 'Deliveries',
                isActive: false,
                tabIndex: 2,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                isActive: false,
                tabIndex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required int tabIndex,
  }) {
    Widget iconTab = Column(
      children: [
        Icon(icon, size: AppSizes.iconSize18.r, color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker),
        SizedBox(height: AppSizes.spacing8.h),
        Text(
          label,
          style: AppTextStyles.medium10.copyWith(
            color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker,
          ),
        ),
      ],
    );
    return isActive
        ? Container(
            width: AppSizes.spacing56.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: AppSizes.spacing8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: tabIndex == 0
                    ? Radius.circular(AppSizes.borderRadius16.r)
                    : Radius.circular(AppSizes.borderRadius8.r),
                right: tabIndex == 3
                    ? Radius.circular(AppSizes.borderRadius16.r)
                    : Radius.circular(AppSizes.borderRadius8.r),
              ),
            ),
            child: iconTab,
          )
        : iconTab;
  }}