import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AppPrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onAction;
  final String? actionIconAsset;

  /// 👈 فلاغ لإظهار / إخفاء زر الباك
  final bool showBack;

  const AppPrimaryAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onAction,
    this.actionIconAsset,
    this.showBack = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(72.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16.h,
        ),
        child: Row(
          children: [
            if (showBack)
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
                  icon: SvgPicture.asset(
                    'assets/icons/back_icon.svg',
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
              )
            else
              SizedBox(width: 16.w),

            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: AppTextStyles.bold25.copyWith(
                    fontSize: 24.sp,
                    height: 1.5,
                    color: const Color(0xFF1B1F3C),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: IconButton(
                onPressed: onAction,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
                icon: SvgPicture.asset(
                  actionIconAsset ?? 'assets/icons/more_icon.svg',
                  width: 60.w,
                  height: 60.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
