import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PharmacyIcon extends StatelessWidget {
  const PharmacyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.5),
      decoration: BoxDecoration(
        color: Colors.white,
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
