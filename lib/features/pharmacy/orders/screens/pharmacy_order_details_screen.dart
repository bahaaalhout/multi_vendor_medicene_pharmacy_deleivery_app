import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_order_details_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_order_details_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_status_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_summary.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_medicines.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_prescription.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_notes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_total.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/order_details_delivered_status.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/pharmacy_header.dart';

class PharmacyOrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const PharmacyOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyOrderDetailsCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<PharmacyOrderDetailsCubit, PharmacyOrderDetailsState>(
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
                          PharmacyHeader(
                            pharmacyName: order.pharmacyName,
                            onNotificationPressed: () {},
                          ),
                          SizedBox(height: AppSizes.spacing24.h),

                          // Order Details Header
                          OrderDetailsHeader(order: order),
                          SizedBox(height: AppSizes.spacing24.h),
                        ],
                      ),
                    ),

                    // Order Details Content
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.spacing16.w,
                          vertical: AppSizes.spacing8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.neutralLight,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSizes.borderRadius16.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Status Badge
                            OrderDetailsStatusBadge(order: order),
                            SizedBox(height: AppSizes.spacing24.h),

                            // Order Summary
                            OrderDetailsSummary(order: order),
                            SizedBox(height: AppSizes.spacing16.h),

                            // Medicines List
                            OrderDetailsMedicines(order: order),
                            SizedBox(height: AppSizes.spacing16.h),

                            // Prescription
                            OrderDetailsPrescription(order: order),
                            SizedBox(height: AppSizes.spacing16.h),

                            // Notes
                            OrderDetailsNotes(order: order),
                            SizedBox(height: AppSizes.spacing16.h),

                            // Total
                            OrderDetailsTotal(order: order),
                            SizedBox(height: AppSizes.spacing16.h),

                            // Delivered Status (only shows when delivered and deliveredAt is not null)
                            OrderDetailsDeliveredStatus(order: order),
                            SizedBox(height: AppSizes.spacing32.h),
                          ],
                        ),
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
}
