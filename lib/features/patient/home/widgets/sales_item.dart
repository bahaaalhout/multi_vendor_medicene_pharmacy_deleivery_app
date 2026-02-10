import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/screens/product_detail_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/widgets/medicine_form.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class SalesItem extends StatelessWidget {
  const SalesItem({
    super.key,
    required this.medicineModel,
    required this.pharmacy,
  });
  final MedicineModel medicineModel;
  final PharmacyModel pharmacy;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.push(AppRoutes.cart, extra: medicineModel);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Image.network(
                  medicineModel.imageUrls.first,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            SizedBox(
              width: 170.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    medicineModel.brandName,
                    style: AppTextStyles.bold14.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/Frame.svg'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7.h),
            SizedBox(
              width: 170.w,
              child: MedicineForm(medicineModel: medicineModel),
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${medicineModel.salesInfo!.discountedPrice}",
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "\$${medicineModel.salesInfo!.originalPrice}",
                  style: AppTextStyles.medium10.copyWith(
                    color: AppColors.neutralDark,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,

          child: Container(
            margin: EdgeInsets.only(left: 4.w, top: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.successDark,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: Text(
              "${medicineModel.salesInfo!.discountPercentage}% OFF",
              style: AppTextStyles.medium10.copyWith(
                color: AppColors.successLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
