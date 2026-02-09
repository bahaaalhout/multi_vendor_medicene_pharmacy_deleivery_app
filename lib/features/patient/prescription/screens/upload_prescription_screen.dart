import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/prescription/cubit/upload_prescription_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
class UploadPrescriptionScreen extends StatelessWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadPrescriptionCubit(),
      child: const _UploadPrescriptionView(),
    );
  }
}

class _UploadPrescriptionView extends StatelessWidget {
  const _UploadPrescriptionView();

  Future<void> _pickImage(BuildContext context) async {
    final cubit = context.read<UploadPrescriptionCubit>();
    final ImagePicker picker = ImagePicker();

    try {
      cubit.setLoading(true);
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
        imageQuality: 85,
      );

      if (image != null) {
        cubit.setSelectedImage(File(image.path));
      }
      cubit.setLoading(false);
    } catch (e) {
      cubit.setError('Error picking image: $e');
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
                  // Back button
                  NavigateBackButton(),
                  
                  // Title
                  20.horizontalSpace,
                  Text(
                    'Upload prescription',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
                    ),
                  ),
                  // Edit button
                  
                ],
              ),
            ),
            10.verticalSpace,
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Instructional text
                    Text(
                      'Upload a clear photo of your prescription to help us prepare your order accurately',
                      style: AppTextStyles.semiBold14.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    24.verticalSpace,
                    // Security Notice Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF9E6), // Light yellow-beige
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header text at the top
                          Text(
                            'A licensed pharmacist will review it',
                            style: AppTextStyles.semiBold16.copyWith(
                              color: AppColors.textDark,
                            ),
                          ),
                          12.verticalSpace,
                          // Icon and description side by side
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/lock_outline.png",
                                width: 40.w,
                                height: 40.h,
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Text(
                                  'Your prescription is secure and only shared with the selected pharmacy.',
                                  style: AppTextStyles.semiBold10.copyWith(
                                    color: AppColors.textDark.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                    // File Upload Area
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 80.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon
                          Image.asset(
                            "assets/icons/attach.png",
                            width: 50.w,
                            height: 50.h,
                          ),
                          50.verticalSpace,
                          // File requirements text in two lines
                          Column(
                            children: [
                              Text(
                                'JPG or PNG · Max size 10 MB ·',
                                style: AppTextStyles.reqular14.copyWith(
                                  color: AppColors.textDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              4.verticalSpace,
                              Text(
                                'Minimum 600×600 px',
                                style: AppTextStyles.reqular14.copyWith(
                                  color: AppColors.textDark,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          60.verticalSpace,
                          // Upload file button
                          Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextButton(
                              onPressed: () => _pickImage(context),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Upload file',
                                style: AppTextStyles.semiBold16.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Show selected image if available
                          BlocBuilder<UploadPrescriptionCubit, UploadPrescriptionState>(
                            builder: (context, state) {
                              if (state.selectedImage != null) {
                                return Column(
                                  children: [
                                    24.verticalSpace,
                                    Container(
                                      width: double.infinity,
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: AppColors.primaryBlue,
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12.r),
                                        child: Image.file(
                                          state.selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
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
}
