import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PharmacyIcon extends StatelessWidget {
  const PharmacyIcon({
    super.key,
    this.containerWidth = 40,
    this.containerHeight = 40,
    this.color = Colors.white,
  });
  final double? containerWidth;
  final double? containerHeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth!.w,
      height: containerHeight!.h,
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(
        'assets/icons/pharmacy.svg',
        width: 8.w,
        height: 8.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
