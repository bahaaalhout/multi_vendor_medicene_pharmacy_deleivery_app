import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SafetyItem extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SafetyItem({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? AppColors.primaryNormal : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF3F5AA9), width: 2),
            ),
            child: value
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.reqular16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
