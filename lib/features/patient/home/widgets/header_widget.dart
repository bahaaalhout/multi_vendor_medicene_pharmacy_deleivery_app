import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/view/notifications_page.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class HeaderWidget extends StatelessWidget {
  final String name;
  final String location;
  final String? imageUrl;

  const HeaderWidget({
    super.key,
    required this.name,
    required this.location,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi 👋 $name',
              style: AppTextStyles.semiBold21.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
            Text(
              location,
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
              context.push(AppRoutes.notifications);
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
          radius: AppSizes.borderRadius30.r,
          backgroundColor: AppColors.neutralLight,
          foregroundImage: imageUrl != null
              ? NetworkImage(imageUrl!)
              : AssetImage('assets/images/girl.png'),
        ),
      ],
    );
  }
}
