import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/convert_formtype_tostring.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_container.dart';

class MedicineForm extends StatelessWidget {
  const MedicineForm({super.key, required this.medicineModel});

  final MedicineModel medicineModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            StyledContainer(
              horizontalPadding: 12,
              verticalPadding: 8,
              containerColor: AppColors.warningLightActive,
              text: medicineModel.requiresPrescription
                  ? 'Prescription Required'
                  : 'OTC',
              textStyle: AppTextStyles.semiBold12.copyWith(
                color: AppColors.warningDarker,
              ),
            ),
            4.horizontalSpace,
            StyledContainer(
              horizontalPadding: 12,
              verticalPadding: 8,
              containerColor: AppColors.warningLightActive,
              text:
                  '${medicineModel.quantity} ${ConvertFormtypeTostring.convertForm(medicineModel.form)}',
              textStyle: AppTextStyles.semiBold12.copyWith(
                color: AppColors.warningDarker,
              ),
            ),
            4.horizontalSpace,
            StyledContainer(
              horizontalPadding: 12,
              verticalPadding: 8,
              containerColor: AppColors.warningLightActive,
              text: medicineModel.strength,
              textStyle: AppTextStyles.semiBold12.copyWith(
                color: AppColors.warningDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
