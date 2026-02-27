import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/orders_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/pharmacy_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/search_bar.dart'
    as PharmacySearchBar;

class PharmacyOrdersListScreen extends StatelessWidget {
  const PharmacyOrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyOrdersCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<PharmacyOrdersCubit, PharmacyOrdersState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
                child: CustomScrollView(
                  slivers: [
                    // Header Section
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: AppSizes.spacing8.h),
                          
                          // Pharmacy Header
                          PharmacyHeader(pharmacyName: state.pharmacyName, onNotificationPressed: () { },),
                          SizedBox(height: AppSizes.spacing24.h),

                          // Search Bar
                          PharmacySearchBar.SearchBar(
                            onSearchChanged: (query) {
                              context
                                  .read<PharmacyOrdersCubit>()
                                  .updateSearchQuery(query);
                            },
                          ),
                          SizedBox(height: AppSizes.spacing24.h),

                          // Orders Header with Status Dropdown
                          OrdersHeader(
                            selectedFilter: state.selectedStatusFilter,
                            onFilterChanged: (filter) {
                              context.read<PharmacyOrdersCubit>().updateStatusFilter(filter);
                            },
                          ),
                          SizedBox(height: AppSizes.spacing12.h),
                        ],
                      ),
                    ),

                    // Orders List
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final order = state.filteredOrders[index];
                        return Column(
                          children: [
                            OrderCard(order: order),
                            if (index < state.filteredOrders.length - 1)
                              SizedBox(height: AppSizes.spacing16.h),
                          ],
                        );
                      }, childCount: state.filteredOrders.length),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(height: AppSizes.bottomPadding.h),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
