import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class SwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        value: value,

        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeThumbColor: Colors.white,
        inactiveThumbColor: Colors.white,
        activeTrackColor: AppColors.primaryDark,
        inactiveTrackColor: AppColors.primaryNormal,
        onChanged: onChanged,
      ),
    );
  }
}
