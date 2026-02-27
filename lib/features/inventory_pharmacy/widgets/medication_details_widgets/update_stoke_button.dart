import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/upload_inventory_dialog.dart';

class UpdateStockButton extends StatelessWidget {
  const UpdateStockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36.h,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => UploadInventoryDialog(),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10.r),
          backgroundColor: AppColors.primaryNormal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          "Update Stock",
          style: AppTextStyles.medium16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
