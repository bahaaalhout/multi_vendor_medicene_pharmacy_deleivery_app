import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/delivery_progress_stepper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/delivery_instructions_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/customer_info_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/delivery_order_details_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/pharmacy_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/action_button.dart';

class DeliveryOrderDetailScreen extends StatefulWidget {
  final DeliveryModel delivery;

  const DeliveryOrderDetailScreen({super.key, required this.delivery});

  @override
  State<DeliveryOrderDetailScreen> createState() =>
      _DeliveryOrderDetailScreenState();
}

class _DeliveryOrderDetailScreenState extends State<DeliveryOrderDetailScreen> {
  bool _showProductDetails = false;
  late DeliveryModel _currentDelivery;

  @override
  void initState() {
    super.initState();
    _currentDelivery = widget.delivery;
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppSizes.spacing16.h * 2 + AppSizes.spacing80.h;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPrimaryAppBar(
        title: 'Delivery Details',
        onBack: () => Navigator.maybePop(context),
        onAction: () {},
        showActionButton: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Progress Stepper
                  DeliveryProgressStepper(delivery: _currentDelivery),
                  SizedBox(height: AppSizes.spacing16.h),

                  // Delivery Instructions
                  if (_currentDelivery.order.deliveryInstructions != null)
                    DeliveryInstructionsCard(
                      instructions: _currentDelivery.order.deliveryInstructions,
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

                  SizedBox(height: bottomPadding),
                ]),
              ),
            ),
          ],
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
