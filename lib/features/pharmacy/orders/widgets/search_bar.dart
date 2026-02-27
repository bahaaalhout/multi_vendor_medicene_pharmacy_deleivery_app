import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final bool isTyping;
  final ValueChanged<String>? onTyping;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String> onSearchChanged;

  const SearchBar({
    super.key,
    this.controller,
    this.isTyping = false,
    this.onTyping,
    this.onSubmitted,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hint = 'Search orders';

    return TextField(
      controller: controller,
      onChanged: (value) {
        (onTyping ?? onSearchChanged).call(value);
      },
      onSubmitted: (value) {
        onSubmitted?.call(value);
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.medium14.copyWith(color: AppColors.neutralDark),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.neutralDark,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isTyping ? Icons.close : Icons.mic,
            color: AppColors.primaryNormal,
          ),
          onPressed: isTyping
              ? () {
                  if (controller != null) controller!.clear();
                  (onTyping ?? onSearchChanged).call('');
                }
              : null,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          borderSide: BorderSide(color: AppColors.neutralNormal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          borderSide: BorderSide(color: AppColors.primaryNormal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          borderSide: BorderSide(color: AppColors.neutralNormal.withAlphaPercent(0.6)),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: AppSizes.spacing12.h, horizontal: AppSizes.spacing12.w),
      ),
      style: AppTextStyles.medium14,
    );
  }
}

