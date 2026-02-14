import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap everything in a BackdropFilter
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ), // Adjust blur intensity here
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow to keep it clean
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Red Warning Icon (Custom Circle)
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFEF2F2), // Light red background
                ),
                child: Icon(
                  Icons
                      .delete_outline_rounded, // Use a delete icon or exclamation
                  color: const Color(0xFFEF4444),
                  size: 32.r,
                ),
              ),
              16.verticalSpace,

              // Title
              Text(
                "Delete this medicine?",
                style: AppTextStyles.bold16.copyWith(
                  fontSize: 18.sp,
                  color: const Color(0xFF1F2937),
                ),
              ),
              8.verticalSpace,

              // Subtitle
              Text(
                "This medicine will no longer be available for new customer orders.",
                textAlign: TextAlign.center,
                style: AppTextStyles.medium14.copyWith(
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              24.verticalSpace,

              // Buttons Row
              Row(
                children: [
                  // Cancel Button (Grey/White)
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.semiBold16.copyWith(
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,

                  // Delete Button (Red)
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          onDelete();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Delete",
                          style: AppTextStyles.semiBold16.copyWith(
                            color: Colors.white,
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
