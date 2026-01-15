import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  // Back button
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neutralLight,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.chevron_left,
                        size: 24.sp,
                        color: AppColors.textDark,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Title
                  Expanded(
                    child: Text(
                      'Terms & Conditions',
                      style: AppTextStyles.header3.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                    // Main Content Area with dotted border
                    _DottedBorderContainer(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Introductory Text
                            Text(
                              'By using this application, you agree to the Following Terms and Conditions:',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 24.h),
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
                    SizedBox(height: 20.h),
                    // Agreement Section with dotted border
                    _DottedBorderContainer(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By clicking on "I agree to.. "then you follow all the above instructions and information',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Agreement checkbox/button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAgreed = !isAgreed;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isAgreed,
                                    onChanged: (value) {
                                      setState(() {
                                        isAgreed = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.primaryBlue,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'I agree to the Terms and Conditions',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.primaryBlue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Dotted Border Container Widget
class _DottedBorderContainer extends StatelessWidget {
  final Widget child;

  const _DottedBorderContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: CustomPaint(
        painter: _DottedBorderPainter(
          color: AppColors.lightBlue,
          strokeWidth: 2,
          radius: 12.r,
        ),
        child: child,
      ),
    );
  }
}

// Dotted Border Painter
class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth = 5.0;
  final double dashSpace = 3.0;

  _DottedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final dashPath = _dashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path path, double dashWidth, double dashSpace) {
    final dashPath = Path();
    final pathMetrics = path.computeMetrics();

    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

