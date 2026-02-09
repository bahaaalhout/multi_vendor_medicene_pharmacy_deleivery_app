import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/suggestion_tile.dart';

class KeywordMismatch extends StatelessWidget {
  const KeywordMismatch({
    super.key,
    required this.wrongKeyword,
    required this.correctKeyword,
    required this.onCorrect,
  });

  final String wrongKeyword;
  final String correctKeyword;
  final VoidCallback onCorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        Text(
          'Suggestions',
          style: AppTextStyles.bold20.copyWith(
            color: AppColors.primaryDarker,
            fontWeight: FontWeight.w700,
          ),
        ),
        12.verticalSpace,

        const SuggestionTile(text: "Brand names (e.g., Panadol)"),
        8.verticalSpace,
        const SuggestionTile(text: "Brand names (e.g., Panadol)"),
        8.verticalSpace,
        const SuggestionTile(text: "Brand names (e.g., Panadol)"),

        100.verticalSpace,
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: AppColors.primaryNormal,
              ),
              20.verticalSpace,

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.primaryDarker,
                    fontFamily: 'Cairo',
                  ),
                  children: [
                    const TextSpan(text: 'No results for '),
                    TextSpan(
                      text: '“$wrongKeyword”',

                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),

              8.verticalSpace,
              Text(
                'Check the spelling of the word or try a\ndifferent keyword.',
                textAlign: TextAlign.center,
                style: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralDark,
                  height: 1.5,
                ),
              ),
              59.verticalSpace,

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: onCorrect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNormal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Search for “$correctKeyword”',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
