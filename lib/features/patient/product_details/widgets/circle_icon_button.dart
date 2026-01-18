import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

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
      width: 60.w,
      height: 60.h,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(width: 1, color: AppColors.primaryLightActive),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(assetIcon),
      ),
    );
  }
}
