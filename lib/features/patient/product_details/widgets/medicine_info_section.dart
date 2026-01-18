import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/medicine_info_bar_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_text.dart';

class MedicineInfoSection extends StatefulWidget {
  const MedicineInfoSection({super.key, required this.medicine});
  final MedicineModel medicine;
  @override
  State<MedicineInfoSection> createState() => _MedicineInfoSectionState();
}

class _MedicineInfoSectionState extends State<MedicineInfoSection> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List info = [
      widget.medicine.details,
      widget.medicine.effects,
      widget.medicine.directions,
      widget.medicine.reviews,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(title: 'About'),
        12.verticalSpace,
        Container(
          padding: EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              MedicineInfoBarItem(
                tabIndex: 0,
                index: index,
                text: 'Details',
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
              MedicineInfoBarItem(
                tabIndex: 1,
                index: index,
                text: 'Effects',
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
              ),
              MedicineInfoBarItem(
                tabIndex: 2,
                index: index,
                text: 'Directions',
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
              ),
              MedicineInfoBarItem(
                tabIndex: 3,
                index: index,
                text: 'Reviews',
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
              ),
            ],
          ),
        ),
        8.verticalSpace,
        index == 3
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String text in info[3])
                    Text(text, style: AppTextStyles.reqular14),
                ],
              )
            : Text(info[index], style: AppTextStyles.reqular14),
      ],
    );
  }
}
