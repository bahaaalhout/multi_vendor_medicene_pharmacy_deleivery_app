import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class ReportIssueDialog extends StatefulWidget {
  final VoidCallback onSend;

  const ReportIssueDialog({
    super.key,
    required this.onSend,
  });

  @override
  State<ReportIssueDialog> createState() => _ReportIssueDialogState();
}

class _ReportIssueDialogState extends State<ReportIssueDialog> {
  final List<String> _reasons = [
    'Prescription image is unclear',
    'Prescription is expired',
    'Medication name or dosage is unclear',
    'Missing required information',
    'Other',
  ];
  
  int? _selectedReason;
  String _otherReasonText = '';
  int _characterCount = 0;

  void _selectReason(int index) {
    setState(() {
      _selectedReason = index;
      if (index != 4) {
        _otherReasonText = '';
        _characterCount = 0;
      }
    });
  }

  void _updateOtherReason(String text) {
    setState(() {
      _otherReasonText = text;
      _characterCount = text.length;
    });
  }

  bool get _canSend {
    if (_selectedReason == null) return false;
    if (_selectedReason == 4 && _otherReasonText.trim().isEmpty) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
        child: Container(
          padding: EdgeInsets.all(AppSizes.spacing16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlphaPercent(0.25),
                blurRadius: 16.8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Icon
              Column(
                children: [
                  // Exclamation Icon
                  Container(
                    width: AppSizes.iconSize32.w,
                    height: AppSizes.iconSize32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius4.r),
                    ),
                    child: Icon(Icons.error_outline, color: AppColors.errorNormal),
                  ),
                  SizedBox(height: AppSizes.spacing4.h),
                  
                  // Title
                  Text(
                    'Reason for request',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.secondaryDarker1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spacing24.h),

              // Reason Options
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w),
                child: Column(
                  children: [
                    // Reason List
                    Column(
                      children: _reasons.asMap().entries.map((entry) {
                        final index = entry.key;
                        final reason = entry.value;
                        final isSelected = _selectedReason == index;
                        
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => _selectReason(index),
                              child: Row(
                                children: [
                                  // Radio Button
                                  Container(
                                    width: AppSizes.iconSize14.w,
                                    height: AppSizes.iconSize14.h,
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.primaryNormal : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected 
                                          ? AppColors.primaryNormal 
                                          : AppColors.neutralNormal,
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.circular(AppSizes.borderRadius60.r),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: AppSizes.iconSize8.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: AppSizes.spacing8.w),
                                  
                                  // Reason Text
                                  Expanded(
                                    child: Text(
                                      reason,
                                      style: AppTextStyles.medium14.copyWith(
                                        color: AppColors.neutralDarkHover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if(index < 4) SizedBox(height: AppSizes.spacing24.h),
                          ],
                        );
                      }).toList()
                    ),

                    // Other Reason Text Field (only show if "Other" is selected)
                    if (_selectedReason == 4) ...[
                      Padding(
                        padding: EdgeInsets.all(AppSizes.spacing8.w),
                        child: Column(
                          children: [
                            // Text Field
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppSizes.spacing16.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.neutralNormal,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                              ),
                              child: TextField(
                                maxLines: 3,
                                maxLength: 250,
                                style: AppTextStyles.reqular12.copyWith(
                                  color: AppColors.neutralDarkHover,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Please describe why the prescription is unclear',
                                  hintStyle: AppTextStyles.reqular12.copyWith(
                                    color: AppColors.neutralNormal.withAlphaPercent(0.5),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: _updateOtherReason,
                              ),
                            ),
                            SizedBox(height: AppSizes.spacing8.h),
                            
                            // Character Counter
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$_characterCount / 250 characters',
                                  style: AppTextStyles.reqular10.copyWith(
                                    color: AppColors.neutralDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spacing16.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _canSend ? widget.onSend : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _canSend 
                          ? AppColors.primaryNormal 
                          : AppColors.primaryLightActive,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
                      ),
                      child: Text(
                        'Send',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing8.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
                        side: BorderSide.none,
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}