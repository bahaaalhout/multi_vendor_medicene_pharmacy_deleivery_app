import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class UploadInventoryDialog extends StatelessWidget {
  const UploadInventoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              Row(
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 24.r,
                    color: const Color(0xFF1F2937),
                  ),
                  8.horizontalSpace,
                  Text(
                    "Upload Inventory File",
                    style: AppTextStyles.bold16.copyWith(
                      fontSize: 18.sp,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Text(
                "Upload Excel file to update your stock",
                style: AppTextStyles.medium14.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              24.verticalSpace,

              // 2. Drag & Drop Zone
              // Note: Using a standard border here. For a dashed border,
              // you would typically use a package like 'dotted_border'.
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA), // Very light grey bg
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB), // Grey border
                    width: 1.5,
                    style: BorderStyle
                        .solid, // Use 'dotted_border' package for dashed
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 48.r,
                      color: const Color(0xFF1F2937),
                    ),
                    16.verticalSpace,
                    Text(
                      "Drag & drop Excel file",
                      style: AppTextStyles.semiBold16.copyWith(
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    16.verticalSpace,

                    // Divider line inside the box
                    Divider(color: const Color(0xFFE5E7EB), thickness: 1),
                    16.verticalSpace,

                    Text(
                      "Supported format .xlsx",
                      style: AppTextStyles.medium14.copyWith(
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              32.verticalSpace,

              // 3. Buttons Row
              Row(
                children: [
                  // Confirm Upload Button (Blue)
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle upload logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF3B5BA9,
                          ), // Primary Blue
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Confirm Upload",
                          style: AppTextStyles.bold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,

                  // Cancel Button (Grey/Light Blue)
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFEFF0F6,
                          ), // Light grey/blue
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.bold16.copyWith(
                            color: const Color(
                              0xFF3B5BA9,
                            ), // Text matches primary
                          ),
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
