import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/add_reminder_widgets/reminder_list_item.dart';

class ReminderItemsList extends StatelessWidget {
  final List<ReminderItem> items;
  final EdgeInsets? padding;
  final bool scrollable;

  const ReminderItemsList({
    super.key,
    required this.items,
    this.padding,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    //if there is no reminders -> show empty state
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(248, 250, 254, 1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE9EDF3)),
        ),
        child: Text(
          'No events for this day',
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      );
    }
    //if there is reminders -> show list
    return ListView.separated(
      padding: padding ?? EdgeInsets.zero,
      itemCount: items.length,
      shrinkWrap: !scrollable,
      physics: scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, i) => ReminderListItem(item: items[i]),
    );
  }
}
