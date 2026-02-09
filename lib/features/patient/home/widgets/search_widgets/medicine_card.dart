import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/pharmacy_icon.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/convert_formtype_tostring.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/styled_container.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    super.key,
    required this.medicine,
    required this.pharmacy,
  });
  final MedicineModel medicine;
  final PharmacyModel pharmacy;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 213.h,
      child: Card(
        elevation: 0,
        color: AppColors.neutralLight,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: AppColors.neutralLightActive,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/pandol.png',
                      width: 76.w,
                      height: 76.h,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicine.brandName,
                            style: AppTextStyles.bold16.copyWith(
                              color: AppColors.primaryDarker,
                            ),
                          ),
                          8.verticalSpace,
                          SizedBox(
                            height: 26,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                StyledContainer(
                                  horizontalPadding: 8,
                                  verticalPadding: 7,
                                  containerColor: AppColors.warningLightActive,
                                  text: medicine.requiresPrescription
                                      ? 'Prescription Required'
                                      : 'OTC',
                                  textStyle: AppTextStyles.semiBold10.copyWith(
                                    color: AppColors.warningDarker,
                                  ),
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColors.warningDark,
                                  ),
                                ),
                                4.horizontalSpace,
                                StyledContainer(
                                  horizontalPadding: 8,
                                  verticalPadding: 7,
                                  containerColor: AppColors.warningLightActive,
                                  text:
                                      '${medicine.quantity} ${ConvertFormtypeTostring.convertForm(medicine.form)}',
                                  textStyle: AppTextStyles.semiBold10.copyWith(
                                    color: AppColors.warningDarker,
                                  ),
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColors.warningDark,
                                  ),
                                ),
                                4.horizontalSpace,
                                StyledContainer(
                                  horizontalPadding: 8,
                                  verticalPadding: 7,
                                  containerColor: AppColors.warningLightActive,
                                  text: medicine.strength,
                                  textStyle: AppTextStyles.semiBold10.copyWith(
                                    color: AppColors.warningDarker,
                                  ),
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColors.warningDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          9.verticalSpace,
                          Row(
                            children: [
                              Text(
                                '\$${medicine.salesInfo?.discountedPrice ?? '0.0'}',
                                style: AppTextStyles.semiBold16.copyWith(
                                  color: AppColors.successDark,
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                '\$${medicine.salesInfo?.originalPrice ?? '0.0'}',
                                style: AppTextStyles.medium10.copyWith(
                                  color: AppColors.neutralDark,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                    child: SvgPicture.asset('assets/icons/voice.svg'),
                  ),
                ],
              ),
              12.verticalSpace,
              Container(
                height: 64,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PharmacyIcon(
                      containerHeight: 32,
                      containerWidth: 32,
                      color: AppColors.primaryLight,
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pharmacy.name,
                            style: AppTextStyles.semiBold14.copyWith(
                              color: AppColors.primaryDarkActive,
                            ),
                          ),
                          Text(
                            'Deliver . ${pharmacy.deliveryTime} | ${pharmacy.distance} km',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.successLightHover,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            'Avaliable',
                            style: AppTextStyles.semiBold10.copyWith(
                              color: AppColors.successDarker,
                            ),
                          ),
                          4.horizontalSpace,
                          SvgPicture.asset(
                            'assets/icons/check.svg',
                            width: 12.w,
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
