import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onCopyId;
  final VoidCallback? onReorder;

  const OrderCard({
    super.key,
    required this.order,
    this.onCopyId,
    this.onReorder,
  });

  String get _formattedId => FormattingUtils.formatOrderId(order.id);
  
  String get _statusText {
    final date = order.createdAt;
    final month = _getMonthName(date.month);
    final day = date.day;
    final year = date.year;
    final hour = date.hour;
    final minute = date.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final displayMinute = minute.toString().padLeft(2, '0');
    
    switch (order.status) {
      case OrderStatus.delivered:
      case OrderStatus.receiveConfirmed:
        return 'Delivered on $month $day, $year at $displayHour:$displayMinute $period';
      case OrderStatus.pickedUp:
        return 'Picked up on $month $day, $year at $displayHour:$displayMinute $period';
      case OrderStatus.enRoute:
        return 'On the way on $month $day, $year at $displayHour:$displayMinute $period';
      case OrderStatus.placed:
        return 'Placed on $month $day, $year at $displayHour:$displayMinute $period';
    }
  }
  
  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Des'
    ];
    return months[month - 1];
  }
  
  Color get _statusColor {
    switch (order.status) {
      case OrderStatus.delivered:
      case OrderStatus.receiveConfirmed:
        return AppColors.successLight;
      case OrderStatus.pickedUp:
      case OrderStatus.enRoute:
        return AppColors.warningLightActive;
      case OrderStatus.placed:
        return AppColors.primaryLight;
    }
  }
  
  Color get _statusTextColor {
    switch (order.status) {
      case OrderStatus.delivered:
      case OrderStatus.receiveConfirmed:
        return AppColors.successDarker;
      case OrderStatus.pickedUp:
      case OrderStatus.enRoute:
        return AppColors.warningDarker;
      case OrderStatus.placed:
        return AppColors.primaryDarker;
    }
  }
  
  String get _totalPrice {
    final total = order.items.fold<double>(
      0.0,
      (sum, item) => sum + (item.pharmacyOffer.discountedPrice ?? item.pharmacyOffer.price) * item.quantity,
    );
    return FormattingUtils.formatPrice(total);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.neutralLightActive, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Order ID: ",
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralNormalActive,
                      ),
                    ),
                    TextSpan(
                      text: _formattedId,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.primaryBlue,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: order.id));
                  onCopyId?.call();
                },
                child: Text(
                  "Copy",
                  style: AppTextStyles.medium10.copyWith(
                    color: AppColors.neutralNormalActive,
                  ),
                ),
              ),
            ],
          ),

          Divider(height: 20.h, color: AppColors.neutralLightActive),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Image.asset('assets/images/healthicons_pharmacy.png'),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.pharmacyName,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${order.pharmacyAddress.city}, ${order.pharmacy.phone}",
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.neutralLight,
              border: Border.all(color: AppColors.neutralLightActive, width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/from.png'),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        order.deliveryAddress.street,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      2.verticalSpace,
                      Text(
                        "${order.deliveryAddress.area}, ${order.deliveryAddress.city}",
                        style: AppTextStyles.reqular12.copyWith(
                          color: AppColors.neutralDarkHover,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: _statusColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                _statusText,
                style: AppTextStyles.semiBold10.copyWith(
                  color: _statusTextColor,
                ),
              ),
            ),
          ),
          16.verticalSpace,
          Divider(height: 20.h, color: AppColors.neutralLightActive),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.neutralLightHover,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Product type ",
                              style: AppTextStyles.semiBold12.copyWith(
                                color: AppColors.neutralDarker,
                              ),
                            ),
                            TextSpan(
                              text: "(${order.totalItems} ${order.totalItems == 1 ? 'item' : 'items'})",
                              style: AppTextStyles.medium10.copyWith(
                                color: AppColors.neutralDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Quantity",
                        style: AppTextStyles.semiBold12.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                      ),
                    ],
                  ),
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/product-history.png",
                        fit: BoxFit.cover,
                      ),
                    ),

                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Show details",
                        style: AppTextStyles.semiBold12.copyWith(
                          color: AppColors.primaryBlue,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dotted,
                        ),
                      ),
                    ),

                    Text(
                      "x${order.totalItems}",
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.neutralDarker,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(height: 24.h, color: AppColors.neutralLightActive),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 36.h,
                child: OutlinedButton(
                  onPressed: onReorder,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.secondaryLightActive),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  ),
                  child: Text(
                    "Reorder",
                    style: AppTextStyles.bold12.copyWith(
                      color: AppColors.secondaryNormal,
                    ),
                  ),
                ),
              ),
              Text(
                _totalPrice,
                style: AppTextStyles.semiBold20.copyWith(
                  color: AppColors.successDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
