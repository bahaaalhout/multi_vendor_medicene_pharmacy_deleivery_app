import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/cubit/delivery_order_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/cubit/delivery_order_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/delivery_progress_stepper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/delivery_instructions_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/customer_info_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/pharmacy_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/action_button.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryOrderDetailsScreen({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryOrderCubit(delivery),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppPrimaryAppBar(
          title: 'Delivery Details',
          showActionButton: false,
        ),
        body: BlocBuilder<DeliveryOrderCubit, DeliveryOrderState>(
          builder: (context, state) {

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing16.w,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Progress Stepper
                        if (state.delivery.status != DeliveryStatus.available)
                          DeliveryProgressStepper(delivery: state.delivery),
                        if (state.delivery.status != DeliveryStatus.available)
                          SizedBox(height: AppSizes.spacing16.h),

                        // Delivery Instructions
                        if (state.delivery.order.deliveryInstructions != null)
                          DeliveryInstructionsCard(
                            instructions:
                                state.delivery.order.deliveryInstructions,
                          ),
                        SizedBox(height: AppSizes.spacing16.h),

                        // Pharmacy Order Card
                        PharmacyOrderCard(
                          delivery: state.delivery,
                          showProductDetails: state.showProductDetails,
                          onToggleProductDetails: () {
                            context
                                .read<DeliveryOrderCubit>()
                                .toggleProductDetails();
                          },
                        ),
                        SizedBox(height: AppSizes.spacing16.h),

                        // Customer Info Card
                        CustomerInfoCard(delivery: state.delivery),
                        SizedBox(height: AppSizes.spacing16.h),

                        // Action Button
                        _buildActionButton(context, state.delivery),

                        SizedBox(height: AppSizes.bottomPadding.h),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, DeliveryModel delivery) {
    final status = delivery.status;

    //todo: check all text, notice text, and onPressed here
    if (status == DeliveryStatus.available) {
      return ActionButton(
        buttonText: 'Accept Order',
        noticeText:
            'By agreeing now to deliver this order, you will be required to wait for a completion notification from the pharmacy.',
        onPressed: () => _handleStatusTransition(context),
      );
    }

    if (status == DeliveryStatus.accepted) {
      return ActionButton(
        buttonText: 'Confirm picking up',
        noticeText: //todo: it will change to "picked up" maybe?
            'Confirming the order now will change its status to picked up.',
        onPressed: () =>{
          _handleStatusTransition(context),
          _handleStatusTransition(context)
        } 
      );
    }

    // if (status == DeliveryStatus.pickedUp) {
    //   return ActionButton(
    //     buttonText: 'Start Delivery',
    //     noticeText:
    //         'Confirming the order now will change its status to "On the way" to the customer\'s location.',
    //     onPressed: () => _handleStatusTransition(context),
    //   );
    // }

    if (status == DeliveryStatus.enRoute) {
      return ActionButton(
        buttonText: 'Confirm Delivery',
        noticeText:
            'Confirming the order delivery now will change its status to “Delivered” to the customer\'s location.',
        onPressed: () => _handleStatusTransition(context),
      );
    }

    return const SizedBox.shrink();
  }

  void _handleStatusTransition(BuildContext context) {
    final cubit = context.read<DeliveryOrderCubit>();
    final currentStatus = cubit.state.delivery.status;
    cubit.advanceDeliveryStatus();
    debugPrint('Status advanced from: $currentStatus');
  }
}
