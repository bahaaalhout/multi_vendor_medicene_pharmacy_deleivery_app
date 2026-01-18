import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/category_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/sales_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/categories_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/most_sales_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/nearby_pharmacies.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/pharmacy_offers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/welcome_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: ListView(
        children: [
          WelcomeSection(),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.r),
                topRight: Radius.circular(32.r),
              ),
            ),
            padding: EdgeInsets.only(
              top: 24.h,
              bottom: 8.h,
              right: 20.w,
              left: 20.w,
            ),
            child: Column(
              spacing: 20.h,
              children: [
                PharmacyOffers(),
                NearbyPharmacies(),
                CategoriesSection(categories: categories),
                MostSalesSection(sales: sales),
                108.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
