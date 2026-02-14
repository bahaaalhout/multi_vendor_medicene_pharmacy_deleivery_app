import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/section_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/switch_widget.dart';

class PrescriptionCategorySection extends StatelessWidget {
  final String selectedCategory;
  final bool requiresPrescription;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<bool> onPrescriptionChanged;

  const PrescriptionCategorySection({
    super.key,
    required this.selectedCategory,
    required this.requiresPrescription,
    required this.onCategoryChanged,
    required this.onPrescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Prescription & Category",
      children: [
        Text(
          "Category",
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        8.verticalSpace,
        SizedBox(
          height: 50.h,
          child: DropdownButtonFormField<String>(
            items: [
              "Analgesic",
              "Antibiotic",
              "Vitamin",
              "Other",
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onCategoryChanged,
            decoration: InputDecoration(
              hintText: 'Analgesic',
              hintStyle: AppTextStyles.reqular14.copyWith(
                color: AppColors.neutralDark,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1.h,
                  color: AppColors.neutralLightActive,
                ),
              ),
            ),
          ),
        ),
        24.verticalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Requires Prescription",
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
                SwitchWidget(
                  value: requiresPrescription,
                  onChanged: onPrescriptionChanged,
                ),
              ],
            ),
            4.verticalSpace,
            Text(
              "Customers must upload valid prescription before checkout",
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDarkHover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
