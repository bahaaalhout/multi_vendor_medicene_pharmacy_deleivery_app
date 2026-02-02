import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/widgets/history_filter_tab.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/history/widgets/order_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  const NavigateBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'History',
                        style: AppTextStyles.bold25.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.neutralDarker,
                        ),
                      ),
                    ),
                  ),
                  40.horizontalSpace,
                ],
              ),
            ),

            const HistoryFilterTabs(),
            10.verticalSpace,

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: const [
                  OrderCard(
                    id: "#O325",
                    pharmacyName: "Family Pharmacy",
                    street: "1852, Alkinz St.",
                    area: "Al Naser area, Gaza",
                    statusText: "Delivered on Des 18, 2025 at 3:58 PM",
                    statusColor: AppColors.successLight,
                    statusTextColor: AppColors.successDarker,
                    price: "21.48\$",
                  ),
                  SizedBox(height: 16),
                  OrderCard(
                    id: "#O326",
                    pharmacyName: "City Pharmacy",
                    street: "1852, Alkinz St.",
                    area: "Al Naser area, Gaza",
                    statusText: "Picked up on Des 18, 2025 at 3:58 PM",
                    statusColor: AppColors.warningLightActive,
                    statusTextColor: AppColors.warningDarker,
                    price: "21.48\$",
                  ),
                  SizedBox(height: 16),
                  OrderCard(
                    id: "#O326",
                    pharmacyName: "City Pharmacy",
                    street: "1852, Alkinz St.",
                    area: "Al Naser area, Gaza",
                    statusText: "Picked up on Des 18, 2025 at 3:58 PM",
                    statusColor: AppColors.warningLightActive,
                    statusTextColor: AppColors.warningDarker,
                    price: "21.48\$",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
