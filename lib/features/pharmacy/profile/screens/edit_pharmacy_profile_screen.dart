import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/bottom_navigation_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/base_bottom_navigation_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/cubit/pharmacy_profile_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/profile/cubit/pharmacy_profile_state.dart';

class EditPharmacyProfileScreen extends StatelessWidget {
  const EditPharmacyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PharmacyProfileCubit>(),
      child: const _EditPharmacyProfileView(),
    );
  }
}

class _EditPharmacyProfileView extends StatelessWidget {
  const _EditPharmacyProfileView();

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final String formattedTime = picked.format(context).replaceAll(' ', '');
      if (isFrom) {
        context.read<PharmacyProfileCubit>().updateWorkingHoursFrom(
          formattedTime,
        );
      } else {
        context.read<PharmacyProfileCubit>().updateWorkingHoursTo(
          formattedTime,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- Top Bar ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NavigateBackButton(),
                  Text(
                    'Edit Profile',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                  SizedBox(width: 60.w),
                ],
              ),
            ),

            // --- Content ---
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Header
                        Center(
                          child: Column(
                            children: [
                              40.verticalSpace,
                              Image.asset(
                                "assets/icons/pharmacy-avatar.png",
                                width: 80.w,
                                height: 80.h,
                              ),
                              16.verticalSpace,
                              Text(
                                state.pharmacyName,
                                style: AppTextStyles.bold25.copyWith(
                                  color: AppColors.textDark,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        32.verticalSpace,
                        _buildSectionLabel('Address'),
                        10.verticalSpace,
                        _buildFlatTextField(
                          value: state.address,
                          onChanged: (value) => context
                              .read<PharmacyProfileCubit>()
                              .updateAddress(value),
                        ),
                        24.verticalSpace,

                        _buildSectionLabel('Working Hours'),
                        10.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: _buildTimeInput(
                                prefix: 'From: ',
                                time: state.workingHoursFrom,
                                onTap: () => _selectTime(context, true),
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: _buildTimeInput(
                                prefix: 'To: ',
                                time: state.workingHoursTo,
                                onTap: () => _selectTime(context, false),
                              ),
                            ),
                          ],
                        ),
                        24.verticalSpace,

                        _buildSectionLabel('Phone number'),
                        10.verticalSpace,
                        _buildPhoneField(
                          phoneCode: state.phoneCode,
                          phoneNumber: state.phoneNumber,
                          onPhoneCodeChanged: (code) => context
                              .read<PharmacyProfileCubit>()
                              .updatePhoneCode(code),
                          onPhoneNumberChanged: (num) => context
                              .read<PharmacyProfileCubit>()
                              .updatePhoneNumber(num),
                        ),
                        40.verticalSpace,
                      ],
                    );
                  },
                ),
              ),
            ),

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

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.semiBold16.copyWith(
        color:  AppColors.secondaryDarker1,
        
      ),
    );
  }

  Widget _buildTimeInput({
    required String prefix,
    required String time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.neutralLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Text(
              prefix,
              style: AppTextStyles.semiBold14.copyWith(
                color: AppColors.inactiveGray2,
              ),
            ),
            4.horizontalSpace,
            Expanded(
              child: Text(
                time,
                style: AppTextStyles.medium14.copyWith(
                  color: AppColors.inactiveGray2,
                ),
              ),
            ),
            Icon(
              Icons.access_time,
              size: 18.sp,
              color: AppColors.neutralDarkActive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatTextField({
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: TextEditingController(text: value)
          ..selection = TextSelection.collapsed(offset: value.length),
        onChanged: onChanged,
        style: AppTextStyles.medium14.copyWith(
          color: AppColors.inactiveGray1,
        ),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPhoneField({
    required String phoneCode,
    required String phoneNumber,
    required ValueChanged<String> onPhoneCodeChanged,
    required ValueChanged<String> onPhoneNumberChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          DropdownButton<String>(
            value: phoneCode,
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: AppColors.inactiveGray1,
            ),
            items: ['+970', '+972', '+1', '+20']
                .map(
                  (code) => DropdownMenuItem(
                    value: code,
                    child: Text(
                      code,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.inactiveGray1,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) =>
                value != null ? onPhoneCodeChanged(value) : null,
          ),
          16.horizontalSpace,
          Expanded(
            child: TextField(
              controller: TextEditingController(text: phoneNumber)
                ..selection = TextSelection.collapsed(
                  offset: phoneNumber.length,
                ),
              keyboardType: TextInputType.phone,
              onChanged: onPhoneNumberChanged,
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.inactiveGray1,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
