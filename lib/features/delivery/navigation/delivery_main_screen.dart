import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/screens/delivery_home_screen.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<DeliveryMainScreen> createState() => _DeliveryMainScreenState();
}

class _DeliveryMainScreenState extends State<DeliveryMainScreen> {
  int index = 0;

  late final List<Widget> data;

  @override
  void initState() {
    super.initState();
    index = widget.selectedIndex ?? 0;

    data = [
      const DeliveryHomeScreen(),
      const Center(child: Text('History')),
      const Center(child: Text('Deliveries')),
      const Center(child: Text('Profile')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: Stack(
        children: [
          Expanded(child: data[index]),
          Positioned(
            bottom: AppSizes.spacing16.h,
            left: AppSizes.spacing16.w,
            right: AppSizes.spacing16.w,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.spacing12.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(icon: Icons.home, label: 'Home', tabIndex: 0),
            _buildNavItem(icon: Icons.history, label: 'History', tabIndex: 1),
            _buildNavItem(
              icon: Icons.local_shipping,
              label: 'Deliveries',
              tabIndex: 2,
            ),
            _buildNavItem(icon: Icons.person, label: 'Profile', tabIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int tabIndex,
  }) {
    bool isActive = tabIndex == index;
    Widget iconTab = Column(
      children: [
        Icon(
          icon,
          size: AppSizes.iconSize18.r,
          color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker,
        ),
        SizedBox(height: AppSizes.spacing8.h),
        Text(
          label,
          style: AppTextStyles.medium10.copyWith(
            color: isActive ? AppColors.primaryNormal : AppColors.neutralDarker,
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: () {
        setState(() {
          index = tabIndex;
        });
      },
      child: isActive
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
          : iconTab,
    );
  }
}
