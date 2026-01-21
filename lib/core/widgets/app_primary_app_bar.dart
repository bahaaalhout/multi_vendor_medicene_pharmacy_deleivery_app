import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/more_button.dart';

class AppPrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onAction;
  final String? actionIconAsset;
  final bool showActionButton;

  /// 👈 فلاغ لإظهار / إخفاء زر الباك
  final bool showBack;

  const AppPrimaryAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onAction,
    this.actionIconAsset,
    this.showActionButton = true,
    this.showBack = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(72.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16.h,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSizes.spacing8.h),
          child: Row(
            children: [
              if (showBack)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 40.w,
                      minHeight: 40.w,
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/back_icon.svg',
                      width: 60.w,
                      height: 60.w,
                    ),
                  ),
                )
              else
                SizedBox(width: AppSizes.spacing60.w + AppSizes.spacing16.w),

              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                ),
              ),

              if (showActionButton)
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: MoreButton(fun: () {}),
                )
              else
                SizedBox(width: AppSizes.spacing60.w + AppSizes.spacing16.w),
            ],
          ),
        ),
      ),
    );
  }
}
