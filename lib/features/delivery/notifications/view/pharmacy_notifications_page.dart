import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/notifications/model/pharmacy_notification_item.dart';

import '../cubit/pharmacy_notifications_cubit.dart';
import '../cubit/pharmacy_notifications_states.dart';

//NOTE: use your existing widget if you have one for list item (without writing widget code here)
//If not, we can keep it simple with ListTile inside this page.
class PharmacyNotificationsPage extends StatefulWidget {
  const PharmacyNotificationsPage({super.key});

  @override
  State<PharmacyNotificationsPage> createState() =>
      _PharmacyNotificationsPageState();
}

class _PharmacyNotificationsPageState extends State<PharmacyNotificationsPage> {
  @override
  void initState() {
    super.initState();
    //load notifications once
    context.read<PharmacyNotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child:
              BlocBuilder<
                PharmacyNotificationsCubit,
                PharmacyNotificationsStates
              >(
                builder: (context, state) {
                  //when loading -> show progress
                  if (state is PharmacyNotificationsLoadingState) {
                    //return const Center(child: CircularProgressIndicator());
                  }

                  //when error -> show error text
                  if (state is PharmacyNotificationsErrorState) {
                    return Center(
                      child: Text(
                        state.errorMsg,
                        style: AppTextStyles.reqular14.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  //when success -> build UI using state
                  if (state is PharmacyNotificationsSuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18.h),

                        //top bar (like figma)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NavigateBackButton(),
                            Text(
                              'Notification',
                              style: AppTextStyles.bold25.copyWith(
                                height: 1.2,
                                color: AppColors.primaryDarker,
                              ),
                            ),
                            //optional action
                            IconButton(
                              onPressed: () => context
                                  .read<PharmacyNotificationsCubit>()
                                  .markAllAsRead(),
                              icon: const Icon(Icons.done_all_rounded),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        //list only (no tabs)
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 20.h),
                            itemCount: state.items.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final item = state.items[index];

                              //simple UI
                              return _PharmacyNotificationCard(item: item);
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
      ),
    );
  }
}

class _PharmacyNotificationCard extends StatelessWidget {
  final PharmacyNotificationItem item;

  const _PharmacyNotificationCard({required this.item});

  IconData _icon() {
    switch (item.type) {
      case PharmacyNotificationType.newOrderRequest:
        return Icons.notifications_active_outlined;
      case PharmacyNotificationType.prescriptionUnclear:
        return Icons.error_outline;
      case PharmacyNotificationType.lowStock:
        return Icons.inventory_2_outlined;
      case PharmacyNotificationType.orderReadyForPickup:
        return Icons.local_shipping_outlined;
    }
  }

  String _timeLabel() {
    final now = DateTime.now();
    final diff = now.difference(item.createdAt);

    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} h ago';
    return 'yesterday';
  }

  @override
  Widget build(BuildContext context) {
    final bg = item.isRead ? Colors.white : const Color(0xFFEAF0FF);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Icon(_icon(), size: 22.sp, color: AppColors.primaryDarker),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  item.description,
                  style: AppTextStyles.reqular12.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            _timeLabel(),
            style: AppTextStyles.reqular12.copyWith(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
