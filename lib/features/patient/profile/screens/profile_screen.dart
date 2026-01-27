import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/profile_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/notification_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/settings_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool medicineRemindersEnabled = true;
  bool notificationsEnabled = true;
  bool offersEnabled = true;
  bool orderTrackingEnabled = true;
  bool ratingRequestsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  NavigateBackButton(),
                  // Title
                  Text(
                    'Profile',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                  // Edit button
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lightBlue,
                        width: 1.5,
                      ),
                      color: Colors.white,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30.w),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/basil_edit-outline.png",
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Profile Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ProfileCard(
                name: 'Mohammed Bassam',
                email: 'mhmd26@email.com',
              ),
            ),
            10.verticalSpace,
            // Settings List
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // History
                    SettingsItem(
                      icon: "assets/icons/history.png",
                      title: 'History',
                      subtitle: 'Orders & Activity',
                      onTap: () {},
                    ),
                    12.verticalSpace,
                    // Saved items
                    SettingsItem(
                      icon: "assets/icons/saved.png",
                      title: 'Saved items',
                      subtitle: 'medicines & Healthy products',
                      onTap: () {},
                    ),
                    12.verticalSpace,
                    // Medicine reminders
                    SettingsItem(
                      icon: "assets/icons/clock2.png",
                      title: 'Medicine reminders',
                      subtitle: 'Get reminders to refill your medicines',
                      hasToggle: true,
                      toggleValue: medicineRemindersEnabled,
                      onToggle: (value) {
                        setState(() {
                          medicineRemindersEnabled = value;
                        });
                      },
                    ),
                    12.verticalSpace,
                    // Notification Card
                    NotificationCard(
                      notificationsEnabled: notificationsEnabled,
                      offersEnabled: offersEnabled,
                      orderTrackingEnabled: orderTrackingEnabled,
                      ratingRequestsEnabled: ratingRequestsEnabled,
                      onNotificationsToggle: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                      onOffersToggle: (value) {
                        setState(() {
                          offersEnabled = value;
                        });
                      },
                      onOrderTrackingToggle: (value) {
                        setState(() {
                          orderTrackingEnabled = value;
                        });
                      },
                      onRatingRequestsToggle: (value) {
                        setState(() {
                          ratingRequestsEnabled = value;
                        });
                      },
                    ),
                    32.verticalSpace,
                    // Log out button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Log out',
                          style: AppTextStyles.bold25.copyWith(
                            fontSize: 14.sp,
                            height: 1.5,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    108.verticalSpace,
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
          ],
        ),
      ),
    );
  }
}
