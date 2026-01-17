import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/bottom_navigation.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_progress_stepper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_instructions_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/customer_info_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_details_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/pharmacy_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/action_button.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final DeliveryModel delivery;

  const DeliveryDetailScreen({super.key, required this.delivery});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  bool _showProductDetails = false;
  late DeliveryModel _currentDelivery;

  @override
  void initState() {
    super.initState();
    _currentDelivery = widget.delivery;
  }

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
                      DeliveryProgressStepper(delivery: _currentDelivery),
                      SizedBox(height: AppSizes.spacing16.h),

                      // Delivery Instructions
                      if (_currentDelivery.order.deliveryInstructions != null)
                        DeliveryInstructionsCard(
                          instructions:
                              _currentDelivery.order.deliveryInstructions,
                        ),
                      SizedBox(height: AppSizes.spacing16.h),

                      // Pharmacy Order Card
                      PharmacyOrderCard(
                        delivery: _currentDelivery,
                        showProductDetails: _showProductDetails,
                        onToggleProductDetails: () {
                          setState(() {
                            _showProductDetails = !_showProductDetails;
                          });
                        },
                      ),
                      SizedBox(height: AppSizes.spacing12.h),

                      // Customer Info Card
                      CustomerInfoCard(delivery: _currentDelivery),

                      // Action Button
                      if (_shouldShowActionButton()) _buildActionButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowActionButton() {
    return _currentDelivery.status == DeliveryStatus.accepted ||
        _currentDelivery.status == DeliveryStatus.pickedUp;
  }

  Widget _buildActionButton() {
    switch (_currentDelivery.status) {
      case DeliveryStatus.accepted:
        return ActionButton(
          buttonText: 'Accept Order',
          noticeText:
              'By agreeing now to deliver this order, you will be required to wait for a completion notification from the pharmacy.',
          onPressed: () => _handleAcceptOrder(),
        );
      case DeliveryStatus.pickedUp:
        return ActionButton(
          buttonText: 'Start Delivery',
          noticeText:
              'Confirming the order now will change its status to "On the way" to the customer\'s location.',
          onPressed: () => _handleStartDelivery(),
        );
      default:
        return ActionButton(buttonText: '', noticeText: '', onPressed: () {});
    }
  }

  void _handleAcceptOrder() {
    setState(() {
      _currentDelivery = _currentDelivery.copyWith(
        status: DeliveryStatus.pickedUp,
      );
    });
    debugPrint('Order accepted - status changed to pickedUp');
  }

  void _handleStartDelivery() {
    setState(() {
      _currentDelivery = _currentDelivery.copyWith(
        status: DeliveryStatus.enRoute,
      );
    });
    debugPrint('Delivery started - status changed to enRoute');
  }
}
