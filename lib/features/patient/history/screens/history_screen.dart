import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/cubit/history_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/widgets/history_filter_tab.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/widgets/order_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    const NavigateBackButton(),
                    Expanded(
                      child: Center(
                        child: Text(
                          'History',
                          style: AppTextStyles.bold25.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.neutralDarker,
                          ),
                        ),
                      ),
                    ),
                    40.horizontalSpace,
                  ],
                ),
              ),

              const HistoryFilterTabs(),
              10.verticalSpace,

              Expanded(
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final filteredOrders = state.filteredOrders;

                    if (filteredOrders.isEmpty) {
                      return Center(
                        child: Text(
                          'No orders found',
                          style: AppTextStyles.medium14.copyWith(
                            color: AppColors.neutralDark,
                          ),
                        ),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        ...filteredOrders.map((order) => Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: OrderCard(
                                order: order,
                                onCopyId: () {
                                  // Optional: Show snackbar
                                },
                                onReorder: () {
                                  // Handle reorder
                                },
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
