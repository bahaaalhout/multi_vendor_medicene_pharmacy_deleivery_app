import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectedMedicationPanel extends StatelessWidget {
  final MedicineModel medicine;

  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;

  final bool compact;
  final bool disableAdjust;

  final VoidCallback onRemove;
  final VoidCallback onAdjust;

  const SelectedMedicationPanel({
    super.key,
    required this.medicine,
    required this.times,
    required this.days,
    required this.frequency,
    required this.frequencyHint,
    required this.onRemove,
    required this.onAdjust,
    this.compact = false,
    this.disableAdjust = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.secondaryLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: _HeaderRow(medicine: medicine, onRemove: onRemove),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _HeaderRow(medicine: medicine, onRemove: onRemove),

          SizedBox(height: 12.h),

          _InfoRowWithAdjust(
            label: 'Time:',
            iconPath: "assets/icons/alarm_icon.svg",
            chips: times,
            onAdjust: onAdjust,
            disabled: disableAdjust,
          ),

          SizedBox(height: 12.h),

          _InfoRow(
            label: 'Days:',
            iconPath: "assets/icons/alarm_icon.svg",
            chips: days,
          ),

          SizedBox(height: 12.h),

          _FrequencyRow(frequency: frequency, hint: frequencyHint),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onRemove;

  const _HeaderRow({required this.medicine, required this.onRemove});

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
        _CloseButton(onTap: onRemove),
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
        child: SvgPicture.asset("assets/icons/close_icon.svg"),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutralLightActive),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium10.copyWith(
          color: AppColors.secondaryDarker,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String iconPath;
  final List<String> chips;

  const _InfoRow({
    required this.label,
    required this.iconPath,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 18.w, height: 18.w),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 4.w,
            runSpacing: 4.h,
            children: chips.map((t) => _Chip(text: t)).toList(),
          ),
        ),
      ],
    );
  }
}

class _InfoRowWithAdjust extends StatelessWidget {
  final String label;
  final String iconPath;
  final List<String> chips;
  final VoidCallback onAdjust;
  final bool disabled;

  const _InfoRowWithAdjust({
    required this.label,
    required this.iconPath,
    required this.chips,
    required this.onAdjust,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 18.w, height: 18.w),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: chips.map((t) => _Chip(text: t)).toList(),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: disabled ? null : onAdjust,
                child: Icon(
                  Icons.edit_outlined,
                  size: 18.w,
                  color: disabled
                      ? AppColors.neutralDark
                      : AppColors.primaryNormal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FrequencyRow extends StatelessWidget {
  final String frequency;
  final String hint;

  const _FrequencyRow({required this.frequency, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/alarm_icon.svg",
                width: 18.w,
                height: 18.w,
              ),
              SizedBox(width: 6.w),
              Text(
                "Frequently:",
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.w,
            children: [
              _Chip(text: frequency),
              Text(
                '• $hint',
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.reqular10.copyWith(
                  color: AppColors.successDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
