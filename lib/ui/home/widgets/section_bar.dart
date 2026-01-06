import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SectionBar extends StatelessWidget {
  const SectionBar({
    super.key,
    required this.onPressed,
    required this.sectionTitle,
  });
  final void Function()? onPressed;
  final String sectionTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            sectionTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
          ),
        ),
        Text('see all', style: AppTextStyles.small),
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            'assets/icons/arrow_right_circle.svg',
            width: 24.r,
          ),
        ),
      ],
    );
  }
}
