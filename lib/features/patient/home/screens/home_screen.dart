import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/MedicineModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/PharmacyModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/models/pharmacyOfferModel.dart';

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
      body: ListView(children: []),
    );
  }
}
