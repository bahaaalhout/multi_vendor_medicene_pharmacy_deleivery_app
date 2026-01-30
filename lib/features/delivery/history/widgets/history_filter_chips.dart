import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/cubit/delivery_history_state.dart';

class HistoryFilterChips extends StatelessWidget {
  final HistoryPeriod selectedPeriod;
  final ValueChanged<HistoryPeriod> onPeriodChanged;

  const HistoryFilterChips({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
      ),
      child: Row(
        children: [
          _buildChip(
            context,
            HistoryPeriod.all,
            'All',
          ),
          SizedBox(width: AppSizes.spacing8,),
          _buildChip(
            context,
            HistoryPeriod.today,
            'Today',
          ),
          SizedBox(width: AppSizes.spacing8,),
          _buildChip(
            context,
            HistoryPeriod.thisWeek,
            'This Week',
          ),
          SizedBox(width: AppSizes.spacing8,),
          _buildChip(
            context,
            HistoryPeriod.thisMonth,
            'This Month',
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    HistoryPeriod period,
    String label,
  ) {
    final isSelected = selectedPeriod == period;
    
    return Expanded(
      child: InkWell(
        onTap: () => onPeriodChanged(period),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.borderRadius24.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryNormal : AppColors.primaryLight,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.borderRadius24.r),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.semiBold14.copyWith(
                color: isSelected ? Colors.white : AppColors.primaryNormal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
