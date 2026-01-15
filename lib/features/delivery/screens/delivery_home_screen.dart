import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/available_order_card.dart';

class DeliveryHomeScreen extends StatefulWidget {
  final String driverName;
  final String driverLocation;
  final String? driverImageUrl;
  final bool hasReviewAlert;
  final List<DeliveryModel> availableDeliveries;

  const DeliveryHomeScreen({
    super.key,
    this.driverName = "Mohammed",
    this.driverLocation = "Gaza City",
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: AppSizes.spacing16.h),
              _buildOnlineToggle(),
              SizedBox(height: AppSizes.spacing16.h),
              if (widget.hasReviewAlert) _buildReviewAlert(),
              if (widget.hasReviewAlert) SizedBox(height: AppSizes.spacing16.h),
              _buildAvailableOrdersHeader(),
              SizedBox(height: AppSizes.spacing16.h),
              Expanded(child: _buildOrdersList()),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi 👋 ${widget.driverName}',
                  style: AppTextStyles.semiBold20.copyWith(
                    color: AppColors.primaryNormalActive,
                  ),
                ),
                SizedBox(height: AppSizes.spacing4.h),
                Text(
                  widget.driverLocation,
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: AppSizes.spacing60.w,
            height: AppSizes.spacing60.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.primaryNormal,
                    size: AppSizes.iconSize24.sp,
                  ),
                ),
                Positioned(
                  right: AppSizes.spacing14.w,
                  top: AppSizes.spacing14.h,
                  child: Container(
                    width: AppSizes.spacing8.w,
                    height: AppSizes.spacing8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.errorNormal,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.spacing12.w),
          _driverImage(),
        ],
      ),
    );
  }

  Widget _driverImage() {
    final hasImage = widget.driverImageUrl != null;
    return CircleAvatar(
      radius: AppSizes.borderRadius30.r,
      backgroundColor: AppColors.primaryLight,
      backgroundImage: hasImage ? NetworkImage(widget.driverImageUrl!) : null,
      child: hasImage
          ? null
          : Icon(Icons.person, size: AppSizes.iconSize28.sp, color: AppColors.primaryNormal),
    );
  }

  Widget _buildOnlineToggle() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('Online/Offline', style: AppTextStyles.reqular20),
          ),
          SizedBox(
            height: AppSizes.spacing34.h,
            child: Switch(
              value: _isOnline,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.successNormalHover,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: AppColors.neutralNormal,
              onChanged: (value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewAlert() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
        border: Border(
          left: BorderSide(color: AppColors.errorNormal, width: AppSizes.spacing3.w),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.error, color: AppColors.errorNormal, size: AppSizes.iconSize24.sp),
              SizedBox(width: AppSizes.spacing12.w),
              Expanded(
                child: Text(
                  'Delivery Needs Review',
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing12.w, vertical: AppSizes.spacing8.h),
                decoration: BoxDecoration(
                  color: AppColors.errorLightActive,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
                child: Text(
                  'Pending',
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.errorDarkActive,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacing12.h),
          GestureDetector(
            onTap: () {
              debugPrint('Review Details tapped');
            },
            child: Container(
              padding: EdgeInsets.all(AppSizes.spacing12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Review Details',
                    style: AppTextStyles.medium16.copyWith(
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                   SizedBox(width: AppSizes.spacing8.w),
                  Icon(
                    Icons.arrow_forward,
                    size: AppSizes.iconSize16.sp,
                    color: AppColors.neutralDarkActive,
                  ),
                ],
              ),
            ),
          ),
        ],
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
          deliveryModel: widget.availableDeliveries[index],
          onAccept: () => _handleAcceptOrder(widget.availableDeliveries[index]),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.spacing16.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spacing12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                isActive: true,
                tabIndex: 0,
              ),
              _buildNavItem(
                icon: Icons.history,
                label: 'History',
                isActive: false,
                tabIndex: 1,
              ),
              _buildNavItem(
                icon: Icons.local_shipping,
                label: 'Deliveries',
                isActive: false,
                tabIndex: 2,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                isActive: false,
                tabIndex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required int tabIndex,
  }) {
    Widget iconTab = Column(
      children: [
        Icon(icon, size: AppSizes.iconSize18.r, color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker),
        SizedBox(height: AppSizes.spacing8.h),
        Text(
          label,
          style: AppTextStyles.medium10.copyWith(
            color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker,
          ),
        ),
      ],
    );
    return isActive
        ? Container(
            width: AppSizes.spacing56.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: AppSizes.spacing8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: tabIndex == 0
                    ? Radius.circular(AppSizes.borderRadius16.r)
                    : Radius.circular(AppSizes.borderRadius8.r),
                right: tabIndex == 3
                    ? Radius.circular(AppSizes.borderRadius16.r)
                    : Radius.circular(AppSizes.borderRadius8.r),
              ),
            ),
            child: iconTab,
          )
        : iconTab;
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
