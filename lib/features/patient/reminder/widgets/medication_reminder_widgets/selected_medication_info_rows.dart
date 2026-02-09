import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/common_widgets/reminder_info_chip.dart';

class SelectedMedicationInfoRows extends StatelessWidget {
  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;

  const SelectedMedicationInfoRows({
    super.key,
    required this.times,
    required this.days,
    required this.frequency,
    required this.frequencyHint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //time row
        _InfoRow(label: 'Time:', chips: times),
        SizedBox(height: 12.h),

        //days row
        _InfoRow(label: 'Days:', chips: days),
        SizedBox(height: 12.h),

        //frequency row
        _FrequencyRow(frequency: frequency, hint: frequencyHint),
      ],
    );
  }
}

//----------------------------------
//generic info row (Time/Days)
//----------------------------------
class _InfoRow extends StatelessWidget {
  final String label;
  final List<String> chips;

  const _InfoRow({required this.label, required this.chips});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
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
            children: chips.map((t) => ReminderInfoChip(text: t)).toList(),
          ),
        ),
      ],
    );
  }
}

//----------------------------------
//frequency row
//----------------------------------
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
              ReminderInfoChip(text: frequency),
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
