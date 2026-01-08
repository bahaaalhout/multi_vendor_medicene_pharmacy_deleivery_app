import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.only(top: 24, bottom: 8, right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi 👋 Mohammed ',
                    style: AppTextStyles.small.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("26 Salah El Din St., Gaza", style: AppTextStyles.small),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 29.r,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: Badge(
                      alignment: Alignment(.5, -.6),
                      child: Icon(
                        Icons.notifications,
                        size: 20.r,
                        color: Colors.black,
                      ),
                    ),
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
          ),
          SizedBox(height: 20.h),
          SearchBar(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(AppColors.neutralLight),
            hintText: 'Search medicine, pharmacy..',
            hintStyle: WidgetStatePropertyAll(
              AppTextStyles.small.copyWith(color: AppColors.neutralDark),
            ),
            leading: Icon(Icons.search, size: 24.r),
            trailing: [Icon(Icons.mic, size: 24.r)],
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColors.neutralLight,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/rx.png',
                    width: 18.r,
                    height: 24.r,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Upload Prescription',
                  style: AppTextStyles.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Get medicines by pharmacist',
                  style: TextStyle(fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
