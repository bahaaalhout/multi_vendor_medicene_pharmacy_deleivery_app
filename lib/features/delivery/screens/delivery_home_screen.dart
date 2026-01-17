import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/available_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/bottom_navigation.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_home_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/online_toggle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/review_alert.dart';

class DeliveryHomeScreen extends StatefulWidget {
  final String driverName;
  final String driverLocation;
  final String? driverImageUrl;
  final bool hasReviewAlert;
  final List<DeliveryModel> availableDeliveries;

  const DeliveryHomeScreen({
    super.key,
    this.driverName = "Mohammed",
    this.driverLocation = "26 Salah El Din St., Gaza",
    required this.availableDeliveries,
    this.driverImageUrl,
    this.hasReviewAlert = true,
  });

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  bool _isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
          child: Column(
            children: [
              DeliveyHomeHeader(
                driverName: widget.driverName,
                driverLocation: widget.driverLocation,
                driverImageUrl: widget.driverImageUrl,
              ),
              SizedBox(height: AppSizes.spacing16.h),
              OnlineToggle(isOnline: _isOnline, onChanged: (value) {
                setState(() {
                  _isOnline = value;
                });
              }),
              SizedBox(height: AppSizes.spacing16.h),
              if (widget.hasReviewAlert) ReviewAlert(),
              if (widget.hasReviewAlert) SizedBox(height: AppSizes.spacing16.h),
              _buildAvailableOrdersHeader(),
              SizedBox(height: AppSizes.spacing16.h),
              Expanded(child: _buildOrdersList()),
            ],

          ),
        ),
      ),
    );
  }

  Widget _buildAvailableOrdersHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Available Orders',
          style: AppTextStyles.bold21.copyWith(color: AppColors.primaryDarker),
        ),
        Text(
          '${widget.availableDeliveries.length} orders',
          style: AppTextStyles.reqular14.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    return ListView.separated(
      itemCount: widget.availableDeliveries.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.spacing16.h),
      itemBuilder: (context, index) {
        return AvailableOrderCard(
          delivery: widget.availableDeliveries[index],
          onAccept: () => _handleAcceptOrder(widget.availableDeliveries[index]),
        );
      },
    );
  }


  void _handleAcceptOrder(DeliveryModel delivery) {
    debugPrint('Accept order: ${delivery.id}');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DeliveryDetailScreen(delivery: delivery),
    //   ),
    // );
  }
}
