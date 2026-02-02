import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class HistoryFilterTabs extends StatefulWidget {
  const HistoryFilterTabs({super.key});

  @override
  State<HistoryFilterTabs> createState() => _HistoryFilterTabsState();
}

class _HistoryFilterTabsState extends State<HistoryFilterTabs> {
  final List<String> categories = ['All', 'New', 'Complete', 'Preparing'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(categories.length, (index) {
          bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 45.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: isSelected
                        ? AppTextStyles.bold12.copyWith(color: Colors.white)
                        : AppTextStyles.semiBold10.copyWith(
                            color: AppColors.secondaryDarker2,
                          ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
