import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/full_image_dialog.dart';

class PrescriptionDialog extends StatelessWidget {
  final String prescriptionImage;

  const PrescriptionDialog({
    super.key,
    required this.prescriptionImage,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
        child: Container(
          padding: EdgeInsets.all(AppSizes.spacing16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlphaPercent(0.25),
              blurRadius: 16.8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Prescription',
              style: AppTextStyles.bold16.copyWith(
                color: AppColors.secondaryDarker1,
              ),
            ),
            SizedBox(height: AppSizes.spacing16.h),

            // Prescription Image
            Container(
              width: AppSizes.iconSize120.w,
              height: AppSizes.iconSize160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                image: DecorationImage(
                  image: AssetImage(prescriptionImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: AppSizes.spacing16.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => FullImageDialog(
                          prescriptionImage: prescriptionImage,
                          orderNumber: '123',
                          customerName: 'Eman Mohammed',
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNormal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
                    ),
                    child: Text(
                      'View full img',
                      style: AppTextStyles.semiBold16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
                      side: BorderSide.none,
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.semiBold16.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),)
    );
  }
}