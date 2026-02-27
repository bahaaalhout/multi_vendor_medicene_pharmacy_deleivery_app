import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/section_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/add_medicine_widgets/styled_text_field.dart';

class StockExpirySection extends StatelessWidget {
  final TextEditingController stockController;
  final TextEditingController expiryController;
  final String? Function(String?)? stockValidator;
  final String? Function(String?)? expiryValidator;
  const StockExpirySection({
    super.key,
    required this.stockController,
    required this.expiryController,
    this.stockValidator,
    this.expiryValidator,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Stock & Expiry",
      children: [
        Row(
          children: [
            StyledTextField(
              validator: stockValidator,
              controller: stockController,
              title: "Stock Quantity",
              textHint: "0",
              keyboardType: TextInputType.number,
            ),

            8.horizontalSpace,
            StyledTextField(
              controller: expiryController,
              validator: expiryValidator,
              title: "Expiry Date",
              textHint: "${DateTime.now()}",
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/calendar.svg'),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.all(12.w),
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
                  Text(
                    "Expires soon",
                    style: AppTextStyles.medium16.copyWith(color: Colors.black),
                  ),
                  Text(
                    "2 weeks left to expiry: 25 Jun 2026",
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.neutralDarkHover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
