import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/bottom_navigation.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_progress_stepper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_instructions_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/customer_info_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_details_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/pharmacy_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/action_button.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final DeliveryModel delivery;

  const DeliveryDetailScreen({
    super.key,
    required this.delivery,
  });

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  bool _showProductDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
      child: Column(
          children: [
            const DeliveryDetailsHeader(),
            SizedBox(height: AppSizes.spacing16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Progress Stepper
                    DeliveryProgressStepper(delivery: widget.delivery,),
                    SizedBox(height: AppSizes.spacing16.h),

                    // Delivery Instructions
                    if (widget.delivery.order.deliveryInstructions != null)
                      DeliveryInstructionsCard(
                        instructions: widget.delivery.order.deliveryInstructions,
                      ),
                    SizedBox(height: AppSizes.spacing16.h),

                    // Pharmacy Order Card
                    PharmacyOrderCard(
                      delivery: widget.delivery,
                      showProductDetails: _showProductDetails,
                      onToggleProductDetails: () {
                        setState(() {
                          _showProductDetails = !_showProductDetails;
                        });
                      },
                    ),
                    SizedBox(height: AppSizes.spacing12.h),

                    // Customer Info Card
                    CustomerInfoCard(delivery: widget.delivery),

                    // Action Button
                    if (_shouldShowActionButton())
                      ActionButton(
                        status: widget.delivery.status,
                        onAccept: _handleAcceptOrder,
                        onStart: _handleStartDelivery,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),)
    );
  }


  bool _shouldShowActionButton() {
    return widget.delivery.status == DeliveryStatus.accepted ||
           widget.delivery.status == DeliveryStatus.pickedUp;
  }

  void _handleAcceptOrder() {
    debugPrint('Accept order tapped');
    // TODO: Implement
  }

  void _handleStartDelivery() {
    debugPrint('Start delivery tapped');
    // TODO: Implement
  }
}
