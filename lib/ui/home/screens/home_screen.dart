import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/MedicineModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/PharmacyModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/pharmacyOfferModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/most_sales_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/section_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/welcome_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PharmacyOfferModel> offers = [
      PharmacyOfferModel(
        id: '1',
        isAvailable: true,
        price: 12.0,
        discountedPrice: 9.0,
        discountPercent: 25,
        pharmacy: PharmacyModel(
          id: 'p1',
          name: 'Al Shifa Pharmacy',
          rating: 4.6,
          reviewCount: 120,
          deliveryFee: 2.5,
        ),
        medicine: MedicineModel(
          id: 'm1',
          brandName: 'Panadol',
          genericName: 'Paracetamol',
          description: '',
          warnings: const [],
          form: FormType.tablet,
          quantity: 30,
          strength: '500mg',
          requiresPrescription: false,
          imageUrls: [""],
        ),
      ),
      PharmacyOfferModel(
        id: '1',
        isAvailable: true,
        price: 12.0,
        discountedPrice: 9.0,
        discountPercent: 25,
        pharmacy: PharmacyModel(
          id: 'p1',
          name: 'Al Shifa Pharmacy',
          rating: 4.6,
          reviewCount: 120,
          deliveryFee: 2.5,
        ),
        medicine: MedicineModel(
          id: 'm1',
          brandName: 'Panadol',
          genericName: 'Paracetamol',
          description: '',
          warnings: const [],
          form: FormType.tablet,
          quantity: 30,
          strength: '500mg',
          requiresPrescription: false,
          imageUrls: [""],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.neutralNormal,
      body: SafeArea(
        child: ListView(
          children: [
            WelcomeSection(),
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
                    SectionBar(
                      sectionTitle: 'Pharmacy Offers',
                      onPressed: () {},
                    ),
                    SectionBar(
                      sectionTitle: 'Nearby pharmacies',
                      onPressed: () {},
                    ),
                    SectionBar(sectionTitle: 'Categories', onPressed: () {}),
                    SectionBar(sectionTitle: 'Most Sales', onPressed: () {}),
                    MostSalesSection(offers: offers),
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
