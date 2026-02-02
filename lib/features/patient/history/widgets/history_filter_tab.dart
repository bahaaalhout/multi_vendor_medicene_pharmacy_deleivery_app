import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/cubit/history_cubit.dart';

class HistoryFilterTabs extends StatelessWidget {
  const HistoryFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        final cubit = context.read<HistoryCubit>();
        final List<String> categories = ['All', 'New', 'Complete', 'Preparing'];
        final List<HistoryFilter> filters = [
          HistoryFilter.all,
          HistoryFilter.newOrder,
          HistoryFilter.complete,
          HistoryFilter.preparing,
        ];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (index) {
              final filter = filters[index];
              bool isSelected = state.selectedFilter == filter;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.changeFilter(filter);
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
      },
    );
  }
}
