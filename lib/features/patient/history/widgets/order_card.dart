import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final String id, pharmacyName, street, area, statusText, price;
  final Color statusColor, statusTextColor;

  const OrderCard({
    super.key,
    required this.id,
    required this.pharmacyName,
    required this.street,
    required this.area,
    required this.statusText,
    required this.price,
    required this.statusColor,
    required this.statusTextColor,
  });

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
                      text: id,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.primaryBlue,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Copy",
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.neutralNormalActive,
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
                      pharmacyName,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Gaza, (+970) 59-244-9634",
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
                        street,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      2.verticalSpace,
                      Text(
                        area,
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
              color: statusColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                statusText,
                style: AppTextStyles.semiBold10.copyWith(
                  color: statusTextColor,
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
                              text: "(4 items)",
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
                      "x4",
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
                  onPressed: () {},
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
                price,
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
