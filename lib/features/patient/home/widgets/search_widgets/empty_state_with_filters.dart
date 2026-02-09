import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/screens/filter_screen.dart';

class EmptyStateWithFilters extends StatelessWidget {
  const EmptyStateWithFilters({super.key, required this.filters});
  final FilterModel filters;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return SizedBox(
      width: double.infinity,
      height: 0.6.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 53),
            child: Column(
              children: [
                Icon(
                  Icons.filter_alt_off,
                  size: 64,
                  color: AppColors.primaryNormal,
                ),

                24.verticalSpace,
                Text(
                  "No results match your filters",
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
                8.verticalSpace,
                Text(
                  "Some filters may be too restrictive",
                  style: AppTextStyles.reqular14.copyWith(
                    color: AppColors.neutralDark,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.updateFilter(FilterModel.initial());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarker,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reset filters',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              12.verticalSpace,

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed: () {
                    showFilterModal(context, '', filters);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryDarker),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Edit Filters',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
