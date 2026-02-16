import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class UploadInventoryDialog extends StatelessWidget {
  const UploadInventoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffD9D9D9)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 24.r,
                          color: const Color(0xFF1F2937),
                        ),
                        2.horizontalSpace,
                        Text(
                          "Upload ",
                          style: AppTextStyles.bold20.copyWith(
                            color: AppColors.primaryNormal,
                          ),
                        ),
                        Text(
                          "Inventory File",
                          style: AppTextStyles.bold16.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Text(
                      "Upload Excel file to update your stock",
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralDarkHover,
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {},
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  dashPattern: const [6, 6],
                  color: AppColors.neutralDarkHover,
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        13.verticalSpace,
                        SvgPicture.asset(
                          "assets/icons/cloud_upload.svg",
                          width: 40,
                          height: 40,
                        ),
                        16.verticalSpace,
                        Text(
                          "Drag & drop Excel file",
                          style: AppTextStyles.medium16.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        16.verticalSpace,
                        Divider(color: AppColors.neutralNormal),

                        Text(
                          "Supported format .xlsx",
                          style: AppTextStyles.medium12.copyWith(
                            color: AppColors.neutralDarkHover,
                          ),
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),

              16.verticalSpace,

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.primaryNormal,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Confirm Upload",
                          style: AppTextStyles.semiBold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  8.horizontalSpace,

                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: AppTextStyles.semiBold16.copyWith(
                            color: AppColors.primaryNormal,
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
