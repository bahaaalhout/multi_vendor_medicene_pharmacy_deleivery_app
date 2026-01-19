import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class NearbyPharmacyWidget extends StatelessWidget {
  const NearbyPharmacyWidget({
    super.key,
    required this.pharmacyModel,
    required this.imagePath,
  });
  final PharmacyModel pharmacyModel;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, width: 300.w, fit: BoxFit.fitWidth),
        Container(
          padding: EdgeInsets.all(12.r),
          width: 300.w,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.primaryLightActive, width: 1),
              left: BorderSide(color: AppColors.primaryLightActive, width: 1),
              right: BorderSide(color: AppColors.primaryLightActive, width: 1),
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,

                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                        child: Image.asset(
                          'assets/images/pharmacy.png',
                          width: 16.r,
                          height: 23.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'City Pharmacy',
                        style: AppTextStyles.bold17.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.star, size: 20.r, color: Colors.yellow),
                      SizedBox(width: 4.w),
                      Text(
                        '4.5',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                pharmacyModel.address.street,
                style: AppTextStyles.semiBold14,
              ),
              SizedBox(height: 2.h),
              Text(
                '${pharmacyModel.address.area}, ${pharmacyModel.address.city}',
                style: AppTextStyles.reqular12,
              ),
              SizedBox(height: 4.h),
              SizedBox(
                height: 30.h,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Chip(
                      backgroundColor: Colors.white,
                      avatar: Icon(
                        Icons.hourglass_top_outlined,
                        size: 16.r,
                        color: Color(0xff494949),
                      ),
                      label: Text(
                        '${pharmacyModel.distance} km',
                        style: AppTextStyles.medium10.copyWith(
                          color: AppColors.neutralDarkActive,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
