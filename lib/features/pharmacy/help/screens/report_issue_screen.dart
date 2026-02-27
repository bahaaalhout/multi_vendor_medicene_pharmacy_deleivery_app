import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/help/cubit/report_issue_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

class ReportIssueScreen extends StatelessWidget {
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportIssueCubit(),
      child: const _ReportIssueView(),
    );
  }
}

class _ReportIssueView extends StatelessWidget {
  const _ReportIssueView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  NavigateBackButton(),
                  20.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Report an Issue',
                          style: AppTextStyles.bold25.copyWith(
                            fontSize: 24.sp,
                            height: 1.5,
                            color: const Color(0xFF1B1F3C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocConsumer<ReportIssueCubit, ReportIssueState>(
                  listener: (context, state) {
                    if (state.isSubmitted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Issue reported successfully'),
                          backgroundColor: AppColors.successNormal,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please provide clear details so we can help you faster.',
                          style: AppTextStyles.reqular14.copyWith(
                            color: AppColors.neutralDarkActive,
                          ),
                        ),
                        15.verticalSpace,
                        // Form Container
                        Container(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w, bottom: 80.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.primaryLightActive,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Select Order Field
                              Text(
                                'Select Order',
                                style: AppTextStyles.bold14.copyWith(
                                  color: AppColors.textDark,
                                ),
                              ),
                              12.verticalSpace,
                              GestureDetector(
                                onTap: () => _showOrderPicker(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.primaryLightActive,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.selectedOrder != null
                                            ? 'Order #${state.selectedOrder!.id}'
                                            : 'Select Order',
                                        style: AppTextStyles.reqular14.copyWith(
                                          color: state.selectedOrder != null
                                              ? AppColors.textDark
                                              : AppColors.neutralDark,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 24.sp,
                                        color: AppColors.neutralDark,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              24.verticalSpace,
                              // Describe Issue Field
                              
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.primaryLightActive,
                                    width: 1.5,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    context
                                        .read<ReportIssueCubit>()
                                        .updateDescription(value);
                                  },
                                  maxLines: 6,
                                  style: AppTextStyles.reqular14.copyWith(
                                    color: AppColors.textDark,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Describe the Issue',
                                    hintStyle: AppTextStyles.reqular14.copyWith(
                                      color: AppColors.neutralDark,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        100.verticalSpace,
                        // Submit Button
                        BlocBuilder<ReportIssueCubit, ReportIssueState>(
                          builder: (context, state) {
                            return Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: state.canSubmit
                                    ? AppColors.primaryBlue
                                    : AppColors.neutralNormal,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: state.canSubmit && !state.isLoading
                                    ? () {
                                        context
                                            .read<ReportIssueCubit>()
                                            .submitIssue();
                                      }
                                    : null,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: state.isLoading
                                    ? SizedBox(
                                        width: 24.w,
                                        height: 24.h,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : Text(
                                        'Submit the issues',
                                        style: AppTextStyles.reqular16
                                            .copyWith(color: Colors.white),
                                      ),
                              ),
                            );
                          },
                        ),
                        40.verticalSpace,
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderPicker(BuildContext context) {
    final cubit = context.read<ReportIssueCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) => BlocProvider.value(
        value: cubit,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.neutralNormal,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              20.verticalSpace,
              Text(
                'Select Order',
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.textDark,
                ),
              ),
              20.verticalSpace,
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sampleOrders.length,
                  itemBuilder: (listContext, index) {
                    final order = sampleOrders[index];
                    return ListTile(
                      title: Text(
                        'Order #${order.id}',
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      subtitle: Text(
                        '${order.pharmacyName} • ${_formatDate(order.createdAt)}',
                        style: AppTextStyles.reqular12.copyWith(
                          color: AppColors.neutralDark,
                        ),
                      ),
                      onTap: () {
                        cubit.selectOrder(order);
                        Navigator.pop(bottomSheetContext);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
