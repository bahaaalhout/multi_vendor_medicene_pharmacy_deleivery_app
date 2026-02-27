import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/drug_info_row.dart';

class DrugInfoSection extends StatelessWidget {
  const DrugInfoSection({super.key, required this.inventoryModel});
  final InventoryModel inventoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.neutralNormal),
              ),
            ),
            child: Text(
              'Drug Information',
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ),
          16.verticalSpace,
          InfoRow(
            label: "Generic Name:",
            value: inventoryModel.medicine?.name ?? "N/A",
          ),
          16.verticalSpace,
          InfoRow(
            label: "Brand Name:",
            value: inventoryModel.medicine?.name ?? "N/A",
          ),
          16.verticalSpace,
          InfoRow(
            label: "Category:",
            value: inventoryModel.medicine?.category ?? "N/A",
          ),
          16.verticalSpace,
          InfoRow(
            label: "Manufacturer:",
            value: inventoryModel.medicine?.manufacturer ?? "N/A",
          ),
          16.verticalSpace,
          InfoRow(
            label: "Prescription:",
            value: inventoryModel.medicine?.requiresPrescription == true
                ? "Yes"
                : "No",
          ),
        ],
      ),
    );
  }
}
