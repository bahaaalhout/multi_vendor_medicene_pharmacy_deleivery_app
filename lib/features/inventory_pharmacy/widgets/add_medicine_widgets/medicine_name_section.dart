import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class MedicineNameSection extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedType;
  final Function(String?) onTypeChanged;

  const MedicineNameSection({
    super.key,
    required this.nameController,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.neutralLightActive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medicine Name',
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.neutralNormalActive,
            ),
          ),

          16.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.neutralLightHover.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.neutralLightHover,
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 165.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primaryLight,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/add_with_circle.svg',
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
                16.horizontalSpace,
                SizedBox(
                  height: 36.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNormal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text(
                      "Add photo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          24.verticalSpace,
          Text(
            "Medicine Name",
            style: AppTextStyles.medium16.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          8.verticalSpace,
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                hintText: "Write medicine name",
                hintStyle: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralDark,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.neutralLightActive,
                    width: 1.w,
                  ),
                ),
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            "Type",
            style: AppTextStyles.medium16.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          8.verticalSpace,
          SizedBox(
            height: 50.h,
            child: DropdownButtonFormField<String>(
              items: [
                "Tablet",
                "Syrup",
                "Injection",
                "Cream",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onTypeChanged,
              decoration: InputDecoration(
                hintText: 'Tablet',
                hintStyle: AppTextStyles.reqular14.copyWith(
                  color: AppColors.neutralDark,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1.h,
                    color: AppColors.neutralLightActive,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
