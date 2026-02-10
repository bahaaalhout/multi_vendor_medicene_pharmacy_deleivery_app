import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class TitleOfSectionCheckout extends StatelessWidget {
  const TitleOfSectionCheckout({
    super.key,
    required this.title,
    required this.fun,
  });
  final String title;
  final Function() fun;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.bold20),
        Spacer(),
        InkWell(
          onTap: fun,
          child: Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.r),
              border: Border.all(
                width: 1.w,
                color: AppColors.primaryLightActive,
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: null,
              icon: SvgPicture.asset('assets/icons/more_icon.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
