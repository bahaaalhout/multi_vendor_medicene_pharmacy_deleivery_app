import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/add_to_cart_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/product_display.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/medicine_details_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/medicine_info_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/nearby_pharmacy_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/similar_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/warning_section.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.medicine,
    required this.pharmacy,
  });
  final MedicineModel medicine;
  final PharmacyModel pharmacy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryLight,

      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
              child: ProductDisplay(pharmacy: pharmacy, medicine: medicine),
            ),

            20.verticalSpace,
            Container(
              padding: EdgeInsets.all(16.r),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  MedicineDetailsSection(medicine: medicine),
                  16.verticalSpace,
                  NearbyPharmacy(),
                  16.verticalSpace,
                  MedicineInfoSection(medicine: medicine),
                  16.verticalSpace,
                  WarningSection(medicine: medicine),
                  16.verticalSpace,
                  SimilarSection(),
                  40.verticalSpace,
                  AddToCartSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
