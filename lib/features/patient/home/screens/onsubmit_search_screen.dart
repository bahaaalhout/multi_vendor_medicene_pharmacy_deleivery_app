import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/filter_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/cubit/search_state.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/active_filters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/empty_state_with_filters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/keyword_mismatch.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/search_widgets/medicine_card.dart';

class OnsubmitSearchScreen extends StatefulWidget {
  const OnsubmitSearchScreen({super.key});

  @override
  State<OnsubmitSearchScreen> createState() => _OnsubmitSearchScreenState();
}

class _OnsubmitSearchScreenState extends State<OnsubmitSearchScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is OnSearchResult && state.mode == SearchMode.submitted) {
          final results = state.results;
          final filters = state.activeFilters;

          int itemCount = results.length;
          bool showButton = !_isExpanded && results.length > 3;

          if (showButton) {
            itemCount = 3;
          }

          bool isKeywordMismatch =
              results.isEmpty &&
              (filters == null || filters == FilterModel.initial());
          bool isEmptyWithFilters =
              results.isEmpty &&
              filters != null &&
              filters != FilterModel.initial();
          int maxDeliveryTime = 0;
          if (results.isNotEmpty) {
            final times = results.map((e) {
              final timeString = e.pharmacy.deliveryTime.toString().replaceAll(
                RegExp(r'[^0-9]'),
                '',
              );
              return int.tryParse(timeString) ?? 0;
            });
            maxDeliveryTime = times.isNotEmpty
                ? times.reduce((curr, next) => curr > next ? curr : next)
                : 0;
          }

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: showButton ? 24.h : 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.verticalSpace,
                      if (!isKeywordMismatch && !isEmptyWithFilters)
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.reqular16.copyWith(
                              color: AppColors.primaryDarker,
                            ),
                            children: [
                              TextSpan(
                                text: "(${results.length})",
                                style: AppTextStyles.semiBold16,
                              ),
                              const TextSpan(text: " results · delivery in "),
                              TextSpan(
                                text: "($maxDeliveryTime)",
                                style: AppTextStyles.semiBold16,
                              ),
                              const TextSpan(text: " min"),
                            ],
                          ),
                        ),

                      if (isKeywordMismatch)
                        KeywordMismatch(
                          wrongKeyword: context
                              .read<SearchCubit>()
                              .lastSearchInput,
                          correctKeyword: "Headache",
                          onCorrect: () {
                            context.read<SearchCubit>().onSubmit("Headache");
                          },
                        ),

                      if (filters != null) ...[
                        12.verticalSpace,
                        ActiveFilters(filters: filters),
                      ],

                      if (isEmptyWithFilters)
                        EmptyStateWithFilters(filters: filters),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final match = results[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: MedicineCard(
                              medicine: match.medicine,
                              pharmacy: match.pharmacy,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              if (showButton)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.h, bottom: 0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 30,
                          spreadRadius: 25,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 12.w,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Show all results for “${context.read<SearchCubit>().lastSearchInput}”',
                            style: AppTextStyles.bold16.copyWith(
                              color: AppColors.primaryDarker,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
