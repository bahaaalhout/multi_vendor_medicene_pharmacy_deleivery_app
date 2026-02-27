import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectedMedicationHeaderRow extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onRemove;

  final bool showRemove;

  const SelectedMedicationHeaderRow({
    super.key,
    required this.medicine,
    required this.onRemove,
    this.showRemove = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MedicineThumb(imageUrl: medicine.imageUrls.first),
        SizedBox(width: 16.w),
        Expanded(
          child: _MedicineTitle(
            title: medicine.brandName,
            subTitle: medicine.genericName,
          ),
        ),
        SizedBox(width: 16.w),

        if (showRemove) _CloseButton(onTap: onRemove),
      ],
    );
  }
}

class _MedicineThumb extends StatelessWidget {
  final String imageUrl;
  const _MedicineThumb({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.medication_outlined),
      ),
    );
  }
}

class _MedicineTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  const _MedicineTitle({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
        ),
        SizedBox(height: 4.h),
        Text(
          subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.reqular12.copyWith(
            color: AppColors.primaryDarkActive,
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neutralLightActive, width: 1),
        ),
        child: SvgPicture.asset("assets/icons/cancel_icon.svg"),
      ),
    );
  }
}
