import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const NavigateBackButton(),
                  ),
                  Text(
                    'Report',
                    style: AppTextStyles.bold25.copyWith(
                      fontSize: 24.sp,
                      height: 1.5,
                      color: const Color(0xFF1B1F3C),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppTextStyles.medium14.copyWith(
                          color: AppColors.neutralDarkHover,
                        ),
                        filled: true,
                        fillColor: AppColors.neutralLight,
                        prefixIcon: Image.asset(
                          'assets/icons/search.png',
                          width: 5.w,
                          height: 5.h,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          size: 22.sp,
                          color: AppColors.neutralDarkHover,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 22.h,
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    // Report Cards
                    _ReportCard(
                      image: 'assets/icons/report1.png',
                      title: 'Sales OverView',
                      subtitle: 'Monitor revenue and sales metrics',
                      isHighlighted: false,
                      onTap: () => context.push(AppRoutes.salesOverview),
                    ),
                    16.verticalSpace,
                    _ReportCard(
                      image: 'assets/icons/report2.png',
                      title: 'Low Stock Alert Trends',
                      subtitle: 'Track stock level alerts overtime',
                      isHighlighted: false,
                      onTap: () =>
                          context.push(AppRoutes.lowStockTrends),
                    ),
                    16.verticalSpace,
                    _ReportCard(
                      image: 'assets/icons/report3.png',
                      title: 'Medicine Usage Insights',
                      subtitle: 'Analyze popular medication and usage',
                      isHighlighted: false,
                      onTap: () =>
                          context.push(AppRoutes.medicineUsageInsights),
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

class _ReportCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _ReportCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  State<_ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<_ReportCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool active = _isPressed || widget.isHighlighted;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: active
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primaryNormal,
                    AppColors.secondaryNormalActive,
                    AppColors.primaryLightActive,
                  ],
                )
              : null,
          color: active ? null : AppColors.neutralLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Image.asset(
                widget.image,
                width: 24.w,
                height: 24.h,
                color: active ? Colors.white : AppColors.textDark,
              ),
            ),
            1.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.semiBold16.copyWith(
                      color: active ? Colors.white : AppColors.textDark,
                      height: 1.8,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    widget.subtitle,
                    style: AppTextStyles.reqular14.copyWith(
                      color: active
                          ? Colors.white.withOpacity(0.8)
                          : AppColors.neutralDarkHover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: active ? Colors.white : AppColors.secondaryDarker3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
