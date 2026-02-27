import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/panel/medicine_thumb.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/panel/medicine_title.dart';

class SelectedMedicationHeader extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onRemove;

  const SelectedMedicationHeader({
    super.key,
    required this.medicine,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MedicineThumb(imageUrl: medicine.imageUrls.first),
        SizedBox(width: 16.w),
        Expanded(
          child: MedicineTitle(
            title: medicine.brandName,
            subTitle: medicine.genericName,
          ),
        ),
        SizedBox(width: 16.w),
        CloseButton(onPressed: onRemove),
      ],
    );
  }
}
