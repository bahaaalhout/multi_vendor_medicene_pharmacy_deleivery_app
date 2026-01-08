import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/models/pharmacyOfferModel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/ui/home/widgets/medicine_card_widget.dart';

class MostSalesSection extends StatelessWidget {
  final List<PharmacyOfferModel> offers;
  const MostSalesSection({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          Expanded(child: MedicineCardWidget(offer: offers[0])),
          SizedBox(width: 12.w),
          Expanded(child: MedicineCardWidget(offer: offers[1])),
        ],
      ),
    );
  }
}
