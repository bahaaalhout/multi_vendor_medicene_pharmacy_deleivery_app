import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class ReminderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback onMore;

  const ReminderAppBar({super.key, required this.onBack, required this.onMore});

  @override
  Size get preferredSize => Size.fromHeight(72.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      centerTitle: true,

      // نثبت ارتفاع شريط الأدوات
      toolbarHeight: 56.h,

      // نخلي المسافة تحت النوتش
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16.h,
        ),
        child: Row(
          children: [
            // LEFT
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: IconButton(
                onPressed: onBack,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
                icon: SvgPicture.asset(
                  "assets/icons/back_icon.svg",
                  width: 60.w,
                  height: 60.w,
                ),
              ),
            ),

            // TITLE
            Expanded(
              child: Center(
                child: Text(
                  'Add Reminder',
                  style: AppTextStyles.bold25.copyWith(
                    fontSize: 24.sp,
                    height: 1.5,
                    color: const Color(0xFF1B1F3C),
                  ),
                ),
              ),
            ),

            // RIGHT
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: IconButton(
                onPressed: onMore,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
                icon: SvgPicture.asset(
                  "assets/icons/more_icon.svg",
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
