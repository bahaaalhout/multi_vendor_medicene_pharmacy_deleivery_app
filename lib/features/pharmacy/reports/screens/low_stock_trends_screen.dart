import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/low_stock_trends_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/cubit/low_stock_trends_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/reports/models/low_stock_alert_model.dart';

class LowStockTrendsScreen extends StatelessWidget {
  const LowStockTrendsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LowStockTrendsCubit(),
      child: const _LowStockTrendsView(),
    );
  }
}

class _LowStockTrendsView extends StatelessWidget {
  const _LowStockTrendsView();
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
                    'Low Stock Trends',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<LowStockTrendsCubit, LowStockTrendsState>(
                builder: (context, state) {
                  if (state.isLoading && state.alerts.isEmpty) {
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
                                .read<LowStockTrendsCubit>()
                                .loadAlerts(),
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
                        if (state.urgentAlert != null)
                          _UrgentAlertCard(alert: state.urgentAlert!),
                        if (state.urgentAlert != null) 20.verticalSpace,
                        _SectionHeader(),
                        16.verticalSpace,
                        ...state.alerts.map(
                          (a) => Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: _StockAlertCard(alert: a),
                          ),
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

class _UrgentAlertCard extends StatelessWidget {
  final LowStockAlertModel alert;
  const _UrgentAlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final days = alert.daysUntilOutOfStock ?? 0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 20.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryNormal,
            AppColors.secondaryNormalActive,
            AppColors.primaryLightActive,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: SizedBox(
              child: Image.asset(
                'assets/icons/report2.png',
                color: Colors.white,
              ),
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${alert.medicineName} will be out of stock in $days days',
                  style: AppTextStyles.semiBold16.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                8.verticalSpace,
                Text(
                  'You might want to restock soon.',
                  style: AppTextStyles.reqular14.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Low Stock Alerts',
          style: AppTextStyles.semiBold16.copyWith(color: AppColors.textDark),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View All',
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.secondaryDarker1,
            ),
          ),
        ),
      ],
    );
  }
}

class _StockAlertCard extends StatelessWidget {
  final LowStockAlertModel alert;
  const _StockAlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = alert.isOutOfStock;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isOutOfStock ? Color(0xFFFFEBEE) : Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.medicineName,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.secondaryDarker1,
                  ),
                ),
                8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isOutOfStock ? Color(0xFF8A2C2C) : AppColors.secondaryLightActive,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    isOutOfStock ? 'Out of Stock' : 'Low Stock',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: isOutOfStock ? Colors.white : AppColors.secondaryDarker1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alert.stockLabel,
                style: AppTextStyles.semiBold16.copyWith(color: AppColors.neutralDark1),
              ),
              8.verticalSpace,
              Text(
                "Items",
                style: AppTextStyles.reqular12.copyWith(color: AppColors.neutralDark1),
              ),
            ],
          ),
          12.horizontalSpace,
          Image.asset('assets/icons/low-stock-trends-chart.png'),
        ],
      ),
    );
  }
}
