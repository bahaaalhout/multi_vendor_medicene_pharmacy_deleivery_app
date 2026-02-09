import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/cubit/notifications_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/cubit/notifications_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_date_label.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_date_selector.dart';
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
  //DateTime selectedDate = DateTime.now();
  //NotificationCategory selectedCategory = NotificationCategory.all;

  //local copy of notifications (avoid modifying global data list)
  //late List<NotificationItem> localNotifications;

  // @override
  // void initState() {
  //   super.initState();
  //   //create a copy of global notifications list
  //   localNotifications = [...notifications];
  // }

  @override
  Widget build(BuildContext context) {
    // //get notifications for the selected day only
    // final itemsForDate = localNotifications
    //     .where((n) => isSameDay(n.createdAt, selectedDate))
    //     .toList();

    // //filter notifications by selected tab (category)
    // final filtered = filterNotificationsByCategory(
    //   itemsForDate,
    //   selectedCategory,
    // );

    // //sort notifications (rating first)
    // final ordered = sortNotifications(filtered);

    // //get section title based on selected category
    // final sectionTitle = getSectionTitle(selectedCategory);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppPrimaryAppBar(
      //   title: 'Notifications',
      //   actionWidget: MoreButton(
      //     fun: () {
      //       //open  menu / bottom sheet / dialog etc
      //     },
      //   ),
      // ),
      body: Container(
        margin: EdgeInsets.only(bottom: 54.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<NotificationsCubit, NotificationsStates>(
          listener: (context, state) {
            // //when error -> show error text
            if (state is NotificationsErrorState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(state.errorMsg),
              //     backgroundColor: Colors.redAccent,
              //     behavior: SnackBarBehavior.floating,
              //   ),
              // );
            }
          },
          builder: (context, state) {
            final cubit = context.read<NotificationsCubit>();

            // //when loading -> show progress
            if (state is NotificationsLoadingState) {
              //   return const Center(child: CircularProgressIndicator());
            }

            //when success -> build UI using state
            if (state is NotificationsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  //tabs filter
                  NotificationFilterTabs(
                    selected: state.selectedCategory,
                    onChanged: (category) {
                      // setState(() {
                      //   state.selectedCategory = category;
                      // });

                      //when user change tab -> reload notifications
                      cubit.changeCategory(state.selectedDate, category);
                    },
                  ),

                  SizedBox(height: 16.h),

                  //date selector (prev/next day)
                  NotificationDateSelector(
                    dateWidget: NotificationDateLabel(date: state.selectedDate),
                    // onPrev: _prevDay,
                    // onNext: _nextDay,
                    onPrev: () => cubit.prevDayPressed(
                      state.selectedDate,
                      state.selectedCategory,
                    ),
                    onNext: () => cubit.nextDayPressed(
                      state.selectedDate,
                      state.selectedCategory,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  //section header + mark as read action
                  NotificationSectionHeader(
                    title: state.sectionTitle,
                    actionText: 'Mark as read',
                    //onAction: ordered.isEmpty ? null : _markCurrentAsRead,
                    onAction: state.orderedItems.isEmpty
                        ? null
                        : () => cubit.markCurrentAsRead(
                            state.selectedDate,
                            state.selectedCategory,
                          ),
                  ),

                  SizedBox(height: 16.h),

                  Expanded(
                    //child: ordered.isEmpty
                    child: state.orderedItems.isEmpty
                        ? const NotificationEmptyState()
                        : ListView.separated(
                            padding: EdgeInsets.only(bottom: 24.h),
                            //itemCount: ordered.length,
                            itemCount: state.orderedItems.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              //final item = ordered[index];
                              final item = state.orderedItems[index];

                              //rating card special UI
                              if (item.category ==
                                  NotificationCategory.rating) {
                                return RatingNotificationCard(
                                  item: item,
                                  onRateNow: () {},
                                  onClose: () {},
                                );
                              }

                              //default list item UI
                              return NotificationListItem(item: item);
                            },
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // //when user click prev day -> minus 1 day from selectedDate then rebuild ui
  // void _prevDay() {
  //   setState(() {
  //     // selectedDate = selectedDate.subtract(const Duration(days: 1));
  //     selectedDate = prevDay(selectedDate);
  //   });
  // }

  // //when user click next day -> plus 1 day to selectedDate then rebuild ui
  // void _nextDay() {
  //   setState(() {
  //     //selectedDate = selectedDate.add(const Duration(days: 1));
  //     selectedDate = nextDay(selectedDate);
  //   });
  // }

  // //when user click mark as read -> mark only notifications for the selected day + selected category
  // void _markCurrentAsRead() {
  //   setState(() {
  //     for (final item in localNotifications) {
  //       //match selected day
  //       if (isSameDay(item.createdAt, selectedDate)) {
  //         if (selectedCategory == NotificationCategory.all ||
  //             item.category == selectedCategory) {
  //           item.isRead = true;
  //         }
  //       }
  //     }
  //   });
  // }
}
