import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/screens/history_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/screens/edit_profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/saved/screens/saved_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/notification_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/settings_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/toggle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          );
                        },
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
              child: _ProfileCard(
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
                    _SettingsItem(
                      isSubItem: true,
                      icon: "assets/icons/history.png",
                      title: 'History',
                      subtitle: 'Orders & Activity',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(),
                          ),
                        );
                      },
                    ),
                    12.verticalSpace,
                    // Saved items
                    _SettingsItem(
                      isSubItem: true,
                      icon: "assets/icons/saved.png",
                      title: 'Saved items',
                      subtitle: 'medicines & Healthy products',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SavedScreen(),
                          ),
                        );
                      },
                    ),
                    12.verticalSpace,
                    // Medicine reminders
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return SettingsItem(
                          icon: "assets/icons/clock2.png",
                          title: 'Medicine reminders',
                          subtitle: 'Get reminders to refill your medicines',
                          hasToggle: true,
                          toggleValue: state.medicineRemindersEnabled,
                          onToggle: (value) {
                            context
                                .read<ProfileCubit>()
                                .toggleMedicineReminders(value);
                          },
                        );
                      },
                    ),
                    12.verticalSpace,
                    // Notification Card
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return NotificationCard(
                          notificationsEnabled: state.notificationsEnabled,
                          offersEnabled: state.offersEnabled,
                          orderTrackingEnabled: state.orderTrackingEnabled,
                          ratingRequestsEnabled: state.ratingRequestsEnabled,
                          onNotificationsToggle: (value) {
                            context.read<ProfileCubit>().toggleNotifications(
                              value,
                            );
                          },
                          onOffersToggle: (value) {
                            context.read<ProfileCubit>().toggleOffers(value);
                          },
                          onOrderTrackingToggle: (value) {
                            context.read<ProfileCubit>().toggleOrderTracking(
                              value,
                            );
                          },
                          onRatingRequestsToggle: (value) {
                            context.read<ProfileCubit>().toggleRatingRequests(
                              value,
                            );
                          },
                        );
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

// Profile Card Widget
class _ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: CustomPaint(
        child: Column(
          children: [
            // Avatar
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBlue,
              ),
              child: Image.asset(
                "assets/icons/person.png",
                width: 120.w,
                height: 120.h,
              ),
            ),
            16.verticalSpace,
            // Name
            Text(
              name,
              style: AppTextStyles.bold20.copyWith(color: AppColors.textDark),
            ),
            8.verticalSpace,
            // Email
            Text(
              email,
              style: AppTextStyles.medium14.copyWith(color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}

// Notification Card Widget
class _NotificationCard extends StatelessWidget {
  final bool notificationsEnabled;
  final bool offersEnabled;
  final bool orderTrackingEnabled;
  final bool ratingRequestsEnabled;
  final ValueChanged<bool> onNotificationsToggle;
  final ValueChanged<bool> onOffersToggle;
  final ValueChanged<bool> onOrderTrackingToggle;
  final ValueChanged<bool> onRatingRequestsToggle;

  const _NotificationCard({
    required this.notificationsEnabled,
    required this.offersEnabled,
    required this.orderTrackingEnabled,
    required this.ratingRequestsEnabled,
    required this.onNotificationsToggle,
    required this.onOffersToggle,
    required this.onOrderTrackingToggle,
    required this.onRatingRequestsToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlue,
                  ),
                  child: Image.asset(
                    "assets/icons/ring.png",
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.primaryBlue,
                  ),
                ),
                16.horizontalSpace,
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'Get access to edit your notifications',
                        style: AppTextStyles.reqular12.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main toggle
                CustomToggle(
                  value: notificationsEnabled,
                  onToggle: onNotificationsToggle,
                ),
              ],
            ),
          ),
          // Divider
          if (notificationsEnabled) ...[
            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            // Sub-items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
              child: Column(
                children: [
                  _NotificationSubItem(
                    title: 'Offers',
                    value: offersEnabled,
                    onToggle: onOffersToggle,
                  ),
                  30.verticalSpace,
                  _NotificationSubItem(
                    title: 'Order tracking',
                    value: orderTrackingEnabled,
                    onToggle: onOrderTrackingToggle,
                  ),
                  30.verticalSpace,
                  _NotificationSubItem(
                    title: 'Rating requests',
                    value: ratingRequestsEnabled,
                    onToggle: onRatingRequestsToggle,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Notification Sub Item Widget
class _NotificationSubItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onToggle;

  const _NotificationSubItem({
    required this.title,
    required this.value,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.reqular16.copyWith(color: AppColors.textDark),
        ),
        CustomToggle(value: value, onToggle: onToggle),
      ],
    );
  }
}

// Settings Item Widget
class _SettingsItem extends StatelessWidget {
  final String? icon;
  final String title;
  final String? subtitle;
  final bool hasToggle;
  final bool toggleValue;
  final Function(bool)? onToggle;
  final VoidCallback? onTap;
  final bool isSubItem;

  const _SettingsItem({
    this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.isSubItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
            child: Row(
              children: [
                // Icon (only if not a sub-item and icon is provided)
                if (!isSubItem && icon != null) ...[
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBlue,
                    ),
                    child: Image.asset(
                      icon!.toString(),
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  16.horizontalSpace,
                ],
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      if (subtitle != null && !isSubItem) ...[
                        8.verticalSpace,
                        Text(
                          subtitle!,
                          style: AppTextStyles.reqular12.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Toggle or arrow
                if (hasToggle)
                  CustomToggle(value: toggleValue, onToggle: onToggle!)
                else if (!isSubItem)
                  Image.asset(
                    "assets/icons/chevron_right.png",
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.primaryBlue,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
