import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';

class ActiveFilters extends StatelessWidget {
  ActiveFilters({super.key, required this.filters});
  final FilterModel filters;
  final List<Widget> chips = [];
  void addChip(String label, VoidCallback onRemove) {
    chips.add(
      Container(
        margin: EdgeInsets.only(right: 8.w, bottom: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(width: 1.w, color: AppColors.primaryLightActive),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.primaryDarker,
                fontSize: 14.sp,
              ),
            ),
            4.horizontalSpace,
            InkWell(
              onTap: onRemove,
              child: Icon(
                Icons.close,
                size: 16,
                color: AppColors.neutralDarkHover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    if (filters.category != null && filters.category!.isNotEmpty) {
      addChip('Category: ${filters.category}', () {
        cubit.updateFilter(filters.copyWith(category: ''));
      });
    }
    if (filters.brand != null && filters.brand!.isNotEmpty) {
      addChip('Brand: ${filters.brand}', () {
        cubit.updateFilter(filters.copyWith(brand: ''));
      });
    }
    if (filters.priceRange.end < 1000) {
      addChip('Price Less than \$${filters.priceRange.end.toInt()}', () {
        cubit.updateFilter(
          filters.copyWith(priceRange: const RangeValues(1, 1000)),
        );
      });
    }
    if (filters.priceRange.start > 1) {
      addChip('Price more than \$${filters.priceRange.start.toInt()}', () {
        cubit.updateFilter(
          filters.copyWith(priceRange: const RangeValues(1, 1000)),
        );
      });
    }

    if (filters.distanceRange.end < 20) {
      addChip('Distance . ${filters.distanceRange.end.toInt()}km', () {
        cubit.updateFilter(
          filters.copyWith(distanceRange: const RangeValues(1, 6)),
        );
      });
    }

    if (filters.inStockOnly) {
      addChip('In stock', () {
        cubit.updateFilter(filters.copyWith(inStockOnly: false));
      });
    }

    if (filters.onSale) {
      addChip('On sale', () {
        cubit.updateFilter(filters.copyWith(onSale: false));
      });
    }

    if (filters.rating > 0) {
      addChip('${filters.rating} Rating', () {
        cubit.updateFilter(filters.copyWith(rating: 0));
      });
    }

    if (filters.prescriptionType.isNotEmpty) {
      String label = filters.prescriptionType == 'Requires Prescription'
          ? 'Required Prescription'
          : 'No Prescription';
      addChip(label, () {
        cubit.updateFilter(filters.copyWith(prescriptionType: ''));
      });
    }
    return Wrap(children: chips);
  }
}
