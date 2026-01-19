import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi 👋 Mohammed ',
              style: AppTextStyles.semiBold21.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
            Text(
              "26 Salah El Din St., Gaza",
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.primaryLight,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsPage()),
              );
            },
            icon: SvgPicture.asset(
              'assets/images/notifications.svg',
              height: 20.h,
              width: 20.w,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.neutralLight,
          foregroundImage: AssetImage('assets/images/girl.png'),
        ),
      ],
    );
  }
}
