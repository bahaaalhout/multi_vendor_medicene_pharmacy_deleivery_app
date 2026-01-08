import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.deliveryTime,
    required this.distance,
    required this.rating,
    required this.ratingCount,
    required this.fee,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String deliveryTime;
  final String distance;
  final double rating;
  final int ratingCount;
  final int fee;

  /// Create a PharmacyCard directly from a domain [Pharmacy] model.
  factory PharmacyCard.fromPharmacy({
    Key? key,
    required Pharmacy pharmacy,
    String defaultDeliveryTime = '15 minutes',
    String defaultDistance = '2.5 km',
  }) {
    return PharmacyCard(
      key: key,
      id: pharmacy.id,
      name: pharmacy.name,
      imageUrl: pharmacy.imageUrl,
      deliveryTime: defaultDeliveryTime,
      distance: defaultDistance,
      rating: pharmacy.rating,
      ratingCount: pharmacy.reviewCount,
      fee: pharmacy.deliveryFee.round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withAlpha(77), width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top image / icon area
          Container(
            height: 100.h,
              decoration: BoxDecoration(
              color: AppColors.placeholder,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w, bottom: 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold,
                ),

                SizedBox(height: 12.h),

                // Deliver time and distance
                Row(
                  children: [
                    Text(
                      'Deliver · $deliveryTime | $distance',
                      style: AppTextStyles.small12,
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.r),
                        SizedBox(width: 4.w),
                        Text(
                          '${rating.toStringAsFixed(1)} ($ratingCount+ Rating)',
                          style: AppTextStyles.small12w500,
                        ),
                      ],
                    ),

                    // Fee chip
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.placeholder,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Delivery fees $fee\$',
                        style: AppTextStyles.small8w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
