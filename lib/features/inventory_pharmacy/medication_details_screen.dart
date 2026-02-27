import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/drug_info_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/medicine_header_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/usage_instructions_section.dart';

class MedicineDetailsScreen extends StatelessWidget {
  // 🚀 2. Require the model in the constructor
  final InventoryModel inventoryItem;

  const MedicineDetailsScreen({super.key, required this.inventoryItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Medication Details",
          style: AppTextStyles.semiBold18.copyWith(
            color: AppColors.neutralDarkActive,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MedicineHeaderSection(inventoryModel: inventoryItem),
            16.verticalSpace,

            DrugInfoSection(inventoryModel: inventoryItem),

            16.verticalSpace,

            // You can pass the whole item or just the strings you need here
            UsageInstructionsSection(inventoryModel: inventoryItem),

            105.verticalSpace,
          ],
        ),
      ),
    );
  }
}
