import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/inventory_services.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/delete_confirmation_dialog.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/out_of_stock_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/update_stoke_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/medication_details_widgets/upload_inventory_dialog.dart';

class MedicineHeaderSection extends StatelessWidget {
  const MedicineHeaderSection({super.key, required this.inventoryModel});
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoryModel.medicine?.name ?? "Unknown Medicine",
                    style: AppTextStyles.bold16.copyWith(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    inventoryModel.medicine?.type ?? 'Unknown Type',
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.neutralDark,
                    ),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                  } else if (value == 'update') {
                    showDialog(
                      context: context,
                      builder: (context) => UploadInventoryDialog(),
                    );
                  } else if (value == 'delete') {
                    showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => DeleteConfirmationDialog(
                        onDelete: () async {
                          try {
                            await InventoryApiService().deleteMedicine(
                              inventoryModel.medicineId,
                            );
                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop(true);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to delete medicine: $e"),
                              ),
                            );
                          }
                        },
                      ),
                    ).then((wasDeleted) {
                      if (wasDeleted == true && context.mounted) {
                        context.pop();
                      }
                    });
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDarker,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'update',
                    child: Text(
                      'Update Stock',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDarker,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text(
                      'Delete Medication',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDarker,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          8.verticalSpace,
          Center(
            child: SvgPicture.asset(
              inventoryModel.medicine?.imageUrl ??
                  'assets/images/medicine_placeholder.svg',

              fit: BoxFit.contain,
            ),
          ),
          16.verticalSpace,

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.neutralLightActive,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/check.svg',
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.successNormal.withValues(alpha: 0.4),
                ),
                8.horizontalSpace,
                Text(
                  "Available (45 in stock)",
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.warningLightHover,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline, color: AppColors.errorNormalHover),
                8.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Expires soon", style: AppTextStyles.medium16),
                    4.verticalSpace,
                    Text(
                      "2 weeks left to expiry\n25Jun2025",
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.neutralDarkHover,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          24.verticalSpace,

          const UpdateStockButton(),
          16.verticalSpace,
          const OutOfStockButton(),
        ],
      ),
    );
  }
}
