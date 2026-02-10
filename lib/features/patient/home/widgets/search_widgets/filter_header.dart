import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/filter_state.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        int count = 0;
        if (state is FilterSuccess) {
          count = state.model.activeFilterCount;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Filters',
                  style: AppTextStyles.bold24.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  '($count) filters applied',
                  style: AppTextStyles.reqular16.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyles.reqular14.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
