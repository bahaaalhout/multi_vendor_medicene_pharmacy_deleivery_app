import 'package:flutter/material.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class MedicineInfoBarItem extends StatelessWidget {
  const MedicineInfoBarItem({
    super.key,

    required this.tabIndex,
    required this.index,

    required this.text,
    required this.onTap,
  });
  final void Function()? onTap;
  final int tabIndex;
  final int index;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: index == tabIndex
            ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  text,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
              )
            : Center(child: Text(text, style: AppTextStyles.medium14)),
      ),
    );
  }
}
