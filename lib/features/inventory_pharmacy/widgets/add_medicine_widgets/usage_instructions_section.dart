import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/add_instraction.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/safety_item.dart';
import 'section_card.dart';

class UsageInstructionsSection extends StatelessWidget {
  final List<String> dosages;
  final List<String> storage;
  final Map<String, bool> safetyChecks;
  final Function(String, bool) onSafetyChanged;

  const UsageInstructionsSection({
    super.key,
    required this.dosages,
    required this.storage,
    required this.safetyChecks,
    required this.onSafetyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Usage & Instructions",
      children: [
        Text(
          "Dosage",
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        8.verticalSpace,
        ...dosages.map(
          (d) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: TextFormField(
              initialValue: d,
              style: AppTextStyles.reqular16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColors.neutralLightActive,
                  ),
                ),
              ),
            ),
          ),
        ),
        AddInstraction(hint: "Do not exceed 4 tablets per day", onTap: () {}),

        24.verticalSpace,

        Text(
          "Storage",
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        8.verticalSpace,
        ...storage.map(
          (s) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: TextFormField(
              initialValue: s,
              style: AppTextStyles.reqular16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColors.neutralLightActive,
                  ),
                ),
              ),
            ),
          ),
        ),
        AddInstraction(hint: "Away from moisture and heat", onTap: () {}),

        24.verticalSpace,

        Text(
          "Safety",
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        16.verticalSpace,
        ...safetyChecks.entries.map((entry) {
          return Column(
            children: [
              SafetyItem(
                text: entry.key,
                value: entry.value,
                onChanged: (val) => onSafetyChanged(entry.key, val),
              ),
              8.verticalSpace,
            ],
          );
        }),
      ],
    );
  }
}
