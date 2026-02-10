import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/convert_formtype_tostring.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key, required this.recentItem});
  final Object recentItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: AppColors.primaryLight,
        elevation: 0,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 14.r,
            vertical: 16.r,
          ),
          child: Row(
            children: [
              Image.asset(
                recentItem is MedicineModel
                    ? 'assets/images/medicine shape.png'
                    : 'assets/images/pharmcy_shape.png',
                width: 16.w,
                height: 16.h,
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recentItem is PharmacyModel
                          ? (recentItem as PharmacyModel).name
                          : '${(recentItem as MedicineModel).brandName} ${(recentItem as MedicineModel).strength}',
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      recentItem is PharmacyModel
                          ? 'Deliver . ${(recentItem as PharmacyModel).deliveryTime} | ${(recentItem as PharmacyModel).distance} km'
                          : '${(recentItem as MedicineModel).type} . ${(recentItem as MedicineModel).quantity} ${ConvertFormtypeTostring.convertForm((recentItem as MedicineModel).form)}',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDarkHover,
                      ),
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
              SvgPicture.asset(
                'assets/icons/lucide_arrow-down.svg',
                width: 28.w,
                height: 28.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
