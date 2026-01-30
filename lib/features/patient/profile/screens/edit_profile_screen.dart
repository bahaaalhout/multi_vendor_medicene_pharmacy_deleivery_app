import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/cubit/edit_profile_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
        imageQuality: 85,
      );
      // Handle image selection here if needed
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
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
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  NavigateBackButton(),
                  50.horizontalSpace,
                  Text(
                    'Edit profile',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // Profile Picture Section
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                        return Container(
                          padding: EdgeInsets.all(24.w),
                          child: Column(
                            children: [
                              // Profile Picture
                              Stack(
                                children: [
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
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => _pickImage(context),
                                      child: Container(
                                        width: 36.w,
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryBlue,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              16.verticalSpace,
                              // Change photo button
                              ElevatedButton(
                                onPressed: () => _pickImage(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryLight,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Change photo',
                                  style: AppTextStyles.semiBold12.copyWith(
                                    color: AppColors.secondaryDarker,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Form Fields
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            // First name
                            CustomTextField(
                              label: 'First name',
                              value: state.firstName,
                              onChanged: (value) {
                                context
                                    .read<EditProfileCubit>()
                                    .updateFirstName(value);
                              },
                            ),
                            20.verticalSpace,
                            // Last name
                            CustomTextField(
                              label: 'Last name',
                              value: state.lastName,
                              onChanged: (value) {
                                context.read<EditProfileCubit>().updateLastName(
                                  value,
                                );
                              },
                            ),
                            20.verticalSpace,
                            // Email
                            CustomTextField(
                              label: 'Email',
                              value: state.email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                context.read<EditProfileCubit>().updateEmail(
                                  value,
                                );
                              },
                            ),
                            20.verticalSpace,
                            // Location
                            CustomTextField(
                              label: 'Location',
                              value: state.location,
                              onChanged: (value) {
                                context.read<EditProfileCubit>().updateLocation(
                                  value,
                                );
                              },
                            ),
                            20.verticalSpace,
                            // Phone
                            _buildPhoneField(
                              phoneCode: state.phoneCode,
                              phone: state.phone,
                              onPhoneChanged: (value) {
                                context.read<EditProfileCubit>().updatePhone(
                                  value,
                                );
                              },
                            ),
                            20.verticalSpace,
                            // Date of birth
                            _buildDateField(
                              value: state.dateOfBirth,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  final formattedDate =
                                      '${picked.day}-${picked.month}-${picked.year}';
                                  context
                                      .read<EditProfileCubit>()
                                      .updateDateOfBirth(formattedDate);
                                }
                              },
                            ),
                            20.verticalSpace,
                            // Password
                            _buildPasswordField(
                              value: state.password,
                              onChanged: (value) {
                                context.read<EditProfileCubit>().updatePassword(
                                  value,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    40.verticalSpace,
                    // Action Buttons
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            // Save change button
                            Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () async {
                                        await context
                                            .read<EditProfileCubit>()
                                            .saveChanges();
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: state.isLoading
                                    ? SizedBox(
                                        width: 24.w,
                                        height: 24.h,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : Text(
                                        'Save change',
                                        style: AppTextStyles.semiBold16
                                            .copyWith(color: Colors.white),
                                      ),
                              ),
                            ),
                            16.verticalSpace,
                            // Cancel button
                            Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryBlue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: AppTextStyles.semiBold16.copyWith(
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
            // Bottom gesture indicator
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                color: AppColors.neutralNormal,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField({
    required String phoneCode,
    required String phone,
    required ValueChanged<String> onPhoneChanged,
  }) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive, width: 1.5),
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutralLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. حاوية كود الدولة (الجزء الأيسر في الصورة)
          Container(
            height: 70.h, // ارتفاع أكبر قليلاً ليطابق مظهر الصورة
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors
                  .neutralLight, // الخلفية الرمادية الفاتحة من الكود السابق
              borderRadius: BorderRadius.circular(20.r), // حواف دائرية واضحة
              border: Border.all(
                color: AppColors.neutralLightActive.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // أيقونة العلم (يفضل استخدام صورة دائرية أو Emoji كبير)
                Text('🇪🇬', style: TextStyle(fontSize: 18.sp)),
                10.horizontalSpace,
                Text(
                  phoneCode,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
              ],
            ),
          ),

          12.horizontalSpace, // المسافة بين الحقلين
          // 2. حاوية رقم الهاتف (الجزء الأيمن في الصورة)
          Expanded(
            child: Container(
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.neutralLight,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.neutralLightActive.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // كلمة Phone في الأعلى بخط رمادي صغير
                  Text(
                    'Phone',
                    style: AppTextStyles.semiBold10.copyWith(
                      color: AppColors.neutralDark,
                    ),
                  ),
                  16.verticalSpace,
                  // حقل إدخال الرقم
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: phone)
                        ..selection = TextSelection.collapsed(
                          offset: phone.length,
                        ),
                      keyboardType: TextInputType.phone,
                      onChanged: onPhoneChanged,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.primaryDarker,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        hintText: '123456789',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.neutralLight, // الخلفية الرمادية كما في الحقل الآخر
          border: Border.all(
            color: AppColors.neutralLightActive, // نفس لون الإطار
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الحقل الصغير في الأعلى
            Text(
              'Date of birth',
              style: AppTextStyles.semiBold10.copyWith(
                color: AppColors.neutralDark, // نفس نمط الـ Label
              ),
            ),
            16.verticalSpace, // نفس المسافة الرأسية في CustomTextField
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // القيمة المختارة (التاريخ)
                Text(
                  value,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryDarker, // نفس لون خط الكتابة
                  ),
                ),
                // أيقونة التقويم
                Icon(
                  Icons
                      .calendar_month_outlined, // أيقونة أنيقة متناسبة مع التصميم
                  size: 20.sp,
                  color: AppColors
                      .neutralDark, // لون الأيقونة هادئ ليتناسب مع التصميم
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.neutralLight, // الخلفية الرمادية الموحدة
        border: Border.all(
          color: AppColors.neutralLightActive, // الإطار الموحد
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان العلوي الصغير
          Text(
            'Password',
            style: AppTextStyles.semiBold10.copyWith(
              color: AppColors.neutralDark,
            ),
          ),
          16.verticalSpace, // المسافة الموحدة بين العنوان والحقل
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.collapsed(offset: value.length),
                  obscureText: true,

                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: onChanged,
                ),
              ),
              // زر تغيير كلمة المرور
              ElevatedButton(
                onPressed: () => () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryLight,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Change',
                  style: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.secondaryDarker,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
