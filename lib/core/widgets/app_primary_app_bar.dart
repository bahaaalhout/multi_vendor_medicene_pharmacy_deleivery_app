import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class AppPrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  //back button config
  final bool showBack;

  //action area config
  //screen passes ANY custom widget (upload, add, more, etc)
  final Widget? actionWidget;
  final bool showAction;

  const AppPrimaryAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actionWidget,
    this.showAction = true,
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

      //custom layout instead of default appBar
      flexibleSpace: Padding(
        //status bar spacing
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16.h,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSizes.spacing8.h),
          child: Row(
            children: [
              //----------------------------
              // BACK BUTTON (CUSTOM WIDGET)
              //----------------------------
              //if showBack = true -> show NavigateBackButton
              //else -> keep spacing to keep title centered
              if (showBack)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: const NavigateBackButton(),
                )
              else
                //keep spacing when back is hidden
                SizedBox(width: AppSizes.spacing60.w + AppSizes.spacing16.w),

              //----------------------------
              // TITLE
              //----------------------------
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

              //----------------------------
              // ACTION WIDGET
              //----------------------------
              //shown only if enabled AND widget is provided
              if (showAction && actionWidget != null)
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: actionWidget!,
                )
              else
                //keep spacing to keep title centered
                SizedBox(width: AppSizes.spacing60.w + AppSizes.spacing16.w),
            ],
          ),
        ),
      ),
    );
  }
}
