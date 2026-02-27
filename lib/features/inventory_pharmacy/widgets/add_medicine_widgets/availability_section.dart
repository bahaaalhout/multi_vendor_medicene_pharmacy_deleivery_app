import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/add_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/section_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/switch_widget.dart';

class AvailabilitySection extends StatelessWidget {
  final bool isVisible;
  final String currentStatus;
  final ValueChanged<bool> onVisibleChanged;
  final ValueChanged<String> onStatusChanged;

  const AvailabilitySection({
    super.key,
    required this.isVisible,
    required this.currentStatus,
    required this.onVisibleChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Availability",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Visible to customer",
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),
            SwitchWidget(value: isVisible, onChanged: onVisibleChanged),
          ],
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status:",
              style: AppTextStyles.reqular16.copyWith(
                color: Color(0xff666666).withValues(alpha: 0.4),
              ),
            ),
            4.horizontalSpace,
            StatusChip(
              label: "In Stock",
              bg: AppColors.successLightActive,
              isSelected: currentStatus == "In Stock",
              onTap: () => onStatusChanged("In Stock"),
            ),
            4.horizontalSpace,
            StatusChip(
              label: "Low Stock",
              bg: AppColors.warningLightActive,
              isSelected: currentStatus == "Low Stock",
              onTap: () => onStatusChanged("Low Stock"),
            ),
            4.horizontalSpace,
            StatusChip(
              label: "Out of Stock",
              bg: AppColors.errorLightActive,
              isSelected: currentStatus == "Out of Stock",
              onTap: () => onStatusChanged("Out of Stock"),
            ),
          ],
        ),
      ],
    );
  }
}
