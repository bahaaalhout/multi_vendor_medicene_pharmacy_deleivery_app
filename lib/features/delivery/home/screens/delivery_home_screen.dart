import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/cubit/delivery_home_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/cubit/delivery_home_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/screens/delivery_order_details_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/available_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/available_orders_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/online_toggle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/review_alert.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/header_widget.dart';

class DeliveryHomeScreen extends StatelessWidget {
  const DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryHomeCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<DeliveryHomeCubit, DeliveryHomeState>(
          builder: (context, state) {
            double bottomPadding = AppSizes.spacing16.h * 2 + AppSizes.spacing80.h;
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: AppSizes.spacing16.w, right: AppSizes.spacing16.w, top: AppSizes.spacing16.h),
                child: CustomScrollView(
                  scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        HeaderWidget(
                          name: state.driverName,
                          location: state.driverLocation,
                          imageUrl: state.driverImageUrl,
                        ),
                        SizedBox(height: AppSizes.spacing16.h),
                        OnlineToggle(
                          isOnline: state.isOnline,
                          onChanged: (value) {
                            context.read<DeliveryHomeCubit>().toggleOnline(value);
                          },
                        ),
                        SizedBox(height: AppSizes.spacing16.h),
                        if (state.hasReviewAlert) ReviewAlert(),
                        if (state.hasReviewAlert) SizedBox(height: AppSizes.spacing16.h),
                        AvailableOrdersHeader(orderCount: state.availableDeliveries.length),
                        SizedBox(height: AppSizes.spacing16.h),
                      ]),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Column(
                          children: [
                            AvailableOrderCard(
                              delivery: state.availableDeliveries[index],
                              onAccept: () => _handleAcceptOrder(context, state.availableDeliveries[index]),
                            ),
                            if (index < state.availableDeliveries.length - 1)
                              SizedBox(height: AppSizes.spacing16.h),
                          ],
                        );
                      }, childCount: state.availableDeliveries.length),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleAcceptOrder(BuildContext context, DeliveryModel delivery) {
    final cubit = context.read<DeliveryHomeCubit>();
    cubit.acceptOrder(delivery);
    
    debugPrint('Accept order: ${delivery.id}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryOrderDetailsScreen(delivery: delivery.copyWith(status: DeliveryStatus.accepted)),
      ),
    );
  }
}
