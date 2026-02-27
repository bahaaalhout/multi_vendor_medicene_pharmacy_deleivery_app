import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/section_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/styled_text_field.dart';

class PricingSection extends StatelessWidget {
  final TextEditingController basePriceController;
  final TextEditingController sellingPriceController;
  final String? Function(String?)? basePriceValidator;
  final String? Function(String?)? sellingPriceValidator;
  const PricingSection({
    super.key,
    required this.basePriceController,
    required this.sellingPriceController,
    this.basePriceValidator,
    this.sellingPriceValidator,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Pricing",
      children: [
        Row(
          children: [
            StyledTextField(
              controller: basePriceController,
              validator: basePriceValidator,
              title: "Base Price",
              textHint: "0.00",
              keyboardType: TextInputType.number,
            ),

            8.horizontalSpace,
            StyledTextField(
              controller: sellingPriceController,
              validator: sellingPriceValidator,
              title: "Selling Price",
              textHint: "0.00",
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        16.verticalSpace,

        RichText(
          text: TextSpan(
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.neutralDarkHover,
            ),
            children: [
              TextSpan(
                text: "Selling Price ",
                style: AppTextStyles.medium14.copyWith(
                  color: AppColors.neutralDarker,
                ),
              ),

              TextSpan(text: "is visible to customer"),
            ],
          ),
        ),
      ],
    );
  }
}
