import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_label.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_selector.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/helpers/notification_filter.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_empty_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_filter_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_list_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_section_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/rating_notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  DateTime selectedDate = DateTime.now();
  NotificationCategory selectedCategory = NotificationCategory.all;

  @override
  Widget build(BuildContext context) {
    final itemsForDate = notifications
        .where((n) => isSameDay(n.createdAt, selectedDate))
        .toList();

    final filteredItems = filterNotificationsByCategory(
      itemsForDate,
      selectedCategory,
    );

    final orderedItems = [...filteredItems]
      ..sort((a, b) {
        if (a.category == NotificationCategory.rating &&
            b.category != NotificationCategory.rating)
          return -1;
        if (b.category == NotificationCategory.rating &&
            a.category != NotificationCategory.rating)
          return 1;
        return 0;
      });

    final sectionTitle = {
      NotificationCategory.all: 'All Notifications',
      NotificationCategory.offer: 'Offers',
      NotificationCategory.medicineReminder: 'Medicine Reminders',
      NotificationCategory.rating: 'Rating',
    }[selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppPrimaryAppBar(
        title: 'Notification',
        onBack: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 54.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            NotificationFilterTabs(
              selected: selectedCategory,
              onChanged: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            SizedBox(height: 16.h),
            AppDateSelector(
              dateWidget: AppDateLabel(date: selectedDate),
              onPrev: _prevDay,
              onNext: _nextDay,
            ),
            SizedBox(height: 24.h),
            NotificationSectionHeader(
              title: sectionTitle,
              actionText: 'Mark as read',
              onAction: orderedItems.isEmpty ? null : _markCurrentAsRead,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: orderedItems.isEmpty
                  ? const NotificationEmptyState()
                  : ListView.separated(
                      padding: EdgeInsets.only(bottom: 24.h),
                      itemCount: orderedItems.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = orderedItems[index];

                        if (item.category == NotificationCategory.rating) {
                          return RatingNotificationCard(
                            item: item,
                            onRateNow: () {},
                            onClose: () {},
                          );
                        }

                        return NotificationListItem(item: item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _prevDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _markCurrentAsRead() {
    setState(() {
      for (final item in notifications) {
        if (isSameDay(item.createdAt, selectedDate)) {
          if (selectedCategory == NotificationCategory.all ||
              item.category == selectedCategory) {
            item.isRead = true;
          }
        }
      }
    });
  }
}
