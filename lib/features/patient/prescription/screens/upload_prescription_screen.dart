import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({super.key});

  @override
  State<UploadPrescriptionScreen> createState() =>
      _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2000,
        maxHeight: 2000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
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
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        "assets/icons/back.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Title
                  Expanded(
                    child: Text(
                      'Upload prescription',
                      style: GoogleFonts.montserrat(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 56.w), // Balance the back button width
                ],
              ),
            ),
            SizedBox(height: 10.h),
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
                      style: GoogleFonts.montserrat(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
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
                            style: GoogleFonts.montserrat(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Icon and description side by side
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/lock_outline.png",
                                width: 40.w,
                                height: 40.h,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Your prescription is secure and only shared with the selected pharmacy.',
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.textDark.withValues(
                                      alpha: 0.6,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
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
                          SizedBox(height: 50.h),
                          // File requirements text in two lines
                          Column(
                            children: [
                              Text(
                                'JPG or PNG · Max size 10 MB ·',
                                style: GoogleFonts.montserrat(
                                  color: AppColors.textDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Minimum 600×600 px',
                                style: GoogleFonts.montserrat(
                                  color: AppColors.textDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: 60.h),
                          // Upload file button
                          Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextButton(
                              onPressed: _pickImage,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Upload file',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          // Show selected image if available
                          if (_selectedImage != null) ...[
                            SizedBox(height: 24.h),
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
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
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
