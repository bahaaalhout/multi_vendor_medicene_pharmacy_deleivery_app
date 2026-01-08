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
      child: SizedBox(
        height: 252.h, // لازم ارتفاع
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: SizedBox(
                width: 180.w,
                child: MedicineCardWidget(offer: offers[0]),
              ),
            );
          },
        ),
      ),
    );
  }
}
