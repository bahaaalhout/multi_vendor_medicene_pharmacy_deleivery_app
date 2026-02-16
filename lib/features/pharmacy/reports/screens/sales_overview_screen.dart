import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/sales_overview_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/sales_overview_state.dart';

class SalesOverviewScreen extends StatelessWidget {
  const SalesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesOverviewCubit(),
      child: const _SalesOverviewView(),
    );
  }
}

class _SalesOverviewView extends StatelessWidget {
  const _SalesOverviewView();

  static const _days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                    'Sales Overview',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: BlocBuilder<SalesOverviewCubit, SalesOverviewState>(
                builder: (context, state) {
                  if (state.isLoading && state.dailyOrderCounts.isEmpty) {
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
                                .read<SalesOverviewCubit>()
                                .loadSalesData(),
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
                          onPeriodChanged: (p) =>
                              context.read<SalesOverviewCubit>().setPeriod(p),
                        ),
                        24.verticalSpace,
                        _ChartSection(
                          totalOrders: state.totalOrders,
                          periodLabel: state.periodLabel,
                          orderCounts: state.dailyOrderCounts,
                          days: _days,
                        ),
                        15.verticalSpace,
                        _TopMedicinesSection(medicines: state.topMedicines),
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
  final SalesPeriod selectedPeriod;
  final ValueChanged<SalesPeriod> onPeriodChanged;

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
        children: SalesPeriod.values.map((p) {
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
                              color: AppColors.primaryNormal.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      SalesOverviewState.periodLabels[p.index],
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

class _ChartSection extends StatelessWidget {
  final int totalOrders;
  final String periodLabel;
  final List<int> orderCounts;
  final List<String> days;

  const _ChartSection({
    required this.totalOrders,
    required this.periodLabel,
    required this.orderCounts,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    final counts = orderCounts.length >= 7 ? orderCounts : List.filled(7, 0);
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
          RichText(
            text: TextSpan(
              style: AppTextStyles.reqular16.copyWith(
                color: AppColors.textDark,
              ),
              children: [
                TextSpan(
                  text: '$totalOrders Orders ',
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
                TextSpan(
                  text: periodLabel,
                  style: AppTextStyles.reqular16.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          _EnhancedBarChart(
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
                    style: AppTextStyles.reqular10.copyWith(color: AppColors.chartNeutral),
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

class _TopMedicinesSection extends StatelessWidget {
  final List<TopMedicine> medicines;

  const _TopMedicinesSection({required this.medicines});

  @override
  Widget build(BuildContext context) {
    final displayList = medicines.take(10).toList();

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
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.textDark,
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Text(
                                  item.displayName,
                                  style: AppTextStyles.semiBold12.copyWith(
                                    color: AppColors.secondaryDarker1,
                                  ),
                                ),
                              ),
                              Text(
                                '${item.orderCount} Orders',
                                style: AppTextStyles.semiBold12.copyWith(
                                  color: AppColors.primaryNormal,
                                ),
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
