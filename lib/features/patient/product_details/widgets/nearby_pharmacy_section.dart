import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/nearby_pharmacy_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class NearbyPharmacy extends StatelessWidget {
  const NearbyPharmacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors.primaryLightActive),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: StyledText(title: 'Nearby Pharmacies'),
          ),
          8.verticalSpace,
          //review !!
          for (int i = 0; i < 3; i++)
            NearbyPharmacyCard(pharmacy: pharmacies[i]),
        ],
      ),
    );
  }
}
