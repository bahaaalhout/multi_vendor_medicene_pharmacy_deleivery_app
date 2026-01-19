import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';

class BaseBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationItem> items;
  final int currentIndex;
  final int specialItemIndex;
  final Function(int) onTap;

  const BaseBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.specialItemIndex = -1,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.spacing12.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items
              .map(
                (item) => BottomNavigationItem(
                  activeIcon: item.activeIcon,
                  label: item.label,
                  tabIndex: item.tabIndex,
                  isActive: currentIndex == item.tabIndex,
                  lastIndex: items.length - 1,
                  isSpecialItem: item.tabIndex == specialItemIndex,
                  onTap: onTap,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
