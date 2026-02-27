import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/orders/helpers/orders_tab.dart';

class OrderFilterTabs extends StatelessWidget {
  final OrdersTab selected;
  final ValueChanged<OrdersTab> onChanged;

  const OrderFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 4.w),
            _buildTab(label: 'All', tab: OrdersTab.all),
            SizedBox(width: 8.w),
            _buildTab(label: 'Active', tab: OrdersTab.active),
            SizedBox(width: 8.w),
            _buildTab(label: 'Delivered', tab: OrdersTab.delivered),
            SizedBox(width: 8.w),
            _buildTab(label: 'Canceled', tab: OrdersTab.cancelled),
            SizedBox(width: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({required String label, required OrdersTab tab}) {
    final bool isSelected = tab == selected;

    Color backgroundColor;
    Color textColor;
    FontWeight fontWeight;

    if (!isSelected) {
      backgroundColor = AppColors.primaryLight;
      textColor = AppColors.primaryDarker;
      fontWeight = FontWeight.w500;
    } else {
      if (tab == OrdersTab.all) {
        backgroundColor = AppColors.primaryDark;
        textColor = AppColors.primaryLightHover;
      } else {
        backgroundColor = AppColors.primaryNormal;
        textColor = AppColors.primaryLightHover;
      }
      fontWeight = FontWeight.w700;
    }

    return GestureDetector(
      onTap: () => onChanged(tab),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.medium12.copyWith(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
