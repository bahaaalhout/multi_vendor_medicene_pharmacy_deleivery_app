import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/pharmacy_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/search_bar.dart' as PharmacySearchBar;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/status_filter_chips.dart';

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
                          // Status Bar
                          _buildStatusBar(),
                          SizedBox(height: AppSizes.spacing16.h),
                          
                          // Pharmacy Header
                          PharmacyHeader(pharmacyName: state.pharmacyName),
                          SizedBox(height: AppSizes.spacing24.h),
                          
                          // Search Bar
                          PharmacySearchBar.SearchBar(
                            onSearchChanged: (query) {
                              context.read<PharmacyOrdersCubit>().updateSearchQuery(query);
                            },
                          ),
                          SizedBox(height: AppSizes.spacing24.h),
                          
                          // Orders Header
                          _buildOrdersHeader(),
                          SizedBox(height: AppSizes.spacing16.h),
                          
                          // Status Filter Chips
                          StatusFilterChips(
                            selectedFilter: state.selectedStatusFilter,
                            onFilterChanged: (filter) {
                              context.read<PharmacyOrdersCubit>().updateStatusFilter(filter);
                            },
                          ),
                          SizedBox(height: AppSizes.spacing24.h),
                        ],
                      ),
                    ),
                    
                    // Orders List
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final order = state.filteredOrders[index];
                          return Column(
                            children: [
                              OrderCard(order: order),
                              if (index < state.filteredOrders.length - 1)
                                SizedBox(height: AppSizes.spacing16.h),
                            ],
                          );
                        },
                        childCount: state.filteredOrders.length,
                      ),
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

  Widget _buildStatusBar() {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralNormal),
        borderRadius: BorderRadius.circular(34.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '9:24 am',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(width: 34.w),
          Container(
            width: 140.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.neutralDarker,
              borderRadius: BorderRadius.circular(34.r),
            ),
          ),
          SizedBox(width: 34.w),
          Row(
            children: [
              Container(
                width: 12.w,
                height: 11.7.h,
                color: AppColors.neutralDarker,
                transform: Matrix4.rotationZ(-90 * 3.14159 / 180),
              ),
              SizedBox(width: 16.w),
              // Signal icons
              _buildSignalIcon(),
              SizedBox(width: 4.w),
              _buildSignalIcon(),
              SizedBox(width: 4.w),
              _buildSignalIcon(),
              SizedBox(width: 4.w),
              _buildSignalIcon(),
              SizedBox(width: 4.w),
              _buildSignalIcon(),
              SizedBox(width: 16.w),
              // Battery icon
              Container(
                width: 16.w,
                height: 9.6.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutralDarker, width: 1.5),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Container(
                  width: 12.w,
                  height: 9.6.h,
                  color: AppColors.neutralDarker,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignalIcon() {
    return Container(
      width: 4.w,
      height: 8.h,
      color: AppColors.neutralDarker,
    );
  }

  Widget _buildOrdersHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Text(
            'Orders',
            style: AppTextStyles.semiBold20.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w, vertical: AppSizes.spacing8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutralNormal),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
            ),
            child: Row(
              children: [
                Text(
                  'All Status',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColors.neutralDarkActive,
                  ),
                ),
                SizedBox(width: AppSizes.spacing8.w),
                Icon(
                  Icons.arrow_drop_down,
                  size: AppSizes.spacing18.r,
                  color: AppColors.primaryNormal,
                ),
              ],
            ),
          ),
      ],
    );
  }
}