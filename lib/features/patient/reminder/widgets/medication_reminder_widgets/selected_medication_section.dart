import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

/// 4) Selected medication block (matches figma)
/// - Outer card (white + border)
/// - Inner panel (light blue background)
/// - Header: image + title + subtitle + close (X)
/// - Info rows: Time / Days / Frequently with chips
/// - Actions: Create Reminder button + Adjust reminder text button
class SelectedMedicationSection extends StatelessWidget {
  final MedicineModel medicine;

  /// actions
  final VoidCallback onCreateReminder;
  final VoidCallback onClearSelection;
  final VoidCallback onAdjustReminder;

  /// temporary fixed data (you can connect later)
  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;

  const SelectedMedicationSection({
    super.key,
    required this.medicine,
    required this.onCreateReminder,
    required this.onClearSelection,
    required this.onAdjustReminder,
    this.times = const ['8:00am', '2:00pm', '9:00am'],
    this.days = const ['Saturday', 'Monday', 'Wednesday'],
    this.frequency = 'Daily',
    this.frequencyHint = 'until you finish the tablet',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutralNormal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// title
          Text(
            'Selected medication',
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.neutralDarkActive,
            ),
          ),
          SizedBox(height: 16.h),

          /// inner light panel
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                /// header row: image + texts + close button
                Row(
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

                    _CloseButton(onTap: onClearSelection),
                  ],
                ),

                SizedBox(height: 12.h),

                /// info rows
                _InfoRow(icon: Icons.access_time, label: 'Time:', chips: times),
                SizedBox(height: 12.h),

                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Days:',
                  chips: days,
                ),
                SizedBox(height: 12.h),

                _FrequencyRow(frequency: frequency, hint: frequencyHint),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// create reminder button (
          ///
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: Material(
              color: AppColors.primaryNormal,
              borderRadius: BorderRadius.circular(16.r),
              child: InkWell(
                onTap: onCreateReminder,
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Reminder',
                        style: AppTextStyles.semiBold14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SvgPicture.asset("assets/icons/add_reminder_icon.svg"),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 13.h),

          /// adjust reminder
          Center(
            child: InkWell(
              onTap: onAdjustReminder,
              child: Text(
                'Adjust reminder',
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// small ui pieces (refactor-friendly)
/// ------------------------------------------------------------

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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> chips;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/alarm_icon.svg",
                width: 20.w,
                height: 20.w,
              ),
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
            children: chips.map((t) => _Chip(text: t)).toList(),
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
        Container(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/alarm_icon.svg",
                width: 20.w,
                height: 20.w,
              ),
              SizedBox(width: 4.w),
              Text(
                "Frequently:",
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            children: [
              _Chip(text: frequency),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  ' •  $hint',
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.reqular8.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
        borderRadius: BorderRadius.circular(4.r),
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
