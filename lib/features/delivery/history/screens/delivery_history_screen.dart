import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/async_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/cubit/delivery_history_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/cubit/delivery_history_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/error_view.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/widgets/history_filter_chips.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/widgets/history_delivery_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/loading_view.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/history/widgets/history_empty_view.dart';

class DeliveryHistoryScreen extends StatelessWidget {
  const DeliveryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryHistoryCubit()..loadHistory(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppPrimaryAppBar(
          title: 'History',
          showActionButton: false,
        ),
        body: BlocBuilder<DeliveryHistoryCubit, DeliveryHistoryState>(
          builder: (context, state) {
            return state.deliveries.when(
              initial: () => const LoadingView(),
              loading: () => const LoadingView(),
              success: (deliveries) {
                // Show filtered deliveries
                final filteredDeliveries = state.filteredDeliveries;
                
                if (filteredDeliveries.isEmpty) {
                  return const HistoryEmptyView();
                }
                return _buildHistoryContent(filteredDeliveries);
              },
              error: (message) => ErrorView(message: message)
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryContent(List<DeliveryModel> deliveries) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
      child: CustomScrollView(
        scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: AppSizes.spacing16.h),

              // Filter Chips
              _buildFilterChips(),

              SizedBox(height: AppSizes.spacing16.h),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  HistoryDeliveryCard(delivery: deliveries[index]),
                  if (index < deliveries.length - 1)
                    SizedBox(height: AppSizes.spacing16.h),
                ],
              );
            }, childCount: deliveries.length),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSizes.bottomPadding.h)),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return BlocBuilder<DeliveryHistoryCubit, DeliveryHistoryState>(
      builder: (context, state) {
        return HistoryFilterChips(
          selectedPeriod: state.selectedPeriod,
          onPeriodChanged: (period) {
            context.read<DeliveryHistoryCubit>().filterByPeriod(period);
          },
        );
      },
    );
  }
}