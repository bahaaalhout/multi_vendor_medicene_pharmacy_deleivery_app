import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/add_medicine_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/medication_details_screen.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/inventory_pharmacy/widgets/inventory_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/careway.png",
                        width: 34.w,
                        height: 32.h,
                        opacity: AlwaysStoppedAnimation(0.3),
                      ),
                      8.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CureWay",
                            style: AppTextStyles.bold24.copyWith(
                              color: AppColors.primaryNormal,
                            ),
                          ),
                          Text(
                            "Pharmacy Name",
                            style: AppTextStyles.reqular12.copyWith(
                              color: AppColors.primaryNormalHover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/icons/notifications.svg"),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Inventory",
                    style: AppTextStyles.semiBold20.copyWith(
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.r,
                        color: AppColors.neutralLightActive,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "All Status",
                          style: AppTextStyles.reqular12.copyWith(
                            color: AppColors.neutralDarkActive,
                          ),
                        ),
                        8.horizontalSpace,
                        SvgPicture.asset(
                          'assets/icons/arrow-drop-down-big.svg',
                        ),
                        8.horizontalSpace,
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddMedicineScreen(),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/add_with_circle.svg',
                          ),
                        ),
                        8.horizontalSpace,
                        SvgPicture.asset('assets/icons/file.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: inventoryItems.length,
                separatorBuilder: (c, i) => 16.verticalSpace,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MedicineDetailsScreen(),
                      ),
                    ),
                    child: InventoryCard(item: inventoryItems[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
