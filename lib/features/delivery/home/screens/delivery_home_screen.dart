import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/screens/delivery_order_details_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/available_order_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/delivery_home_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/online_toggle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/home/widgets/review_alert.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  bool _isOnline = true;
  final String driverName = "Mohammed";
  final String driverLocation = "26 Salah El Din St., Gaza";
  final String? driverImageUrl = null;
  final bool hasReviewAlert = true;
  final List<DeliveryModel> availableDeliveries = fakeAvailableDeliveries;

  @override
  Widget build(BuildContext context) {
    double bottomPadding = AppSizes.spacing16.h * 2 + AppSizes.spacing80.h;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
          child: CustomScrollView(
            scrollBehavior: const ScrollBehavior().copyWith(scrollbars: false),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  DeliveyHomeHeader(
                    driverName: driverName,
                    driverLocation: driverLocation,
                    driverImageUrl: driverImageUrl,
                  ),
                  SizedBox(height: AppSizes.spacing16.h),
                  OnlineToggle(
                    isOnline: _isOnline,
                    onChanged: (value) {
                      setState(() {
                        _isOnline = value;
                      });
                    },
                  ),
                  SizedBox(height: AppSizes.spacing16.h),
                  if (hasReviewAlert) ReviewAlert(),
                  if (hasReviewAlert) SizedBox(height: AppSizes.spacing16.h),
                  _buildAvailableOrdersHeader(),
                  SizedBox(height: AppSizes.spacing16.h),
                ]),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      AvailableOrderCard(
                        delivery: availableDeliveries[index],
                        onAccept: () =>
                            _handleAcceptOrder(availableDeliveries[index]),
                      ),
                      if (index < availableDeliveries.length - 1)
                        SizedBox(height: AppSizes.spacing16.h),
                    ],
                  );
                }, childCount: availableDeliveries.length),
              ),
              SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
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
          '${availableDeliveries.length} orders',
          style: AppTextStyles.reqular14.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    return ListView.separated(
      itemCount: availableDeliveries.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.spacing16.h),
      itemBuilder: (context, index) {
        return AvailableOrderCard(
          delivery: availableDeliveries[index],
          onAccept: () => _handleAcceptOrder(availableDeliveries[index]),
        );
      },
    );
  }

  void _handleAcceptOrder(DeliveryModel delivery) {
    debugPrint('Accept order: ${delivery.id}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryOrderDetailScreen(delivery: delivery),
      ),
    );
  }
}
