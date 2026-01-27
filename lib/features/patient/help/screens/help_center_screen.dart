import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/help/cubit/help_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/help/screens/report_issue_screen.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCubit()..toggleSection(HelpSection.faqs),
      child: const _HelpCenterView(),
    );
  }
}

class _HelpCenterView extends StatelessWidget {
  const _HelpCenterView();

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Help Center',
                          style: AppTextStyles.bold25.copyWith(
                            fontSize: 24.sp,
                            height: 1.5,
                            color: const Color(0xFF1B1F3C),
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          'Get help, FAQs, and contact support',
                          style: AppTextStyles.reqular14.copyWith(
                            color: AppColors.secondaryDarker1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    20.verticalSpace,
                    // FAQs Section
                    _HelpSectionItem(
                      section: HelpSection.faqs,
                      imageUrl: 'assets/icons/question_mark.png',
                      title: 'FAQs',
                      child: _FAQsContent(),
                    ),
                    16.verticalSpace,
                    // Contact Support
                    _HelpSectionItem(
                      section: HelpSection.contactSupport,
                      imageUrl: 'assets/icons/envelope.png',
                      title: 'Contact Support',
                      child: _ContactSupportContent(),
                    ),
                    16.verticalSpace,
                    // Order Issues
                    _HelpSectionItem(
                      section: HelpSection.orderIssues,
                      imageUrl: 'assets/icons/issue.png',
                      title: 'Order Issues',
                      child: _OrderIssuesContent(),
                    ),
                    16.verticalSpace,
                    // Legal & Info
                    _HelpSectionItem(
                      section: HelpSection.legalInfo,
                      imageUrl: 'assets/icons/document.png',
                      title: 'Legal & Info',
                      child: _LegalInfoContent(),
                    ),
                    16.verticalSpace,
                    // Report an Issue
                    _HelpSectionItem(
                      section: HelpSection.reportIssue,
                      imageUrl: 'assets/icons/edit.png',
                      title: 'Report an Issue',
                      child: _ReportIssueContent(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportIssueScreen(),
                          ),
                        );
                      },
                    ),
                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpSectionItem extends StatelessWidget {
  final HelpSection section;
  final String imageUrl;
  final String title;
  final Widget child;
  final VoidCallback? onTap;

  const _HelpSectionItem({
    required this.section,
    required this.imageUrl,
    required this.title,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpCubit, HelpState>(
      builder: (context, state) {
        final isExpanded = state.isExpanded(section);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: isExpanded
                ? Border.all(color: AppColors.primaryLightActive, width: 1)
                : Border(
                    bottom: BorderSide(
                      color: AppColors.neutralLightActive,
                      width: 1,
                    ),
                  ),
          ),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap:
                      onTap ??
                      () {
                        context.read<HelpCubit>().toggleSection(section);
                      },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight,
                          ),
                          child: Image.asset(imageUrl),
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.semiBold16.copyWith(
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 24.sp,
                          color: AppColors.neutralDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (isExpanded && onTap == null) ...[
                Padding(
                  padding: EdgeInsets.only(left: 30.w, bottom: 30.w),
                  child: child,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// Reusable widget for bullet list content
class _BulletListContent extends StatelessWidget {
  final List<String> items;

  const _BulletListContent({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.h,
                    margin: EdgeInsets.only(top: 8.h, right: 12.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.interRegular14.copyWith(
                        color: AppColors.neutralDarkActive,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FAQsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BulletListContent(
      items: [
        'How do I upload a prescription?',
        'How long does it take to receive offers?',
        'Can I cancel a request?',
        'Is my prescription data secure?',
      ],
    );
  }
}

class _ContactSupportContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BulletListContent(items: ['Email support']);
  }
}

class _OrderIssuesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BulletListContent(
      items: [
        'Problem with an order',
        'Pharmacy did not respond',
        'Wrong medication',
      ],
    );
  }
}

class _LegalInfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BulletListContent(items: ['Privacy Policy']),
        4.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.lock_outline,
              size: 14.sp,
              color: AppColors.primaryNormal,
            ),
            4.horizontalSpace,
            Text(
              'Your data is protected',
              style: AppTextStyles.interRegular12.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ReportIssueContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Tap to report an issue with your order',
      style: AppTextStyles.reqular14.copyWith(color: AppColors.textDark),
    );
  }
}
