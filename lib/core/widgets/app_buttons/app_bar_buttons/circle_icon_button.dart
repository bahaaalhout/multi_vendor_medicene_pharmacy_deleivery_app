import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.assetIcon,
    required this.onPressed,
  });
  final String assetIcon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.iconSize60.r,
      width: AppSizes.iconSize60.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: AppColors.primaryLightActive),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(assetIcon),
      ),
    );
  }
}
