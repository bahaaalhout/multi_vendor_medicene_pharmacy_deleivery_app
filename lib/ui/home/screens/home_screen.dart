import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/categories.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/pharmacy_offers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/section_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    PharmacyOffers(),
                    SizedBox(height: 16.h),
                    SectionBar(
                      sectionTitle: 'Nearby pharmacies',
                      onPressed: () {},
                    ),
                    SizedBox(height: 16.h),
                    Categories(),
                    SizedBox(height: 16.h),
                    SectionBar(sectionTitle: 'Most Sales', onPressed: () {}),
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
