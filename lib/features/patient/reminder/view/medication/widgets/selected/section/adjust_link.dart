import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AdjustLink extends StatelessWidget {
  final int count;
  final bool disabled;
  final VoidCallback onTap;

  const AdjustLink({
    super.key,
    required this.count,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Adjust reminder'
        : 'Adjust reminder time for $count Medications';

    return Center(
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Text(
          label,
          style: AppTextStyles.semiBold12.copyWith(
            color: disabled ? AppColors.neutralDark : AppColors.primaryNormal,
          ),
        ),
      ),
    );
  }
}
