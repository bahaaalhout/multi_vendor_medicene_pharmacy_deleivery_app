import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/sales_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/title_of_headers.dart';

class MostSalesSection extends StatelessWidget {
  const MostSalesSection({super.key, required this.sales});
  final List<MedicineModel> sales;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleOfHeaders(title: 'Most Sales', navigateToPage: () {}),
        SizedBox(height: 12),
        SizedBox(
          height: 200.h,

          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: sales.length,
            itemBuilder: (context, index) {
              return SalesItem(
                medicineModel: sales[index],
                pharmacy: pharmacies[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
