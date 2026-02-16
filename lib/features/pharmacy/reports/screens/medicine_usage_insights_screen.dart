import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/medicine_usage_insights_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/medicine_usage_insights_state.dart';

class MedicineUsageInsightsScreen extends StatelessWidget {
  const MedicineUsageInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicineUsageInsightsCubit(),
      child: const _MedicineUsageInsightsView(),
    );
  }
}

class _MedicineUsageInsightsView extends StatelessWidget {
  const _MedicineUsageInsightsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const NavigateBackButton(),
                  ),
                  Text(
                    'Medicine Usage Insights',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 18.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<
                    MedicineUsageInsightsCubit,
                    MedicineUsageInsightsState
                  >(
                    builder: (context, state) {
                      if (state.isLoading && state.topDays.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.errorMessage != null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.errorMessage!,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.reqular14.copyWith(
                                  color: AppColors.errorNormal,
                                ),
                              ),
                              16.verticalSpace,
                              TextButton(
                                onPressed: () => context
                                    .read<MedicineUsageInsightsCubit>()
                                    .loadData(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PeriodSelector(
                              selectedPeriod: state.selectedPeriod,
                              onPeriodChanged: (p) => context
                                  .read<MedicineUsageInsightsCubit>()
                                  .setPeriod(p),
                            ),
                            24.verticalSpace,
                            _TopDaysChartSection(topDays: state.topDays),
                            15.verticalSpace,
                            _TopMedicinesWithShareSection(
                              medicines: state.topMedicines,
                            ),
                            40.verticalSpace,
                          ],
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  final UsagePeriod selectedPeriod;
  final ValueChanged<UsagePeriod> onPeriodChanged;

  const _PeriodSelector({
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r)),
      child: Row(
        children: UsagePeriod.values.map((p) {
          final isSelected = selectedPeriod == p;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: () => onPeriodChanged(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryNormal
                        : AppColors.neutralLight,
                    borderRadius: BorderRadius.circular(40.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryNormal.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      MedicineUsageInsightsState.periodLabels[p.index],
                      style: AppTextStyles.reqular12.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.neutralDarkHover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TopDaysChartSection extends StatelessWidget {
  final List<TopDayData> topDays;

  const _TopDaysChartSection({required this.topDays});

  @override
  Widget build(BuildContext context) {
    final days = topDays.map((e) => e.dayLabel).toList();
    final counts = topDays.map((e) => e.orderCount).toList();
    final maxVal = counts.isEmpty ? 1 : counts.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Date of future',
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primaryNormal,
            ),
          ),
          20.verticalSpace,
          days.isEmpty
              ? SizedBox(
                  height: 190,
                  child: Center(
                    child: Text(
                      'No data in this period',
                      style: AppTextStyles.reqular14.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ),
                )
              : _EnhancedBarChart(
                  orderCounts: counts,
                  days: days,
                  maxVal: maxVal > 0 ? maxVal : 1,
                ),
        ],
      ),
    );
  }
}

class _EnhancedBarChart extends StatelessWidget {
  final List<int> orderCounts;
  final List<String> days;
  final int maxVal;

  const _EnhancedBarChart({
    required this.orderCounts,
    required this.days,
    required this.maxVal,
  });

  @override
  Widget build(BuildContext context) {
    const double chartHeight = 150;

    return Stack(
      children: [
        Column(
          children: List.generate(3, (index) {
            final label = maxVal - (index * (maxVal ~/ 2).clamp(1, maxVal));
            return Container(
              height: chartHeight / 2.3,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 25.w,
                    child: Text(
                      label.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(days.length, (index) {
              final count = index < orderCounts.length ? orderCounts[index] : 0;
              final barHeight = maxVal > 0
                  ? (count / maxVal) * chartHeight
                  : 0.0;
              return Column(
                children: [
                  Container(
                    width: 18.w,
                    height: barHeight.clamp(0.0, chartHeight),
                    decoration: BoxDecoration(
                      color: AppColors.primaryNormal,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    days[index],
                    style: AppTextStyles.reqular10.copyWith(
                      color: AppColors.chartNeutral,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _TopMedicinesWithShareSection extends StatelessWidget {
  final List<MedicineWithShare> medicines;

  const _TopMedicinesWithShareSection({required this.medicines});

  @override
  Widget build(BuildContext context) {
    final displayList = medicines.take(10).toList();
    final maxShare = displayList.isEmpty
        ? 100.0
        : displayList
              .map((e) => e.sharePercent)
              .reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Medicines',
          style: AppTextStyles.semiBold16.copyWith(color: AppColors.textDark),
        ),
        16.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: AppColors.neutralLight,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: displayList.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'No orders in this period',
                    style: AppTextStyles.reqular14.copyWith(
                      color: AppColors.neutralDark,
                    ),
                  ),
                )
              : Column(
                  children: List.generate(displayList.length, (index) {
                    final item = displayList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 8.h),
                                width: 6.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.textDark,
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.displayName,
                                      style: AppTextStyles.semiBold12.copyWith(
                                        color: AppColors.secondaryDarker1,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      '${item.sharePercent.toStringAsFixed(0)}% Share',
                                      style: AppTextStyles.reqular12.copyWith(
                                        color: AppColors.neutralDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${item.orderCount} Orders',
                                    style: AppTextStyles.semiBold12.copyWith(
                                      color: AppColors.primaryNormal,
                                    ),
                                  ),
                                  6.verticalSpace,
                                  SizedBox(
                                    width: 60.w,
                                    child: LinearProgressIndicator(
                                      value: maxShare > 0
                                          ? (item.sharePercent / maxShare)
                                          : 0,
                                      backgroundColor:
                                          AppColors.primaryLightActive,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryNormal,
                                      ),
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (index != displayList.length - 1)
                          Divider(
                            height: 1,
                            indent: 34.w,
                            endIndent: 16.w,
                            color: AppColors.neutralLightActive,
                          ),
                      ],
                    );
                  }),
                ),
        ),
      ],
    );
  }
}
