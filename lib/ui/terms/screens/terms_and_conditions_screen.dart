import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralLight,
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
                      'Terms & Conditions',
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
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By using this application, you agree to the Following Terms and Conditions:',
                      style: GoogleFonts.montserrat(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Main Content Area with dotted border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightBlue,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Introductory Text
                            SizedBox(height: 1.h),
                            // Terms List
                            _buildTermItem(
                              number: 1,
                              title: 'Use of the Service',
                              description:
                                  'This application allows you to upload medical prescriptions to licensed pharmacies to check the availability of medicines and receive price offers. The application does not provide medical advice and does not replace consultation with a doctor or pharmacist.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 2,
                              title: 'Medical Prescriptions',
                              description:
                                  'You are responsible for uploading clear, valid, and accurate prescriptions. The application is not responsible for any errors resulting from unclear images or incorrect information provided by you.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 3,
                              title: 'Pharmacy Responsibility',
                              description:
                                  'Pharmacies are responsible for reviewing prescriptions, confirming the availability of medicines, suggesting alternatives if necessary, providing final pricing and preparation time. The final decision to dispense medication rests with the pharmacy.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 4,
                              title: 'Pricing and Payments',
                              description:
                                  'Prices are set by pharmacies and may vary. The application is not responsible for any price changes after an order is confirmed.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 5,
                              title: 'Privacy and Data Protection',
                              description:
                                  'We are committed to protecting your data and medical prescriptions. Your information is shared only with the selected pharmacies for the purpose of fulfilling your request.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 6,
                              title: 'Order Cancellation',
                              description:
                                  'You can cancel your request before the pharmacy confirms it. After confirmation, cancellation is subject to the pharmacy\'s policy.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 7,
                              title: 'Limitation of Liability',
                              description:
                                  'The application is not liable for any misuse of medication or failure to follow medical or pharmaceutical instructions.',
                            ),
                            SizedBox(height: 20.h),
                            _buildTermItem(
                              number: 8,
                              title: 'Changes to Terms',
                              description:
                                  'The application reserves the right to update these terms at any time. You will be notified of any significant changes.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // Agreement Section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Instruction text with bullet point
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 6.h, right: 8.w),
                                child: Container(
                                  width: 4.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.textDark,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'By clicking on "I agree to.. " then you follow all the above instructions and information',
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.textDark,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Agreement checkbox with text
                          Row(
                            children: [
                              Checkbox(
                                value: isAgreed,
                                onChanged: (value) {
                                  setState(() {
                                    isAgreed = value ?? false;
                                  });
                                },
                                activeColor: AppColors.primaryBlue,
                                side: BorderSide(
                                  color: AppColors.lightBlue,
                                  width: 1.5,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'I agree to the Terms and Conditions',
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.primaryBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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

  Widget _buildTermItem({
    required int number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number
        Text(
          '$number. ',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Title and Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: GoogleFonts.montserrat(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

