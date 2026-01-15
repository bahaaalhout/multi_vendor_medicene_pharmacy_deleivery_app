import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_progress_stepper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_instructions_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/status_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/customer_info_card.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
                child: Column(
                  children: [
                    // Progress Stepper
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
                      child: DeliveryProgressStepper(
                        delivery: widget.delivery,
                        statusMessage: widget.delivery.statusMessage,
                      ),
                    ),
                    SizedBox(height: AppSizes.spacing16.h),

                    // Delivery Instructions
                    if (widget.delivery.order.deliveryInstructions != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
                        child: DeliveryInstructionsCard(
                          instructions: widget.delivery.order.deliveryInstructions,
                        ),
                      ),
                    SizedBox(height: AppSizes.spacing16.h),

                    // Pharmacy Order Card (always show)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
                      child: PharmacyOrderCard(
                        order: widget.delivery.order,
                        delivery: widget.delivery,
                        statusBadge: _getPharmacyStatusBadge(),
                        showProductDetails: _showProductDetails,
                        onToggleProductDetails: () {
                          setState(() {
                            _showProductDetails = !_showProductDetails;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: AppSizes.spacing16.h),

                    // Customer Info Card (show after pickup)
                    if (_shouldShowCustomerCard())
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
                        child: CustomerInfoCard(
                          order: widget.delivery.order,
                          delivery: widget.delivery,
                        ),
                      ),

                    // Action Button
                    if (_shouldShowActionButton())
                      Padding(
                        padding: EdgeInsets.all(AppSizes.spacing16.w),
                        child: ActionButton(
                          status: widget.delivery.status,
                          onAccept: _handleAcceptOrder,
                          onStart: _handleStartDelivery,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryLightActive),
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primaryNormal,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacing16.w),
          
          Expanded(
            child: Text(
              'Delivery Details',
              style: AppTextStyles.bold25.copyWith(
                color: AppColors.primaryDarker,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(width: (60 + AppSizes.spacing16).w),
        ],
      ),
    );
  }

  Widget? _getPharmacyStatusBadge() {
    switch (widget.delivery.status) {
      case DeliveryStatus.accepted:
        return const StatusBadge(type: BadgeType.pickingUp);
      case DeliveryStatus.pickedUp:
      case DeliveryStatus.enRoute:
        return const StatusBadge(type: BadgeType.pickedUp);
      default:
        return null;
    }
  }

  bool _shouldShowCustomerCard() {
    return widget.delivery.status == DeliveryStatus.pickedUp ||
           widget.delivery.status == DeliveryStatus.enRoute;
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
