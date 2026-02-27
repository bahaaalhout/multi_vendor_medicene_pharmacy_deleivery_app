import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/base_bottom_navigation_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/pharmacy_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/cubit/pharmacy_profile_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/cubit/pharmacy_profile_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/screens/edit_pharmacy_profile_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/widgets/logout_confirmation_dialog.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/widgets/toggle.dart';

class PharmacyProfileScreen extends StatelessWidget {
  const PharmacyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyProfileCubit(),
      child: const _PharmacyProfileView(),
    );
  }
}

class _PharmacyProfileView extends StatelessWidget {
  const _PharmacyProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            const PharmacyAppBar(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Header
                    BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            // Profile Icon
                            40.verticalSpace,
                            Container(
                              child: Image.asset(
                                "assets/icons/pharmacy-avatar.png",
                              ),
                            ),
                            16.verticalSpace,
                            // Pharmacy Name
                            Text(
                              state.pharmacyName,
                              style: AppTextStyles.bold20.copyWith(
                                color: AppColors.secondaryDarker1,
                              ),
                            ),
                            16.verticalSpace,
                            // Edit Profile Button
                            Container(
                              width: 115.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryNormal,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final cubit =
                                      context.read<PharmacyProfileCubit>();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlocProvider.value(
                                        value: cubit,
                                        child: const EditPharmacyProfileScreen(),
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Edit Profile',
                                  style: AppTextStyles.reqular16.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    32.verticalSpace,
                    // Settings List
                    BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            // Accept New Order
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 20.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Accept New Order',
                                      style: AppTextStyles.semiBold16.copyWith(
                                        color: AppColors.secondaryDarker1,
                                      ),
                                    ),
                                    CustomToggle(
                                      value: state.acceptNewOrder,
                                      onToggle: (value) {
                                        context
                                            .read<PharmacyProfileCubit>()
                                            .toggleAcceptNewOrder(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Pharmacy information
                            _SettingsItem(
                              image: "assets/icons/address-book.png",
                              title: 'Pharmacy information',
                              onTap: () {},
                            ),
                            12.verticalSpace,
                            // Notification preferences
                            _SettingsItem(
                              image: "assets/icons/globe.png",
                              title: 'Notification preferences',
                              onTap: () {},
                            ),
                            12.verticalSpace,
                            // Working hours
                            _SettingsItem(
                              image: "assets/icons/oclock.png",
                              title: 'Working hours',
                              onTap: () {},
                            ),
                            12.verticalSpace,
                            // Terms & Conditions
                            _SettingsItem(
                              image: "assets/icons/sun.png",
                              title: 'Terms & Conditions',
                              onTap: () {},
                            ),
                            32.verticalSpace,
                            // Log out button
                            _LogoutButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const LogoutConfirmationDialog(),
                                );
                              },
                            ),
                            32.verticalSpace,
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: BaseBottomNavigationBar(
                items: [
                  BottomNavigationItem(
                    activeIcon: 'assets/icons/home_icon.svg',
                    label: 'Home',
                    tabIndex: 0,
                  ),
                  BottomNavigationItem(
                    activeIcon: 'assets/icons/order.svg',
                    label: 'Orders',
                    tabIndex: 1,
                  ),
                  BottomNavigationItem(
                    activeIcon: 'assets/icons/pharmacy.svg',
                    label: 'Inventory',
                    tabIndex: 2,
                  ),
                  BottomNavigationItem(
                    activeIcon: 'assets/icons/info.svg',
                    label: 'Report',
                    tabIndex: 3,
                  ),
                  BottomNavigationItem(
                    activeIcon: 'assets/icons/profile.svg',
                    label: 'Profile',
                    tabIndex: 4,
                  ),
                ],
                currentIndex: 4,
                onTap: (index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Item Widget
class _SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String image;
  const _SettingsItem({
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                // Icon
                Container(child: Image.asset(image)),
                10.horizontalSpace,
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.medium16.copyWith(
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                ),
                // Arrow
                Icon(
                  Icons.chevron_right,
                  size: 20.sp,
                  color: AppColors.neutralDarkHover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Logout Button Widget
class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Row(
              children: [
                // Logout Icon
                Image.asset('assets/icons/sign-out.png'),
                16.horizontalSpace,
                // Logout Text
                Expanded(
                  child: Text(
                    'Log out',
                    style: AppTextStyles.medium16.copyWith(
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
